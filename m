From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 03/27] ARM: OMAP2+: add omapdss_init_of()
Date: Tue, 17 Dec 2013 08:20:18 +0200
Message-ID: <52AFED22.2010703@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-4-git-send-email-tomi.valkeinen@ti.com> <20131216184623.GC26293@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nNf67hKkKXJumqoSaAL2jQ74tWTLOq2r4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3LQGU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 01:20:26 -0500
In-Reply-To: <20131216184623.GC26293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--nNf67hKkKXJumqoSaAL2jQ74tWTLOq2r4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-16 20:46, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 07:02]:
>> omapdss driver uses a omapdss platform device to pass platform specifi=
c
>> function pointers and DSS hardware version from the arch code to the
>> driver. This device is needed also when booting with DT.
>>
>> This patch adds omapdss_init_of() function, called from board-generic =
at
>> init time, which creates the omapdss device.
> ...
>=20
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -23,6 +23,8 @@
>>  #include <linux/clk.h>
>>  #include <linux/err.h>
>>  #include <linux/delay.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> =20
>>  #include <video/omapdss.h>
>>  #include "omap_hwmod.h"
>> @@ -514,3 +516,63 @@ int omap_dss_reset(struct omap_hwmod *oh)
>> =20
>>  	return r;
>>  }
>> +
>> +int __init omapdss_init_of(void)
>> +{
>> +	int r;
>> +	enum omapdss_version ver;
>> +
>> +	static struct omap_dss_board_info board_data =3D {
>> +		.dsi_enable_pads =3D omap_dsi_enable_pads,
>> +		.dsi_disable_pads =3D omap_dsi_disable_pads,
>> +		.get_context_loss_count =3D omap_pm_get_dev_context_loss_count,
>> +		.set_min_bus_tput =3D omap_dss_set_min_bus_tput,
>> +	};
>> +
>> +	ver =3D omap_display_get_version();
>> +
>> +	if (ver =3D=3D OMAPDSS_VER_UNKNOWN) {
>> +		pr_err("DSS not supported on this SoC\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	board_data.version =3D ver;
>> +
>> +	omap_display_device.dev.platform_data =3D &board_data;
>> +
>> +	r =3D platform_device_register(&omap_display_device);
>> +	if (r < 0) {
>> +		pr_err("Unable to register omapdss device\n");
>> +		return r;
>> +	}
>=20
> You can populate the callback functions in the pdata using
> OF_DEV_AUXDATA entries in the pdata-quirks.c. That way you could
> instantiate the dev entry for omap_display_device using DT
> and deal with it in drivers/video/omap except for the pdata
> callbacks.

The device we are creating here is not something to be created via DT.
So in addition to the devices that match to the DSS hardware blocks, we
have a 'omapdss' platform device. That's a legacy one, and it's
"virtual" in the sense that it doesn't match any HW block as such.

At some point the device should be removed totally, but for now it's
there and it's a convenient way to pass the platform data.

> Of course that can be done later too.

Yes, at the moment I'm trying to minimize the kind of code changes that
can be done later. It'd be great to get this into next merge window, but
time is running short if I do any bigger changes.

 Tomi



--nNf67hKkKXJumqoSaAL2jQ74tWTLOq2r4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSr+0mAAoJEPo9qoy8lh71S+AQAJf85EUf7gJjU2rRdEJrsM6W
UKIAT4d/SDqmNqlSLzjGR03rRKURXncRxAcw3rKoGbRBOhkKCNAuHIJYiEqvY6ys
fHLtYeLw/sj5qptJ6k5i6QZsP91ZjexVnm2hz/7okQO8MCHDQNQKzwMU5t818NLP
PoqMUm0cxMO/n/mMIGZoYsovpBn9NZef0+bpk7pSMYTk7B0WH4CmIobt3y5Nkhpq
OSRfvLQ5VLiI6T8cmrg0uMzbVda8kQCI8tzLJzXZ+VvoDmljDpy88ak98LZL3/mr
J2PcocGxj9N2WcRB7ZqWYm3CM/NztM8PkzPuQIaSQ2jcpxqpefWo7LYZGgRKz3cz
DxubZOHYfnceZglqP+zLCmJpcJlH9SucqQ98R0zTLul6s55pyuKnagpWPkzgrQXC
zuklKCwV/b4B0V9wmE332/mzaOa/c50+GFs9EmrxEh0dJQrilBrpkRo9kMiXy0Ed
yicnMaP5y0jyNmM9FAU3z3FlJpKPSE4eyfnUpMVPCd8NQtL4pl2XQUjHaSnWu7h3
CYJlZD5byetO/JXtRrgyFX9ci1wnXrdbNZEuOWWT27DxXkrhX7zfnlZMa0wssih7
XUPyE2JQ6nC4O7U2uVQuA2HvtNgEaqVKId2yPTrVq70iDcfm811Gy4+lDuWyk3yU
pN2ZxiFYNj322OXNsCH6
=oJVG
-----END PGP SIGNATURE-----

--nNf67hKkKXJumqoSaAL2jQ74tWTLOq2r4--
