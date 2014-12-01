From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 0/2] i2c: omap: new fixes for driver
Date: Mon, 01 Dec 2014 12:04:57 -0800
Message-ID: <7hoarn3zme.fsf@deeprootsystems.com>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417294803-14729-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
	(Alexander Kochetkov's message of "Sun, 30 Nov 2014 01:00:01 +0400")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> The first patch fix i2c-omap driver for omap2420, found by code review and
> later reported by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> here[1].
> Candidate for stable?
>
> The second patch unhide the reson of system lockup.
>
> The patch is rebased on branch 'i2c/for-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> (6e79807443cba7397cd855ed29d6faba51d4c893)
>
> Tony, could you check, what the patches fix the problem reported[1]?
> Kevin, could you run tests for patches on all omap boards?

Done.  Built v3.18-rc7 + these 2 patches using omap2plus_defconfig. Boot
logs here for your amusement:

http://people.linaro.org/~khilman/tmp/v3.18-rc7-2-gdf84e23f2864/arm-omap2plus_defconfig/

Kevin
