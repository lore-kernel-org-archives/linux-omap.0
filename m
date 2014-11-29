From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] i2c: omap: TEST: do IP reset during probe.
Date: Sat, 29 Nov 2014 14:06:19 -0800
Message-ID: <20141129220619.GZ2817@atomide.com>
References: <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
 <1417028722-29306-1-git-send-email-al.kochet@gmail.com>
 <7hzjbdd57j.fsf@deeprootsystems.com>
 <20141128221350.GW2817@atomide.com>
 <E4A4FA05-0752-41CB-B86B-84035C6EAF05@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E4A4FA05-0752-41CB-B86B-84035C6EAF05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141128 15:27]:
> Hello, Tony!
> 
> I just want to know, is multimaster i2c feature is interesting for TI SOC,
> so I could send another patches?

Sure and thanks for looking into fixing things.
 
> Or it's better to leave the thing without changes, as current single master version
> well tested and work?

Well once the fixes are in, I don't see any reason to not add
multimaster support.
 
> Also I have a draft version of mixed multimaster/slave version. But it could introduce new bugs.
> Are we ready for that? Thats because IP behavior, sometimes, doesn't correspond to TRMs[4][5].
> It's the one of strange IP I ever seen on TI SOC. And TRM not as detailed as DSP TRMs.

I think we can pretty easily test the i2c support before things get
merged. I guess it should then be possible to loop two i2c controllers
and run automated tests on them :)
 
> Looks, like you haven't seen my response in another thread[1].
> So, duplicate it here.

Sorry I guess I forgot to reply, let me know if I still missed something.

I'll give your two fixes a try on Monday hopefully.

Regards,

Tony
