From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Thu, 10 May 2012 09:53:10 +0300
Message-ID: <1336632790.5182.8.camel@deskari>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
	 <20120509221447.GY5088@atomide.com>
	 <CA+Bv8Xa+1RJ5QTn=vO4GSw1VtUZc3xX0J5qBVshvV5Dj+9uZVA@mail.gmail.com>
	 <20120509233745.GZ5088@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-6/O8qK6rpMrfMP4OFnxe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:43050 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754944Ab2EJGxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 02:53:20 -0400
Received: by lbgc1 with SMTP id c1so1844176lbg.1
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 23:53:17 -0700 (PDT)
In-Reply-To: <20120509233745.GZ5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-6/O8qK6rpMrfMP4OFnxe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 16:37 -0700, Tony Lindgren wrote:
> * Russ Dill <Russ.Dill@ti.com> [120509 15:53]:
> > On Wed, May 9, 2012 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Russ Dill <Russ.Dill@ti.com> [120509 15:12]:
> > >> The Beagleboard xM gpio used for TFP410 powerdown is connected throu=
gh
> > >> an I2C attached chip which means setting the GPIO can sleep. Code th=
at
> > >> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.
> > >
> > > What's the error without this patch? Or just no display?
> > >
> > > Just wondering if it's safe to merge Tomi's clean up series to
> > > arm-soc tree..
> >=20
> > The only platform that has a problem is Beagleboard xM, and that is
> > only after 'ARM: OMAP: Cleanup Beagleboard DVI reset gpio' is applied.
> > Since the context actually can sleep, the only consequence is a
> > WARN_ON statement.
> >=20
> > So yes, it should be safe.
>=20
> Well since I have not actually merged it with other branches yet, I'll wa=
it
> for Tomi to apply that and repull his for-l-o-3.5 branch.

You can pull for-l-o-3.5 as it is now, there's no need to change it.
This _cansleep change is a separate dss specific change.

So to summarize:

Currently the powerdown GPIO for tfp410 is handled in the board files
(and called reset gpio), with gpio_set_value(). My cleanup series moves
this to the tfp410 driver.

BB-xM needs to use gpio_set_value_cansleep() in tfp410 to function
properly, so the tfp410 driver needs to be changed, as this patch does.
I will take this patch to the dss tree.

So it's safe to pull my cleanup series, but if I understood correctly,
applying Russ's "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset
gpio" will cause WARN_ONs on BB-xM until this patch to tfp410 is also
applied.

But it doesn't sound too serious, so I think it's safe to apply the
"cleanup beagleboard dvi" patch also. The warning will go away when both
l-o and dss trees are pulled in the merge window.

 Tomi


--=-6/O8qK6rpMrfMP4OFnxe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq2XWAAoJEPo9qoy8lh71gxIP/jyVTK6+90vZIvUQB9b42N9b
396O1XAAszigTVYEXZbPfSdCCRGO6r5ToK0xgUhXk3RdvsqbKksIqiCa2czeY2X/
FSiwa3AsqOMXTI2xR+WUCnkg1M9Lgr0zSd3NFvW3VMBKrrS5dYC3jKnoZF0gNHCD
0KS74wBzEDS4tNwrCojHY+Wg4RwEgJ4/AEPkRBipqMgZ63BIH4MB4Lwo3Eoyy8Wf
dvbOUMzP0+BxX5MokOeOq3Xfw+eogif4C9XWbKal2Vj/4FXfZR2r0Cei55W5Z0Q4
0iomSXFGOnxXtgOENuizrt1VZdVruLKBFcAYtc4lkt+ECCCYlQglPSSfe3GB7hB3
HkCyyjooEQP1wuvLUZnfNLHlY9dWnaUFKXfXoseexsMJpuBpc7Vh6IlATxQr+veC
26FdI+HNOCmYe5Yl4XqpUYOG4HUHBvbrwMWG3J/D5lSoM8FcKCIFza+SGQyMy9Lt
AjmgY7gFpWtAqm/lQ7yH3xYeVy0rUSo1ND2rtI08woP+8ww1Ij9IR3iPOQwwiDwq
VWrF24Q9zTJnvqKFnMULlo6Ll88SOc9VIhmxm8emg/ysqVSUZSiVBTsK68u85CXT
WX0mBCPPS1YDcpHUMNpP4s5MgE+0ZiegJ99l+EVGeJ8/w8zYiz8qvDWzlPc9Cs02
Tuf7lYWTAyNMZiM0RHSO
=Gtdj
-----END PGP SIGNATURE-----

--=-6/O8qK6rpMrfMP4OFnxe--

