From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 4/6] OMAP4: Temperature sensor device support
Date: Wed, 10 Aug 2011 15:48:00 +0300
Message-ID: <20110810124800.GK12882@legolas.emea.dhcp.ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-5-git-send-email-j-keerthy@ti.com>
 <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
 <20110810124102.GM1939@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54622 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753312Ab1HJMsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 08:48:05 -0400
Received: by fxg17 with SMTP id 17so1490861fxg.16
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 05:48:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110810124102.GM1939@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Keerthy <j-keerthy@ti.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 10, 2011 at 05:41:02AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110810 05:31]:
> >=20
> > On Wed, Aug 10, 2011 at 05:55:20PM +0530, Keerthy wrote:
> > > +
> > > +int __init omap_devinit_temp_sensor(void)
> > > +{
> > > +	if (!cpu_is_omap446x())
> > > +		return 0;
> > > +
> > > +	return omap_hwmod_for_each_by_class("temperature_sensor",
> > > +			temp_sensor_dev_init, NULL);
> > > +}
> > > +
> > > +arch_initcall(omap_devinit_temp_sensor);
> >=20
> > I really dislike people adding more and more *initcall() to their pieces
> > of code. But Tony is the final Judge.
>=20
> Yes how about making this just a regular device driver and have it
> live under drivers/ somewhere?
>=20
> Or is there some reason why this could not be a loadable module?

driver is loadable, this is just creating the platform_device, but still
I don't think it deserves its own arch_initcall(), it could very well be
something which is called after we know we're running at omap4, or
called by each board...

--=20
balbi

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQn4AAAoJEAv8Txj19kN1rJQH/2QukYt8qeg4eWF8cDYiZJBI
ZVDDD6KMUPBszkxfujgCjAAUB2KZUA1ymch1pMz3woOynZVAgxntnNuFIbd685nD
YRak8tXiMVWOmQrsRI5bCTYSBb8stZWg7WdlcIkUtfkFtaK/WOejHu8K6qDxR2gs
Id/eclzA7B28HihNk6x8gwY8PrJUIeTg6JGWF9E0w+ehLMNvocb2gSyeTem6c+2+
luaZQ3MaPE9ilC5Q9TAV1P9PiV0Z3fv8C074apddf3rlfcLhASfBU/XEwLgY9uP0
wntUy5RS8/wnw3wO/Cf0X7fx2krnubNzMe23NLm1MRvRhKRRGFMJL92kvM1NQZ8=
=swP+
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
