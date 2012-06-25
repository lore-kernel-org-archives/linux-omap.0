From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Fix MUSB ifdefs for platform init code
Date: Mon, 25 Jun 2012 13:53:24 +0300
Message-ID: <20120625105323.GA7522@arwen.pp.htv.fi>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
 <20120613101506.18645.98406.stgit@muffinssi.local>
 <20120622101533.GC28472@arwen.pp.htv.fi>
 <20120625104720.GC12766@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53975 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755790Ab2FYKzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 06:55:47 -0400
Received: by lbon10 with SMTP id n10so7743111lbo.13
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 03:55:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120625104720.GC12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, linux-usb@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 25, 2012 at 03:47:20AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120622 03:22]:
> > On Wed, Jun 13, 2012 at 03:15:06AM -0700, Tony Lindgren wrote:
> > > Commit 62285963 (usb: musb: drop a gigantic amount of ifdeferry)
> > > got rid of a bunch of ifdefs in the MUSB code. Looks like the
> > > platform init code is still using these dropped defines though,
> > > which in many cases results the board defaulting always to host
> > > mode.
> > >=20
> > > Currently the situation is that USB_MUSB_HDRC is the main
> > > Kconfig option with additional USB_GADGET_MUSB_HDRC so only
> > > these two should be used to select between host and OTG mode.
> > >=20
> > > Fix the situation for omaps. The following users should fix the
> > > platform init code in a similar way:
> > >=20
> > > Dropped Kconfig option          Current users
> > >=20
> > > USB_MUSB_OTG                    blackfin, davinci, not in Kconfigs
> > > USB_MUSB_PERIPHERAL             davinci, not in Kconfigs
> > > USB_MUSB_HOST                   davinci, not in Kconfigs
> > > USB_MUSB_HDRC_HCD               blackfin, not in Kconfigs
> > > USB_MUSB_OTG                    blackfin, not in Kconfigs
> > >=20
> > > Cc: Mike Frysinger <vapier@gentoo.org>
> > > Cc: Sekhar Nori <nsekhar@ti.com>
> > > Cc: linux-usb@vger.kernel.org
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > Looks ok, though I would stick to things boards are wired to do. e.g.:
> >=20
> > all development boards are wired for OTG (with a few exceptions),
> > n800 is peripheral only
> > n810 is OTG
> >=20
> > and so on. That way you remove all the clutter.
>=20
> FYI, these got already merged last week as fixes because of the
> broken Kconfig options.
>=20
> What you're suggesting sounds like a good follow-up patch to improve
> things, although I suggest that we remove CONFIG_USB_GADGET_MUSB_HDRC
> ifdef else from board-*.c files, and always set host =3D MUSB_OTG.
>=20
> For example, both n800 and n810 are wired up the same way except for
> the mini-B vs mini-AB connector. The connector alone should be enough
> to keep n800 as peripheral unless somebody specifically wants to force
> it into host mode by using a non-standard cable or the debug options.
>=20
> AFAIK, this same logic should apply to all the devices, or do you
> see issues with it?

no, that's pretty much what I tried to say ;-) If board has a
mini/micro-B receptacle, then it can't be host/OTG/DRD (unless you hack
the cable, or change ID pin rules on the transceiver, or you force the
IP to host mode through the testmode register).

Now if board has mini/micro-AB, then it's surely supporting OTG, so we
can set board_file to MUSB_OTG. That will drop all ifdeferry too.

--=20
balbi

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6EMjAAoJEIaOsuA1yqREeZEP/AhqUXEA+kg6t9PwsBxSe5l5
4DS7yOwpWKsBtkbDvt2mTKIjhs8Fs9tni1+Zy4ZY2IS/nbqpKCYSC1TEBXq3DM/i
jgex7tHhcnUf8U16qGT/NeklRXydYP25H8+ziDwEejDRF4vzv3Y+FmvFA0qTAExc
8h6EGsnudVbk002T8NzzolPppKqOwMsyYA0Gqs2rCEHa4jLM9muBKHCdrHVT8A31
3Ybtg3LZWZomp1+qHr11a1ZKJDH2UmhAMjae5eFfPkk9nh6NkHdja32HDb5h1vAk
sOqu/+eurcFvGrBesov4JQlD+SapbtzvhvADxCcP6lwmBbt19Ydylgw8oq24ngx5
20MsiutDManVhCgDmKl3qiWqmnbrLUvxuWSqDeBzZGWjgHm9RqBlAxOk8k1TiOGe
OZkVSlXXhor7qMTI6ZZgkoiu5vFRG1q7aVM7mpsRhEwFK/Lp/30sn64beKa2X3yf
VP0Bwx0OEgwqAEycQvbKBamq37HbWvZWbpPa27VkmPAHKiNC1Euz2oCMAEweFUx2
2xy6xo4wF/SZHZCeHTXMelPKWtwLWUg4l921iujELv/Q1/2j3i4MIBa6ef0nKNCs
rD0s3jt6wlWvRpBSYQ4kLEc8s2TzNc/ipRjtxsycLevQqJCHhEaxbMNaIU/d8kZ4
XUQVP7SiRbiw8HnLh6UA
=+FO7
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
