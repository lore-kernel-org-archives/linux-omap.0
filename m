From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
Date: Mon, 10 Oct 2011 08:44:36 +0300
Message-ID: <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-2-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA545E3@dbde02.ent.ti.com>
 <20111007085614.GD10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:57741 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751208Ab1JJFol (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 01:44:41 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 10, 2011 at 10:40:55AM +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > On Mon, Sep 26, 2011 at 03:21:07PM +0530, Gupta, Ajay Kumar wrote:
> > > > To: linux-omap@vger.kernel.org
> > > > Cc: linux-usb@vger.kernel.org; Balbi, Felipe; tony@atomide.com; B,
> > > > Ravi; Cousson, Benoit; Gupta, Ajay Kumar
> > > > Subject: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
> > >
> > > Felipe,
> > > I am planning to send patch 1/6 along with next revision of ti81xx
> > > hwmod baseport patch from Hemant so that all hwmod data gets reviewed
> > > at one place.
> > >
> > > So now only rest 5 (2/6 to 6/6) patches needs to be queued for usb.
> > >
> > > I hope this will be fine with you. Let me know if you want me to post
> > > Same 5 patches separately.
> >=20
> > I guess it's better to queue them separately. I will only take whatever
> > lies in drivers/usb/musb
>=20
> Ok fine so usb hwmod patch will come from Hemant in his hwmod baseport
> Series. I will resubmit the one patch fixing your comment.=20

ok cool, tks.

For you platform_data stuff (if you have any), you can add a header to
include/linux/platform_data/musb-dsps.h

Or something similar.

--=20
balbi

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOkoZDAAoJEAv8Txj19kN1xpgH/3OM+sT35TKpbNKGCsOwhJBC
LyOGmTkoEkDUeBV+8eEp3fzf6DRnbAGlP09EGBVMvoSU76Y2UHm9nFqE9btUBCmI
JoLRskz8kTofm/3fdF3U95Aq+XlG703OMloPRivgRPbPiDMSU0doU8AAyJiUK3rQ
oR3ilXxzEH34Um9ildDBB1Uu2Tm9EbYHPHf+9Lpq3cAhmJfrFJXgrs8HQIKbo0q8
UsMm4m29XZN0ZncNM+g71fm71claZq2lWRkK0FmHd08eRx+po+kDBp3MCNNmepcl
UWz3qKTii9lDvSgPRlrhS+13j3UZbHFf74zlCjmgo0j6IdUUuUf9S98pexI4AjQ=
=900n
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
