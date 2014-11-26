From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] omap: i2c: don't check bus state IP rev3.3 and earlier
Date: Wed, 26 Nov 2014 22:26:10 +0300
Message-ID: <65BAE81D-E894-48EB-B5A0-0D0FFB9B448F@gmail.com>
References: <20141124210809.GG2817@atomide.com> <1416867655-22232-1-git-send-email-al.kochet@gmail.com> <20141125141924.GD1843@katana> <7E0A0B24-91D5-41A4-B007-004C5965D0D7@gmail.com> <7hvbm3jdq1.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7hvbm3jdq1.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


25 =CE=CF=D1=C2. 2014 =C7., =D7 22:13, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org=
> =CE=C1=D0=C9=D3=C1=CC(=C1):

> I'll test your patch on all my OMAP boards.  Put whatever debug outpu=
t
> you want, and I'll send you links to all the boot output.

Hello, Kevin!

I've sent the patch[1]. Could you be so kind to run it on all your OMAP=
 boards?
Thank you very much!
It is not urgent at all.

What is the preferred way for giving patches for you (for future)?
I have one more fixes for i2c-omap (I think final).
I don't want to break tests anymore.

And I found, that n900 boot test PASS, but in fact it doesn't[2].

Alexander.

[1] http://marc.info/?l=3Dlinux-i2c&m=3D141702877518332&w=3D2
[2] http://status.armcloud.us/boot/omap3-n900/job/next/kernel/next-2014=
1124/defconfig/arm-omap2plus_defconfig/
