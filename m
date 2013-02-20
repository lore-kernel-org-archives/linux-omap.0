From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Wed, 20 Feb 2013 21:16:38 +0200
Message-ID: <20130220191638.GA25609@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215064429.GA30038@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41030 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935451Ab3BTTQq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 14:16:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2013 at 05:38:49PM +0000, Paul Walmsley wrote:
> > > Drivers shouldn't touch their IP block's SYSCONFIG registers.  They d=
on't=20

just now I noticed this fun fact:

"driver's should touch *their* SYSCONFIG registers"

You're stating yourself that SYSCONFIG belongs to the IP and the IP is
fully controlled by its driver. ;-)

> > why not ? It's part of the driver's address space anyway. It's not part
> > of the IP in question (usb, ethernet, etc) but it's part of the TI
> > wrapper which usually involves a bridge (ocp2scp, ocp2axi, etc) plus the
> > TI-specific integration registers (revision, sysc, syss...).
> >=20
> > So they're not part of the licensed IP, but they're part of the TI
> > wrapper around those.
>=20
> Ideally Linux drivers would be as independent as possible from their SoC-=
=20
> or board-specific integration.  This includes bus integration, etc.  That=
=20
> way, an IP block like UART, where most or all of the registers are shared=
=20
> with the common 8250 code, might be able to use a shared driver.

right, then why did we even bother adding omap-serial ? If the whole
idea was to hide integration, what was the point in introducing
omap-serial ?

> Also, it should be noted that the TI wrapper isn't necessarily common to=
=20
> all TI SoCs :-)  The wrapper bits and functions can change from TI SoC to=
=20
> SoC.

yeah, that's because of the chassis architecture definition and has
little value to current discussion ;-)

> > > have anything specifically to do with the underlying device IP block,=
 but=20
> >=20
> > of course they do, soft reset touches the underlying IP, so does force
> > idle, no idle, etc.=20
>=20
> Force idle, no idle, etc. only affects what's reported to the PRCM via=20
> the SIdleAck/MStandbyReq lines.  It shouldn't affect anything in the IP=
=20
> block itself.

It does touch the IP block. After the asynchronous PM handshake
(Ack-Req) is successful the IP block isn't in a usable state.

> As far as reset goes, the chip-wide reset bits affect the IP block too,=
=20
> but we wouldn't put that code into the drivers :-)

why not ? What happens when drivers need to reset the IP ? For cases
where we need "reset in runtime", drivers are the best entities to know
exactly where the IP must be reset.

Also, IMHO reset should always be done during probe() so driver can be
dead sure that we're starting from a known state. This is even more
important for the complex IPs which are licensed from RTL vendors and
are used in different SoCs. While arch/arm/mach-abc/ resets every IP
pior to probe() being called, we can't be sure that arch/arm/mach-xyz/
will do the same thing and imposing such requirement is too difficult.

Problem just gets worse when you consider SoCs from completely different
architectures (say ARM and Blackfin) using the same IP licensed from
a particular RTL vendor.

--=20
balbi

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJSEWAAoJEIaOsuA1yqRE2AsP/1OJ+5juTn/pGltPCnZYWqHp
wo02/qep2sZbScGzsN+K5sFQia3T1XN8Dhj0vyhdXJipdg3ZgNsq1YiCEwwLOCPP
0gmorvX0Ut6L0L/7DzmCzlQOvxvjQleeosD+oFPud9D4JNw2Qxe6dBNek5qF2toy
Gbuiu77iYeDsHJp7v5je0ifEw6gMUK+4eQVg7orPl7imzWn9vXzAw6Rtp4PI43ma
hZDZtuRD7IBB0rFB7hseMttSpC7AG3YUzfvyQpdRAuljz7uLPxrnyTWEHsKESong
p6NEnzNkMRDB+BV/7JvwvfvaPZPWuE5OSw7yMVxVl8+jny1ALbvsbDx4viQsit8/
VJ2+TI9vg4wSHMtmxT+nGW3D6tv/OAgyPRekUVtaqkz1PKLmOA7sNCT1z63o1a7y
3iFX/GVqYkNRX9gx23D9PcE9TW0E97/o2RZxnXYciS8JraC5lYzvefKRS3yV+Am0
poQlURgyInGGlFrm2LnjGHROMQxNJThwyVKkZgJn/XiPqmz+Ra8/YmnN82hqQJhY
y7BCLVzQiw7J6ZDhMAc+UAsxmyfYxMZIgY6TrWfchPw9paHiSb9kwlPMnrfO0shv
NUMnNy4egYlaa0bihSa0cODn5GNsyYtPWCQlTfjWbv1cmgdsiRerMSdOvfOe1Wfb
7ISg6E0xul/u6E3uOVST
=GdlA
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
