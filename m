From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Fri, 06 Jun 2008 12:49:40 +0300
Message-ID: <1212745780.17269.56.camel@kj-ubuntu>
References: <1212406192.32058.18.camel@kj-ubuntu>
	 <CC3604C1-277A-4CE1-9B3D-EE0ADFB97E3E@student.utwente.nl>
	 <B85A65D85D7EB246BE421B3FB0FBB593011132AD90@dbde02.ent.ti.com>
	 <1212472944.32058.31.camel@kj-ubuntu>
	 <B85A65D85D7EB246BE421B3FB0FBB593011132B103@dbde02.ent.ti.com>
	 <20080603151044.GB6992@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20662 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbYFFJt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 05:49:29 -0400
In-Reply-To: <20080603151044.GB6992@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Koen Kooi <k.kooi@student.utwente.nl>, linux-omap <linux-omap@vger.kernel.org>

Hi,

> > Tony, I can update this patch set, or send an additional patch that=
 adds
> > the efuse support. Which will you prefer?
>=20
> Well I guess updating it would be better if it's just defining them s=
o
> we have a working patch rather than patch and fix cycle.

=EF=BB=BFIt took a bit longer than I expected, but here's the updated
smartreflex driver that uses the E-fuse values. Thanks to Pratheesh for
helping out with the details of the implementation.

=46irst patch remains as it was. Some new register and regbit defs have
been added to the second patch and the last patch now implements the
E-fuse parameters.

I also left in the software hard coded values under a "Smartreflex
testing support" entry in the Kconfig. For testing purposes only.

Again, tested on 3430SDP.

Regards,
Kalle

>=20
> Regards,
>=20
> Tony
>=20
>=20
>=20
>=20
> >=20
> >=20
> > Regards,
> > Kalle
> >=20
> >=20
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@v=
ger.kernel.org] On Behalf Of Koen Kooi
> > > Sent: Monday, June 02, 2008 6:02 PM
> > > To: Kalle Jokiniemi
> > > Cc: linux-omap
> > > Subject: Re: [PATCH 0/3] ARM: OMAP: SmartReflex driver
> > >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > >
> > > Op 2 jun 2008, om 13:29 heeft Kalle Jokiniemi het volgende geschr=
even:
> > >
> > > > Here is an updated version of the SmartReflex driver.
> > > >
> > > > Patches 1 and 2 are same as before, but patch 3 has some new th=
ings:
> > > >
> > > > - Changed the register accessing to use the prm_xxx_mod_reg{_bi=
ts}()
> > > >  functions.
> > > >
> > > > - Created a Kconfig entry for SmartReflex in "System type->TI O=
MAP
> > > >  Implementations" menu.
> > > >
> > > > Tested on 3430SDP.
> > >
> > > Compiles for beagleboard, but the board hangs after:
> > >
> > > echo -n 1 > /sys/power/sr_vdd1_autocomp
> > > echo -n 1 > /sys/power/sr_vdd2_autocomp
> > >
> > > But that's likely to be a beagleboard specific problem.
> > >
> > > regards,
> > >
> > > Koen
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v1.4.5 (Darwin)
> > >
> > > iD8DBQFIQ+g/MkyGM64RGpERAqwgAJ97AE4z0bIBZJs7nZcO1Npa8YkIcgCfY6KM
> > > 3Hhr4AIdmzNiozdqs1uQUgg=3D
> > > =3DrcQP
> > > -----END PGP SIGNATURE-----
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-o=
map" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
