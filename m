From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Fri, 24 Aug 2012 18:00:16 +0300
Message-ID: <1345820416.2614.51.camel@deskari>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	   <1345023063.3494.20.camel@deskari> <502BBFBB.6090303@8d.com>
	  <1345546189.4085.52.camel@deskari> <50339B3A.3020005@8d.com>
	 <1345797509.2614.10.camel@deskari> <5037869E.9050604@8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wuHBWZkn0UKNuPFJSxhl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:39525 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751866Ab2HXPAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 11:00:21 -0400
Received: by lago2 with SMTP id o2so373755lag.9
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 08:00:18 -0700 (PDT)
In-Reply-To: <5037869E.9050604@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-wuHBWZkn0UKNuPFJSxhl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-24 at 09:50 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:

> But internally, perhaps with the exception of the "DE only" operation,
> all the same concepts apply. LVDS is just only one extra layer used to
> transmit the parallel data more effectively (differential, less
> conductors, etc).
>=20
> Consider the case where an LVDS transmitter is used on the main board
> in conjunction with a remote LVDS receiver on a board connected to
> a "true" DPI panel as follows:
>=20
> [OMAPDSS -> LVDS XMIT] -> [long cable] -> [LVDS RXCV -> DPI Panel]
> |    parallel        |     lvds serial    |        parallel      |
>=20
> Given the above use case, adding a new panel to panel-generic-dpi.c would
> be obvious since doing without LVDS and driving the panel directly may
> still happen if a specific design does not benefit from the use of LVDS.
>=20
> There are a few different conventions for LVDS transmission where the tot=
al
> number of bits transmitted by pairs as well as the bit order varies. The
> hardware designer selects a compatible pair of chips based on the number =
of
> color bits the panel supports and other factors. But no matter which are
> selected and how they are wired, the LVDS layer remains transparent to th=
e
> graphics controller and the panel.
>=20
> My situation is only different from the above by the fact that our panels
> have an LVDS receiver built-in, which means the choice of transmitter is
> limited to what will be compatible and that a specific bit order (i.e.
> wiring)
> must be observed. This is why I tend to consider those LVDS panels simply
> as DPI panels having a built-in LVDS receiver.

In your case the LVDS panels are "dummy", and require no configuration,
and thus look like DPI panels.

But consider an LVDS panel which can be controlled via, say, i2c, and
you can configure the number of LVDS lanes used.

And consider a SoC with LVDS transmitter, which again needs to be
configured depending on the LVDS lanes used (and probably some other
parameters).

In those cases the use doesn't look like DPI anymore.

> > If you had just one panel and DPI-to-LVDS chip, I'd suggest to create a
> > combined driver which handles both the chip and the panel. But you have
> > two chips and three panels...
>=20
> I'm not sure what the chip driver would do. The LVDS layer is totally
> transparent to the operation. Why would the kernel need to be aware of
> which chip is used?

The chip must require power to operate, so it needs to enable
regulators. For example, SN75LVDS83B requires VCC, IOVCC, PLLVCC,
LVDSVCC. In your case the regulators may be always-on regulators, but a
driver cannot make such assumptions.

> One thing that might be useful would be the ability to control the
> enable pin, but this is not different from the enable pin on a level shif=
ter
> placed between the OMAP and a real DPI panel. At the moment, our userspac=
e
> software simply controls this using a GPIO.

Yes, the driver should also handle the enable GPIO (for the DPI case
also).

Now, as I said, the current omapdss model doesn't really allow
"chaining" of display devices, so you can't currently create proper
drivers. That's why I'm not sure what to do. It would be nice to support
your boards, but on the other hand, I think it's not correct to add
these panels.

 Tomi


--=-wuHBWZkn0UKNuPFJSxhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQN5cAAAoJEPo9qoy8lh71+mkP/1Z6Wbn2gKWhyw7e5libUmBb
Kq40omTfQdpe/2YX9t2nmI+2rbPznsSmHybSi90uXOeJah2jxV9x74qWidAi7Tge
E192JneG7NkonMJC7t6hSgy957y8mszUO9DBjq4Mb7OU7/i4zkbdiTnWipzMIRIN
BiCF20F1lYDTaHblMCkJNpgPSdhVV79c5Rx15wJQElbbmELwwfKg1aoyowFyXWfJ
Hlvt1pQEGjntSY7My4T3JwaRIjDkeeD79X1Co59ZzBjxeR3UhJGtFw7VwqZJfbhL
xwrRNmHw/lICJLs8AlYElKfaEPHLSt2/LmlxcsMMotKiRDnnywENwKssc+sEvotY
+bAITw8tJHynFPYIF7jNDmUotg3e7QWfvjsiiFI2uEldH5Af1yGbvpCAzG+nwmW/
z0OBLeeSboEXqfaMnakJdqgkxNN37AHjgp9rosW9Kda94L7aDkjHFhZW8+DxbEZ/
u2Jdb/x1roQKe6r+iYGGAmIFyJv/Ya6F4Xnnctkhv9F+yhGaLWmFpr+Ku0MiVLx1
G8FMO3enJjn0Q3aRTTYPgm1yHMwgxmiYeS5tUcQQ3oryrKwsPDUjprfBUmkAKVTg
x7XB7jfCEG/6qAdN0H1eazCJl4n84FvAiYFCUNuKh6rM1OrOTxIvbUco82BQ7xcL
0f8zMDyFlh71aQuAr8/w
=tMxg
-----END PGP SIGNATURE-----

--=-wuHBWZkn0UKNuPFJSxhl--

