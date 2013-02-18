From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdrm: Make fixed resolution panels work
Date: Mon, 18 Feb 2013 10:31:53 +0200
Message-ID: <5121E6F9.1030905@ti.com>
References: <1360842744-8325-1-git-send-email-archit@ti.com> <CAF6AEGvgQxYtV=FD_B29LCONALSieR+PWVpgOD0Wn4SM88zn2g@mail.gmail.com> <5121D705.6040908@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD96AADA057894D8D0FBB0EEE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33515 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab3BRIcA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 03:32:00 -0500
In-Reply-To: <5121D705.6040908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, greg@kroah.com

--------------enigD96AADA057894D8D0FBB0EEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-18 09:23, Archit Taneja wrote:

>>> diff --git a/drivers/staging/omapdrm/omap_connector.c
>>> b/drivers/staging/omapdrm/omap_connector.c
>>> index 4cc9ee7..839c6e4 100644
>>> --- a/drivers/staging/omapdrm/omap_connector.c
>>> +++ b/drivers/staging/omapdrm/omap_connector.c
>>> @@ -110,6 +110,11 @@ static enum drm_connector_status
>>> omap_connector_detect(
>>>                          ret =3D connector_status_connected;
>>>                  else
>>>                          ret =3D connector_status_disconnected;
>>> +       } else if (dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DPI ||
>>> +                       dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DBI ||
>>> +                       dssdev->type =3D=3D OMAP_DISPLAY_TYPE_SDI ||
>>> +                       dssdev->type =3D=3D OMAP_DISPLAY_TYPE_DSI) {
>>> +               ret =3D connector_status_connected;
>>
>> hmm, why not just have a default detect fxn for panel drivers which
>> always returns true?  Seems a bit cleaner.. otherwise, I guess we
>> could just change omap_connector so that if dssdev->detect is null,
>> assume always connected.  Seems maybe a slightly better way since
>> currently omap_connector doesn't really know too much about different
>> sorts of panels.  But I'm not too picky if that is a big pain because
>> we probably end up changing all this as CFP starts coming into
>> existence.
>>
>> Same goes for check_timings/set_timings..  it seems a bit cleaner just=

>> to have default fxns in the panel drivers that do-the-right-thing,
>> although I suppose it might be a bit more convenient for out-of-tree
>> panel drivers to just assume fixed panel if these fxns are null.

Yeah, I can't make my mind about null pointer. It's nice to inform with
a null pointer that the panel doesn't support the given operation, or
that it doesn't make sense, but handling the null value makes the code a
bit complex.

For example, our VENC driver doesn't know if there's a TV connected or
not, so neither true or false as connect return value makes sense there.
Or, for a DSI command mode panel, set_timings doesn't really make much
sense.

> Maybe having default functions in omapdss might be a better idea. There=

> is an option of adding default functions in omap_dss_register_driver()
> (drivers/video/omap2/dss/core.c).
>=20
> Tomi, do you think it's fine to add some more default panel driver func=
s?

We can add default funcs. However, adding them in
omap_dss_register_driver is not so nice, as it makes the omap_dss_driver
(which is essentially an "ops" struct) non-constable. Instead, we should
move the setting of the default funcs to the drivers.

If I'm not mistaken, we could manage that with a helper macro. Assigning
a value to the same field of a struct should be ok by the compiler, and
should cause only the last assignment to be taken into use. So:

static struct foo zab =3D {
	.bar =3D 123, /* ignored */
	.bar =3D 234, /* used */
};

And so we could have:

static struct omap_dss_driver my_panel_driver =3D {
	OMAPDSS_DEFAULT_PANEL_OPS, /* macro for default ops */

	.enable =3D my_panel_enable,
	/* ... */
};

 Tomi



--------------enigD96AADA057894D8D0FBB0EEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRIeb5AAoJEPo9qoy8lh71GpkP/iMqIw5ashVQFxJmz6RRxbKk
wW+XcZxRn/62+OXpaygA6YkwJ/4IUoqVxwMGOIC58C2+LEAbqiITi5gqjlYh67kq
7K82lkCug0W4fRk9/D58eWybD86JVdsUbcTmtfIe6UCFsD4xcd0Onw9TGCrDPXBQ
VKakdCZnw0/aEpBxqM/PVHRKjubgT9MspW5lSMTrbOLw42GF9efxMHKWKIsPyIka
p58TgfoZDgduFy0MCbMCMEMoBX4BV8dV9j1AEEYvkkfi754B+i/xLHaYOleHU6Ti
Y7d7u1Omgv/PZLI05p6n2B83gScYGhu/kpjsT9Y4k86Fby49mgJOQuC8XCCI9ZwB
UKroQhHEGN6wIPjpGuSMjXaK96sHWa9gHQeaJMHPVfexNwzBTVzTerKdar7s/9mF
QHM2ATrTBV35YqKf8DgUAaDLTX1Y7ifDvj2p+wdXKba6gtppFXRkcZ7tSnAV8rCl
QpTCJQA26zx7jOGZafBkCbFFy9uBkt8LcriLEmm/4GNg+F0kKFX1vT+yeciUFR5k
pevoErouQqknQHoT5DcW3ItQM0lE5WjtsOjx/RITLemon1Cg6zEHdG34n5+owXD/
wdukygBoeGzX8J/VQhfsPpv3qdbBxjLYqnRXKJOF6HY9v/DUNRj/zegRlaHjFMeS
Q2qTulyaZcrmFWjWUDl2
=+v1d
-----END PGP SIGNATURE-----

--------------enigD96AADA057894D8D0FBB0EEE--
