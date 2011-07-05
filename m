From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler
 mechanism
Date: Tue, 5 Jul 2011 14:33:40 +0300
Message-ID: <20110705113338.GC2820@legolas.emea.dhcp.ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
 <1309861677-2769-2-git-send-email-t-kristo@ti.com>
 <20110705111842.GZ2820@legolas.emea.dhcp.ti.com>
 <1309865538.17918.9.camel@sokoban>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tpXFRyzAyQ/GSAaD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41424 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932176Ab1GELdr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 07:33:47 -0400
Received: by bwb11 with SMTP id 11so6633992bwb.37
        for <linux-omap@vger.kernel.org>; Tue, 05 Jul 2011 04:33:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309865538.17918.9.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "R, Govindraj" <govindraj.raja@ti.com>


--tpXFRyzAyQ/GSAaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2011 at 02:32:18PM +0300, Tero Kristo wrote:
> On Tue, 2011-07-05 at 13:18 +0200, Balbi, Felipe wrote:
> > Hi,
> >=20
> > On Tue, Jul 05, 2011 at 01:27:47PM +0300, Tero Kristo wrote:
> > > @@ -854,20 +802,35 @@ static int __init omap3_pm_init(void)
> > >  	/* XXX prcm_setup_regs needs to be before enabling hw
> > >  	 * supervised mode for powerdomains */
> > >  	prcm_setup_regs();
> > > +	ret =3D omap_prcm_irq_init();
> > > +	if (ret) {
> > > +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> > > +		goto err_prcm_irq_init;
> > > +	}
> > > +
> > > +	prcm_wkup_irq =3D omap_prcm_event_to_irq("wkup");
> > > +	prcm_io_irq =3D omap_prcm_event_to_irq("io");
> > > +
> > > +	ret =3D request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> > > +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);
> >=20
> > IRQF_DISABLED shouldn't be used anymore ;-)
>=20
> Oh man, well that is easy to remove as it doesn't do anything. Should I
> send a new version of the set for this? :P Kevin's call I guess.

yeah, Kevin's call :-)

> I just tried the set without this flag and yes it still works. :)

Good :-)

--=20
balbi

--tpXFRyzAyQ/GSAaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOEvaSAAoJEAv8Txj19kN1h/AH/3zhyrF/N4O5aAUHtuWE5QwI
3tTgarstdhMBj5fdT5oNhC+MVXvLm8THuTvcpCMy1wNwfL12HFMIdNLf/BS4RyoJ
wSLanuO0/uTXewqL1QeV7bN9a+SkSqej2P/p68tJNN9X+ahJuLVUGYrRgCcIjz1/
HGS+QhyS68PD6ICd7md5irKqOwcgkgomUhggPl/ypNx7kqAltmaqXT+9H3+EgwRC
nqzROzfYg8wSckwBITwKN82Z8SO1bfJSld0IHlYiedHoTtdhk48CmgFY1X+GmVoi
zKRqAetsmjIr90WupnGXKQnUPtgNxHnCwRO+vn2SqM3+/2FulPRusZaBuVkImAo=
=KYMg
-----END PGP SIGNATURE-----

--tpXFRyzAyQ/GSAaD--
