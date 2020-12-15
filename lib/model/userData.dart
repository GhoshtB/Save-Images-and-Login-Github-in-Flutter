
class UserData {
    String avatar_url;
    Object bio;
    String blog;
    Object company;
    String created_at;
    Object email;
    String events_url;
    int followers;
    String followers_url;
    int following;
    String following_url;
    String gists_url;
    String gravatar_id;
    Object hireable;
    String html_url;
    int id;
    Object location;
    String login;
    Object name;
    String node_id;
    String organizations_url;
    int public_gists;
    int public_repos;
    String received_events_url;
    String repos_url;
    bool site_admin;
    String starred_url;
    String subscriptions_url;
    Object twitter_username;
    String type;
    String updated_at;
    String url;

  UserData({this.avatar_url, this.bio, this.blog, this.company, this.created_at, this.email, this.events_url, this.followers, this.followers_url, this.following, this.following_url, this.gists_url, this.gravatar_id, this.hireable, this.html_url, this.id, this.location, this.login, this.name, this.node_id, this.organizations_url, this.public_gists, this.public_repos, this.received_events_url, this.repos_url, this.site_admin, this.starred_url, this.subscriptions_url, this.twitter_username, this.type, this.updated_at, this.url});

    factory UserData.fromJson(Map<String, dynamic> json) {
        return UserData(
            avatar_url: json['avatar_url'],
            bio: json['bio'] = json['bio'],
            blog: json['blog'],
            company: json['company'] = json['company'],
            created_at: json['created_at'],
            email: json['email'] = json['email'],
            events_url: json['events_url'],
            followers: json['followers'],
            followers_url: json['followers_url'],
            following: json['following'],
            following_url: json['following_url'],
            gists_url: json['gists_url'],
            gravatar_id: json['gravatar_id'],
            hireable: json['hireable'] = json['hireable'],
            html_url: json['html_url'],
            id: json['id'],
            location: json['location'] =json['location'],
            login: json['login'],
            name: json['name'] = json['name'],
            node_id: json['node_id'],
            organizations_url: json['organizations_url'],
            public_gists: json['public_gists'],
            public_repos: json['public_repos'],
            received_events_url: json['received_events_url'],
            repos_url: json['repos_url'],
            site_admin: json['site_admin'],
            starred_url: json['starred_url'],
            subscriptions_url: json['subscriptions_url'],
            twitter_username: json['twitter_username'] = json['twitter_username'] ,
            type: json['type'],
            updated_at: json['updated_at'],
            url: json['url'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar_url'] = this.avatar_url;
        data['blog'] = this.blog;
        data['created_at'] = this.created_at;
        data['events_url'] = this.events_url;
        data['followers'] = this.followers;
        data['followers_url'] = this.followers_url;
        data['following'] = this.following;
        data['following_url'] = this.following_url;
        data['gists_url'] = this.gists_url;
        data['gravatar_id'] = this.gravatar_id;
        data['html_url'] = this.html_url;
        data['id'] = this.id;
        data['login'] = this.login;
        data['node_id'] = this.node_id;
        data['organizations_url'] = this.organizations_url;
        data['public_gists'] = this.public_gists;
        data['public_repos'] = this.public_repos;
        data['received_events_url'] = this.received_events_url;
        data['repos_url'] = this.repos_url;
        data['site_admin'] = this.site_admin;
        data['starred_url'] = this.starred_url;
        data['subscriptions_url'] = this.subscriptions_url;
        data['type'] = this.type;
        data['updated_at'] = this.updated_at;
        data['url'] = this.url;
        if (this.bio != null) {
            data['bio'] = this.bio;
        }
        if (this.company != null) {
            data['company'] = this.company;
        }
        if (this.email != null) {
            data['email'] = this.email;
        }
        if (this.hireable != null) {
            data['hireable'] = this.hireable;
        }
        if (this.location != null) {
            data['location'] = this.location;
        }
        if (this.name != null) {
            data['name'] = this.name;
        }
        if (this.twitter_username != null) {
            data['twitter_username'] = this.twitter_username;
        }
        return data;
    }
}