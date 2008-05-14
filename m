From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARCH: OMAP: MUSB: Do not block sleep
Date: Wed, 14 May 2008 16:12:49 -0700
Message-ID: <20080514231248.GI8928@atomide.com>
References: <1210805485-2645-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62302 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYENXMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 19:12:50 -0400
Content-Disposition: inline
In-Reply-To: <1210805485-2645-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@nokia.com>

* Felipe Balbi <felipe.balbi@nokia.com> [080514 16:06]:
> Do not block sleep while musb clock is enabled
> as it completely blocks dynamic sleep.

Hmm, as far as I remember this will break all USB connections at least
on tusb if osc_ck is taken out. Can you check that?

Tony

>=20
> Thanks to Jouni H=F6gander.
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Jouni H=F6gander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb=
-musb.c
> index cbd59f8..bd3556b 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -58,7 +58,6 @@ static int musb_set_clock(struct clk *clk, int stat=
e)
>  		if (clk_on > 0)
>  			return -ENODEV;
> =20
> -		omap2_block_sleep();
>  		clk_enable(clk);
>  		clk_on =3D 1;
>  	} else {
> @@ -67,7 +66,6 @@ static int musb_set_clock(struct clk *clk, int stat=
e)
> =20
>  		clk_disable(clk);
>  		clk_on =3D 0;
> -		omap2_allow_sleep();
>  	}
> =20
>  	return 0;
> --=20
> 1.5.4.3.447.gc95b3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
