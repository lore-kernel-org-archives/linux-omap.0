From: Tony Lindgren <tony@atomide.com>
Subject: Re: do not block sleep patch
Date: Thu, 26 Jun 2008 16:38:38 +0300
Message-ID: <20080626133837.GH12992@atomide.com>
References: <20080626133255.GA4593@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60497 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763483AbYFZNim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20080626133255.GA4593@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080626 16:34]:
> hi all,
>=20
> Resending the patch as it didn't get applied.
>=20
> Searching on the archives would be painful :-p

Thanks, one question below..

>=20
> --=20
> 	- Balbi

> From d8f7f708e32ad7daadf9e48e7ba0ebecdf91094c Mon Sep 17 00:00:00 200=
1
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Thu, 26 Jun 2008 16:31:44 +0300
> Subject: [PATCH] ARCH: OMAP: MUSB: Do not block sleep
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>=20
> Do not block sleep while musb clock is enabled
> as it completely blocks dynamic sleep.
>=20
> Thanks to Jouni H=C3=B6gander.
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb=
-musb.c
> index cbd59f8..d495549 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -58,14 +58,12 @@ static int musb_set_clock(struct clk *clk, int st=
ate)
>  		if (clk_on > 0)
>  			return -ENODEV;
> =20
> -		omap2_block_sleep();
>  		clk_enable(clk);
>  		clk_on =3D 1;
>  	} else {
>  		if (clk_on =3D=3D 0)
>  			return -ENODEV;
> =20
> -		clk_disable(clk);
>  		clk_on =3D 0;
>  		omap2_allow_sleep();
>  	}
> --=20

Did you mean to remove omap2_allow_sleep() instead of clk_disable()?

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
