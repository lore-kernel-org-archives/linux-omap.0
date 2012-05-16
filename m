From: Felipe Balbi <balbi@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Wed, 16 May 2012 11:39:35 +0300
Message-ID: <20120516083934.GI17359@arwen.pp.htv.fi>
References: <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
 <20120514122920.GK22242@arwen.pp.htv.fi>
 <20120514124757.GL22242@arwen.pp.htv.fi>
 <4FB13B91.7020007@ti.com>
 <20120514175838.GA31200@arwen.pp.htv.fi>
 <20120514181413.GA17852@atomide.com>
 <20120514183742.GB17852@atomide.com>
 <20120514193535.GA31886@arwen.pp.htv.fi>
 <20120515201426.GE17852@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53926 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759755Ab2EPIl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 04:41:28 -0400
Received: by lbom4 with SMTP id m4so406524lbo.2
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 01:41:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120515201426.GE17852@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, "Venkatraman S." <svenkatr@ti.com>


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2012 at 01:14:29PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120514 12:41]:
> > On Mon, May 14, 2012 at 11:37:43AM -0700, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [120514 11:19]:
> > > > * Felipe Balbi <balbi@ti.com> [120514 11:04]:
> > > > >=20
> > > > > That whole MMC card detection is also pretty screwed up. Balaji/V=
enkat,
> > > > > can you guys look into that ? Probably making something generic u=
sing a
> > > > > threaded IRQ handler ?
> > > > >=20
> > > > > I mean, all the MMC core should need is an IRQ number (through GP=
IOs or
> > > > > not doesn't/shouldn't matter) and it should be able to use a thre=
aded
> > > > > IRQ handler to kick the card detection/initialization.
> > > >=20
> > > > That's mostly done.. Just need to update the patches for it.
> > >=20
> > > Mostly done meaning "all the MMC core should need is an IRQ number"
> > > part that is :)
> >=20
> > but you've done it for omap_hsmmc.c, right ? What I meant is that the
> > whole card detection should be done at the MMC framework level.
>=20
> Yes what I did was just try to start gettting rid of the platform
> callbacks.
> =20
> > I mean, if we tell MMC core what's the card detect IRQ number, it should
> > be able to implement a generic version of omap_hsmmc_detect(). All that
> > thing does is read the current gpio status number and call
> > mmc_detect_change().
> >=20
> > mmc_detect_change() then kicks a delayed work, which shouldn't be needed
> > because omap_hsmmc_detect() (or the generic of it) is already using a
> > threaded IRQ.
>=20
> Yeah maybe it's doable.. The MMC driver needs to read the status of the
> card insert, but maybe that should be just just gpio_get_value().
>=20
> Then ideally the MMC driver would not have any knowledge how the GPIO
> is handled as it can come from whatever gpiochip using internal GPIO
> or TWL GPIO.

correct.

--=20
balbi

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPs2fGAAoJEIaOsuA1yqREagsP/0au7TezIsgjbDG3fa9IHHbJ
G3hoDp2whb4wyjSCBnHi9x1pzYCNZKncsrS9GUtMcyPoQRDW3Ht5Ia5DWh/gY99u
Oz//xmotEv28rNwvcQLAaUrtHoSeyXlj4NO5trx1QivCpmaUzhpkfNiFIZzO+0Je
Ar2FOXGkhuHxk5No+zI4MFGjNkiRdpp2pznilyXg5S61XWOBvihTpEGKtKgyRd6+
/QkBhapqs/a/KZRcJfgVwtCvVRv/IZEb1cIW0s/mOmPr6ffFapYVKjT88GpCgkT0
9MoZLnq3ip7rdvKLLm+RQrF6llnq/HhD6TSdBwxfKh/5r1ywA6upL+VSZDj8tizM
P5rzt6D8pPYSPT4eF5fzX3sTprbwghXnsIyPb44zx9rbHwvt4koRt+psqvy8ikK5
LBKB0Zvn4O0YbcHz5tYCTeWxRf8svn2Cn8ZwVsPQ3BNRnjuQaPWLRksK+8/a+7iG
H6YdaGPh1udAYE+D9WFlmWDRf9EIrEXHDUZdNMJN045C72h9oSTI6yebUi/qBQ1R
O4JyBvySJX1FGDQVa+4x5WayswwqRpD75kElLeqGFYDoFZr8JNY0JUsQOAmn2fcW
BrGIZXOyaHYSI3+UmYhwb3QuXsDOnFpnhZVoDm0IIV/e/2DCDfCBvBuhFXV6NmXH
im0Um4RlT9+rLHuqe8Xh
=bKAt
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
