From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Wed, 26 Jan 2011 10:11:03 +0100
Message-ID: <20110126091103.GE1147@pengutronix.de>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110126084613.GD1147@pengutronix.de>
 <20110126085240.GA2698@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56778 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1AZJLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 04:11:07 -0500
Content-Disposition: inline
In-Reply-To: <20110126085240.GA2698@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 26, 2011 at 08:52:40AM +0000, Russell King - ARM Linux wrot=
e:
> On Wed, Jan 26, 2011 at 09:46:13AM +0100, Uwe Kleine-K=F6nig wrote:
> > Will you care for imx (mach-{mx*,imx}), too, or should I fix them u=
p?
>=20
> Does mx stuff do non-irq setup or non-map_io stuff in those callbacks=
?
the map_io callbacks (e.g. mx27_map_io) setup the infrastructure for
cpu_is_xyz and arch_reset.

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
