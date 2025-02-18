from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

# Create the SQLite engine
engine = create_engine('sqlite:///local_data.db')
Base = declarative_base()

# Define the Group model
class Group(Base):
    __tablename__ = 'groups'
    
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    email = Column(String)
    users = relationship("User", back_populates="group")
    
# Define the User model
class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    group_id = Column(Integer, ForeignKey('groups.id'))
    email = Column(String, nullable=False)
    name = Column(String, nullable=False)
    phone = Column(String)
    group = relationship("Group", back_populates="users")

# Create all tables
Base.metadata.create_all(engine)

# Create a session
Session = sessionmaker(bind=engine)
session = Session()

# Add some test data
group1 = Group(name="Engineering", email="eng@example.com")
group2 = Group(name="Marketing", email="marketing@example.com")

user1 = User(name="John Doe", email="john@example.com", phone="555-1234", group=group1)
user2 = User(name="Jane Smith", email="jane@example.com", phone="555-5678", group=group1)
user3 = User(name="Mike Johnson", email="mike@example.com", phone="555-9012", group=group2)

session.add_all([group1, group2, user1, user2, user3])
session.commit()

print("Database created with test data!")
