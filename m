From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
 suspend
Date: Mon, 31 Jan 2011 11:22:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
References: <877hdl9hsn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877hdl9hsn.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-pm mailing list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 31 Jan 2011, Kevin Hilman wrote:

> I understand how this works, but frankly I'm still a bit fuzzy on why.
> 
> I guess I'm still missing a good understanding of what "interfering with a
> system power transition" means, and why a runtime suspend qualifies as
> interfering but not a runtime resume.

These are good questions.  Rafael implemented this design originally; 
my contribution was only to warn him of the potential for problems.  
Therefore he should explain the rationale for the design.

> More specifically, the reason for $SUBJECT patch is precisely because a
> runtime resume is allowed, a runtime suspend is not, and thus a system
> power transititon is prevented.

Alan Stern
