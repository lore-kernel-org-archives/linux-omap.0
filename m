From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
Date: Thu, 8 Mar 2012 12:46:07 -0800
Message-ID: <20120308204607.GX12083@atomide.com>
References: <20120308204328.GW12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49802 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2CHUqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 15:46:09 -0500
Content-Disposition: inline
In-Reply-To: <20120308204328.GW12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120308 12:11]:
> Otherwise we will get:
>=20
> arch/arm/plat-omap/fb.c:101: error: expected =E2=80=98)=E2=80=99 befo=
re =E2=80=98*=E2=80=99 token
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> Tomi, you need something like this for what you have in for-next.
>=20
> --- a/arch/arm/plat-omap/fb.c
> +++ b/arch/arm/plat-omap/fb.c
> @@ -98,6 +98,8 @@ arch_initcall(omap_init_fb);
> =20
>  #else
> =20
> -void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
> +void __init omapfb_set_lcd_config(const struct omap_lcd_config *conf=
ig)
> +{
> +}
> =20
>  #endif

Also now seeing the following with what you have in for-next:

drivers/video/omap2/displays/panel-taal.c: In function =E2=80=98taal_nu=
m_errors_show=E2=80=99:
drivers/video/omap2/displays/panel-taal.c:605: warning: =E2=80=98errors=
=E2=80=99 may be used uninitialized in this function

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
