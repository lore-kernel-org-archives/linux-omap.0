From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Wed, 26 Jan 2011 09:46:13 +0100
Message-ID: <20110126084613.GD1147@pengutronix.de>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56632 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1AZIqS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 03:46:18 -0500
Content-Disposition: inline
In-Reply-To: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Russell,

On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux wrot=
e:
> Move non-mapping and non-irq initialization code out of .map_io and
> .init_irq respectively into the new init_early hook.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I think I've updated this patch correctly for the new platforms merge=
d
> into mainline.
>=20
> Please ensure that new platforms merged after this patch also use the
> new structure, and note that the initializers should be listed in the
> following order:
>=20
> 	.fixup
> 	.reserve
> 	.map_io
> 	.init_early
> 	.init_irq
> 	.timer
> 	.init_machine
Will you care for imx (mach-{mx*,imx}), too, or should I fix them up?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
