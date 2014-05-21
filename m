From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Wed, 21 May 2014 16:24:59 +0200
Message-ID: <20140521142459.GB27779@earth.universe>
References: <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com>
 <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com>
 <537A540E.8070302@ti.com>
 <20140519195100.GB11945@atomide.com>
 <537CA4B4.2040001@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44614 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaEUOZH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 10:25:07 -0400
Content-Disposition: inline
In-Reply-To: <537CA4B4.2040001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 21, 2014 at 04:05:56PM +0300, Tomi Valkeinen wrote:
> I'll try and see how the other options work, which are:
>=20
> - Bailing out from module_init in each display driver. The reason I
> don't like this (although I haven't tried it) is that all the display
> drivers need the modification, and because I need to catch the
> module_init, I cannot use the helpers like module_platform_driver(), so
> it adds multiple lines to every driver.

You could create your own omapdss_driver() define for that.
This can be replaced more simply once no longer needed and
creates less bloat.

I see one more disadvantage for this approach:

assumed situation (some future 3.16+x kernel):
 * The kernel has an common display framework (CDF)
 * The kernel has an panel driver using CDF
 * There also exists omapdss driver for the same panel
 * omapdss does not (yet) adopt CDF
 * CDF and omapdss are enabled in .config
 * Kernel is booted from an OMAP system

This would result in both drivers being loaded using the same
DT compatible string. The same scenario works using the rewriting
method, since the common display framework would only see the
rewritten compatible string.

Of course this scenario only happens when omapdss is not adopted
to the common display framework from the start on.

> - Traveling the video graph, starting from omapdss. This one is possibly
> better performance-wise than my original version, as we only need to
> search for the omapdss node and can then follow the links. But the code
> will be more complex.

I think the main advantage is the missing lookup table/whitelist,
which adds redundancy. Not having it has some advantages:

* new drivers don't need to touch any existing files (making
  rebasing etc. easier)
* table can get out of sync (though that shouldn't happen anyway,
  since the binding is supposed to be stable)

-- Sebastian

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTfLc7AAoJENju1/PIO/qaVmsQAJP3lRtzFdHGO9oufke5LxIT
oCnpe7v1evjMQi/PdbhHTmrx/FIaxNKmkCl5VPGMYJqf+pF/sa6G7yrS0ZUq8jGI
XFJEyB6M2/IjcuAVrj8qHdCMabnqa2q5C4xMtURRfsraipDsFv7LX/2STH8CcrlX
oP60OdAvQmv5w7PVMdRnuQ94/wsXTZWP6tqy78+e67w0hYlvNUxhsntoPWdHtbLu
l8MLEC58/5mFIwAX7sRQQgr7q8CZAvhUE7dkYLvIGcxKXgGfzeuzggR5/Bsj4vfR
gPDV6vEe2S2PrjcCMLslITCeSGQhKz99p1DiY/xfYBHO+aF/UIXtCBpNdDz8hk1M
gh62Q3avLzFF24ckyero/YX7AMPxPK4jtypIrgvNYQ2LwRKt36XsdcoU15Ya4viu
QuFpH2ivq3A4Y7vMyhRzGDlTIUrrCFtKlETQsDc+s7exiK0Yg97pp40koVjR+4aX
8Saw5+0tsmaTsJ8AlTyX0uIw3D/3jErab1n2Hl06iAuiFNWXO+o6uvVazSIKPu52
a/Bv7xPPihrMN1daE40EtRX8y+HEvzPGBYAlbTiM0UviDToZSbIZykGC/bZ2WKPb
9YsusjSpMJrFCtGX19lPLzE9Ej4JiIXD2cvGzYRuXismzMCy51ti6/30XOHLe/7e
Iu4hpr0bgYDB8W3BwYg6
=AsiA
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
