From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 9 Apr 2013 22:57:08 +0200
Message-ID: <20130409205708.GA17920@avionic-0098.mockup.avionic-design.de>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
 <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
 <20130408221657.GC10155@atomide.com>
 <20130409075602.GA27255@avionic-0098.mockup.avionic-design.de>
 <20130409164003.GK10155@atomide.com>
 <20130409194049.GA16847@avionic-0098.mockup.avionic-design.de>
 <20130409201745.GQ10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57962 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936309Ab3DIU5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 16:57:25 -0400
Content-Disposition: inline
In-Reply-To: <20130409201745.GQ10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2013 at 01:17:46PM -0700, Tony Lindgren wrote:
> * Thierry Reding <thierry.reding@avionic-design.de> [130409 12:45]:
> > On Tue, Apr 09, 2013 at 09:40:04AM -0700, Tony Lindgren wrote:
> > [...]
> > > But then the regulator is not found and the driver should just exit,
> > > or do nothing. If this is an optional regulator, then that should be
> > > indicated in some platform data flags?
> >=20
> > Yes, if the regulator isn't found then the driver fails. However the
> > goal was to maintain bisectability. If we apply them in the wrong order
> > we can't guarantee that because pwm-backlight will fail to work between
> > both patches.
>=20
> But it's fixing something that's not working anyways for board-4430sdp.c,
> It seems so as these patches just add new features?

Not quite. It's adding a dummy regulator to represent hardware where the
enable pin is always high. So I think pwm-backlight will work in the
current state, but if we make the pwm-backlight driver change without
adding the dummy regulator, then pwm-backlight will fail to probe and
therefore the PWM won't be enabled either and the display will stay
black.

> > > The driver parts really must be done in independently from any platfo=
rm
> > > data or .dts changes. The only common part needed should be changes
> > > to include/linux/platform_data/*.h files.
> >=20
> > We don't even need to touch platform data because the regulators are
> > looked up via a global table. And the changes are all done independently
> > but as I mentioned above, bisectability isn't maintained, so the
> > preferred patch order is the one in which pwm-backlight keeps working at
> > each point in the commit history.
>=20
> Bisectability is a good point. But in the 4430sdp case I'm sure it's enou=
gh
> that it builds and boots no matter how the patches get merged :)

If you don't mind some intermediary breakage, I will no longer object.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRZICkAAoJEN0jrNd/PrOhWKYP/iWUYES2y7X2a02lKgf5b7Ew
4voOZodbNWHb4bXltqPNhdYhKOmoOJjk+Lo+tLPhpAjc/M9vJuymMjnR7jLAORxN
EwBBqKYtMQysKSG90gk0L1xH1jTvqh71cSxtFkOTFkdxGgJ5++MwBvZ1hARI1m6l
S//vj51dpz5x0eFV6QqKqJJVz8Bz7KAAfDPHTYP8OYqyoaHeOHq3m6dTAZeUPXQs
ZkXl7kOeZfIetmu03xlJgTwVHeorKwCArtarBgDighAHEPxC/tzLAzEtW6oF4KwR
ceskYu4B/n89g9YP6MEGa4JzEDl74U+H6NWZ3CNKN8CNammldyB0dyoMFtst3196
7W9SnhOmvs65PS58LIvo+vE3sHm0x2FQh1dC66cXxifbgo2lb4v6wZGd4IhRG4y8
S4oXGM82c08BcEtFUDRLodGfzsSXaRy11Pw/k42FTjAR7XdKt98gwgP5Qz/xrTyV
aaFU/Ihw345qh60mWKMOAqen5+A2R+aXgZzTebkDXbmt7DSIcZCGcqjDqY6I/W/V
CddZTg9WU2oazCUfJr/QCOdF/NgUhoFjIRePHJpGMjrrxFSOaiZ2OAwmpjG8Itzj
cCosv7D4UuAFakNCEyKE4epso2cm6br+evMtQOjIn7LaWI9Hq/DL0YouFFYq6zHK
jb9CVN1XJo/J+abBdtrI
=LDe6
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
