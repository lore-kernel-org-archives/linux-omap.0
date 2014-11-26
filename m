From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] omap: i2c: don't check bus state IP rev3.3 and earlier
Date: Wed, 26 Nov 2014 13:33:41 -0800
Message-ID: <7hvbm1d4ui.fsf@deeprootsystems.com>
References: <20141124210809.GG2817@atomide.com>
	<1416867655-22232-1-git-send-email-al.kochet@gmail.com>
	<20141125141924.GD1843@katana>
	<7E0A0B24-91D5-41A4-B007-004C5965D0D7@gmail.com>
	<7hvbm3jdq1.fsf@deeprootsystems.com>
	<65BAE81D-E894-48EB-B5A0-0D0FFB9B448F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <65BAE81D-E894-48EB-B5A0-0D0FFB9B448F-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (Alexander
	Kochetkov's message of "Wed, 26 Nov 2014 22:26:10 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> 25 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 22:13, Kevin Hilman=
 <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>
>> I'll test your patch on all my OMAP boards.  Put whatever debug outp=
ut
>> you want, and I'll send you links to all the boot output.
>
> Hello, Kevin!
>
> I've sent the patch[1]. Could you be so kind to run it on all your OM=
AP boards?
> Thank you very much!
> It is not urgent at all.

Done.  Built for omap2plus_defconfig, boot reports for all my OMAP
boards here:=20
http://people.linaro.org/~khilman/tmp/next-20141126-1-g760388ee02e4/arm=
-omap2plus_defconfig/

> What is the preferred way for giving patches for you (for future)?

Email is fine.  I have things fully automated for primary upstream tree=
s
(mainline, linux-next, stable, etc.) but for stuff like this, I can
trigger one-off tests.

However, if Tony wants to have a branch (besides the one already goes t=
o
linux-next) which I would add to the automation cycle, I'm willing to d=
o that.

> I have one more fixes for i2c-omap (I think final).
> I don't want to break tests anymore.
>
> And I found, that n900 boot test PASS, but in fact it doesn't[2].
> [2] http://status.armcloud.us/boot/omap3-n900/job/next/kernel/next-20=
141124/defconfig/arm-omap2plus_defconfig/

Right.  For these boot tests, PASS means it got to a userspace shell,
which it did.  The kernel got some warnings etc. during boot, but it
still booted up to a shell.

Kevin
