From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: MUSB: Better sysconf reg settings on PM point of
	view
Date: Fri, 2 May 2008 15:57:00 -0700
Message-ID: <20080502225659.GU8981@atomide.com>
References: <1209467151-24972-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60134 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759265AbYEBW5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 18:57:01 -0400
Content-Disposition: inline
In-Reply-To: <1209467151-24972-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@nokia.com>

* Felipe Balbi <felipe.balbi@nokia.com> [080429 04:08]:
> The following patch is needed because usb is preventing core
> powerdomain to enter sleep state.
>=20
> Thanks to Jouni H=F6gander for pointing this

Pushing today.

=46YI, I'm putting together patches to get rid of the __REG32 and
__REG16 macros in order to get multi-omap booting working between
926, arm11, and cortex using the same kernel.

The __REG macros won't work for multi-omap when the IO
bases are different as these macros cannot be replaced by
functions in io.c.

Tony


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Jouni H=F6gander <jouni.hogander@nokia.com>
> ---
>  drivers/usb/musb/omap2430.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.=
c
> index e092393..36f1739 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -224,6 +224,14 @@ int __init musb_platform_init(struct musb *musb)
>  	musb->xceiv =3D *xceiv;
>  	musb_platform_resume(musb);
> =20
> +	OTG_SYSCONFIG_REG &=3D ~ENABLEWAKEUP;	/* disable wakeup */
> +	OTG_SYSCONFIG_REG &=3D ~NOSTDBY;		/* remove possible nostdby */
> +	OTG_SYSCONFIG_REG |=3D SMARTSTDBY;	/* enable smart standby */
> +	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
> +	OTG_SYSCONFIG_REG &=3D ~NOIDLE;		/* remove possible noidle */
> +	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
> +	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
> +
>  	OTG_INTERFSEL_REG |=3D ULPI_12PIN;
> =20
>  	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
> @@ -250,12 +258,8 @@ int musb_platform_suspend(struct musb *musb)
>  		return 0;
> =20
>  	/* in any role */
> -	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
> -	OTG_SYSCONFIG_REG &=3D FORCESTDBY;	/* enable force standby */
> -	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
> -	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
> -	OTG_FORCESTDBY_REG |=3D ENABLEFORCE; /* enable MSTANDBY */
> -	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
> +	OTG_FORCESTDBY_REG |=3D ENABLEFORCE;	/* enable MSTANDBY */
> +	OTG_SYSCONFIG_REG |=3D ENABLEWAKEUP;	/* enable wakeup */
> =20
>  	if (musb->xceiv.set_suspend)
>  		musb->xceiv.set_suspend(&musb->xceiv, 1);
> @@ -281,11 +285,8 @@ int musb_platform_resume(struct musb *musb)
>  	else
>  		clk_enable(musb->clock);
> =20
> -	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
> -	OTG_SYSCONFIG_REG |=3D SMARTSTDBY;	/* enable smart standby */
> -	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
> -	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
> -	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
> +	OTG_SYSCONFIG_REG &=3D ~ENABLEWAKEUP;	/* disable wakeup */
> +	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE;	/* disable MSTANDBY */
> =20
>  	return 0;
>  }
> --=20
> 1.5.5.1.99.gf0ec4
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
