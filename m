From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] omap: i2c: don't check bus state IP rev3.3 and earlier
Date: Tue, 25 Nov 2014 11:13:10 -0800
Message-ID: <7hvbm3jdq1.fsf@deeprootsystems.com>
References: <20141124210809.GG2817@atomide.com>
	<1416867655-22232-1-git-send-email-al.kochet@gmail.com>
	<20141125141924.GD1843@katana>
	<7E0A0B24-91D5-41A4-B007-004C5965D0D7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7E0A0B24-91D5-41A4-B007-004C5965D0D7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (Alexander
	Kochetkov's message of "Tue, 25 Nov 2014 17:38:23 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> 25 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 17:19, Wolfram Sang=
 <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0)=
:
>
>> I'll push out this evening to make the boot tests work again. If the=
re
>> is more to be investigated, either hurry up and post v3 ;) or let me
>> know that you need more time.
>
> Ok, thank you. Let the fix go to the kernel-next.
> Maybe small fix to subject "omap: i2c:" to "i2c: omap:"
>
> I still guessing what some boards have broken i2c pull-ups.
> And real fix must go in the board file.
> http://www.spinics.net/lists/linux-i2c/msg17750.html
>
> I could create a patch to confirm this.
> But I don't have omap3530 boards to run.
> I'll be very appreciated if someone could run the patch.

I'll test your patch on all my OMAP boards.  Put whatever debug output
you want, and I'll send you links to all the boot output.

Kevin
