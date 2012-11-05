From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 1/7] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 12:01:05 +0200
Message-ID: <20121105100105.GC3327@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi>
 <50977A30.6040907@ti.com>
 <20121105090412.GA2913@arwen.pp.htv.fi>
 <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab2KEKHc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 05:07:32 -0500
Content-Disposition: inline
In-Reply-To: <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: balbi@ti.com, Shubhrajyoti <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2012 at 02:54:32PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Nov 5, 2012 at 2:34 PM, Felipe Balbi <balbi@ti.com> wrote:
>=20
> > Hi,
> >
> > On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> > > >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pdev)
> > > >>
> > > >>            dev->fifo_size =3D (dev->fifo_size / 2);
> > > >>
> > > >> -          if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> > > >> +          if (dev->rev < OMAP_I2C_REV_ON_3630)
> > > >>                    dev->b_hw =3D 1; /* Enable hardware fixes */
> > > > looks like this was applicable to 4430 too, what happened ?
> > > No actually this can be deleted completely once the
> > > start -> transaction -> stop sequence recommendation is followed.
> >
> > yes, but we're not there just yet and this patch is changing the
> > behavior of the driver
>=20
>=20
> No , earlier we were truncating the register for omap4 so
> OMAP_I2C_REV_ON_3630_4430 was there if we read both hi and lo for
> omap4 then we donot find 3630 and 4430 value to be similar.
>=20
> In this case the behavior is same as earlier also it enabled this for
> lower than 3630 and the same holds good even now.
>=20
> So in essence, Earlier  OMAP_I2C_REV_ON_3630_4430 is named to
> OMAP_I2C_REV_ON_3630 and omap4 rev will have a 32bit value.

it's not same behavior because before dev->b_hw was set for omap4430,
but now it won't be. This is the difference in behavior which I'm
pointing out.

--=20
balbi

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl45hAAoJEIaOsuA1yqREPwsQAIeya2ruEABjozcDWfWvM9FB
qTVRg+zXis51HgHW6D7kiaPNj+I4SsW1s5vFCFQtEdmok5wSrftwZi4RO6mq0G7I
qiouo7LOJPrIi/tbqOzb9kGjCJ2g3DFLX88PC4HouVBhOtP2HkgCSOia9HbQWXGP
XL0vorEn8GtXDx7hlryfWFkkmpDGkeCEfqKB7Ey9GBFk1E592avhdAQ2lmZW/kiK
zUvLEDCQoVS2TzrSJPblvhhBkkeCaFDVUhEHs9ZkB8zvAtJVK0LNutnV3twMGlk5
GVY97H2sJWc98pmWqi5l8xWjCrW31KeEBP1G1LR5sFr4HLWNmPp78jPVO2dX7oAc
+xs23hOD8shdIKSR65veza0gZ00+I7J+AIs26FbmfmWXnkShn/ejA9JqwZzj9MJ9
ePNXMZbFS0iNvgH85NDIMMR772F2mUaaKDwAwnMi9/k99f/eI3Ww6pi1yf2jVmgz
5a1Cq/oS8hktu0dMJRk+roOtaSqHqx4Qg6LIYOIMr5sfsvj6lHDsimnNPe78sl1b
m6Uf5faY7Tj0/6vvFy/iSjf17b+m0FHid1POjgUbizpigeFWlWTaH/zTOGc9YbUp
u76hnfzuyjE+PRKdDbk2ij8HQe6cp/HRMSTqRU63vktOZjHoqioIRR2klTdoCmsy
Clg800PRJInKJUYt7gLX
=kP7T
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
