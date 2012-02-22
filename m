From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest OMAP randconfig build error
Date: Wed, 22 Feb 2012 20:12:36 +0000
Message-ID: <20120222201236.GA8533@n2100.arm.linux.org.uk>
References: <20120222085130.GE22675@n2100.arm.linux.org.uk> <CAK=WgbYxJyLoYs6vcj0dhSSAFX3vHqZAOHcr9t3+xEAh4ZPBNA@mail.gmail.com> <20120222175822.GV18185@atomide.com> <CAK=WgbY1b4qJXNr7=KyjdqGfexrum=XpTF3QYsw=OgFzv5NQ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39677 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2BVUMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 15:12:48 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbY1b4qJXNr7=KyjdqGfexrum=XpTF3QYsw=OgFzv5NQ_A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

On Wed, Feb 22, 2012 at 09:55:56PM +0200, Ohad Ben-Cohen wrote:
> On Wed, Feb 22, 2012 at 7:58 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > 2430=A0is like omap3 for the mailbox.
>=20
> Gotcha, thanks.
>=20
> This one below isn't pretty, but it should satisfy all build
> permutations and still be correct hw-wise.
>=20
> If it looks good to you I'll submit it properly.
>=20
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mail=
box.c
> index 609ea2d..6f0f228 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -281,8 +281,14 @@ static struct omap_mbox mbox_iva_info =3D {
>  	.ops	=3D &omap2_mbox_ops,
>  	.priv	=3D &omap2_mbox_iva_priv,
>  };
> +#endif
>=20
> -struct omap_mbox *omap2_mboxes[] =3D { &mbox_dsp_info, &mbox_iva_inf=
o, NULL };
> +#if defined(CONFIG_ARCH_OMAP2)
> +struct omap_mbox *omap2_mboxes[] =3D { &mbox_dsp_info,
> +#if defined(CONFIG_SOC_OMAP2420)
> +					&mbox_iva_info,
> +#endif
> +					NULL };

Better would be:

+#ifdef CONFIG_ARCH_OMAP2
+struct omap_mbox *omap2_mboxes[] =3D {
+	&mbox_dsp_info,
+#ifdef CONFIG_SOC_OMAP2420
+	&mbox_iva_info,
+#endif
+	NULL
+};
 #endif

There's no point in typing any more than you have to with #if defined()=
=2E
The only place where using #if defined() makes sense is if you want to
subsequently do #elif defined xxx because there isn't a #elifdef.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
