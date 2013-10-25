From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 14:33:26 +0300
Message-ID: <526A5706.5010803@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com> <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com> <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com> <526A526D.3010108@ti.com> <526A542D.8060801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OU8GVJ1AgjxfUhRBVIBq9BWU8UGThDt4F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43040 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab3JYLdu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 07:33:50 -0400
In-Reply-To: <526A542D.8060801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

--OU8GVJ1AgjxfUhRBVIBq9BWU8UGThDt4F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/10/13 14:21, Nishanth Menon wrote:

>> The problem here is that the gpios don't really belong to anyone in th=
e
>> kernel, as we don't have a driver for the switch.
>>
>> Or did you mean that we'd still have the code in dss-common.c, but jus=
t
>> get the gpio numbers from the .dts instead? That makes sense, although=

>> I'd want to get rid of that code altogether.
>>
>> Should we have support in the gpio-controller to define default values=

>> for gpios? I don't think we can rely on the boot loader to set things
>> correctly.
>>
>=20
> I am unfortunately, not in a position to know how you plan to
> architect dss_common or the various panels associated with it. if you

The dss-common.c is just a hack, needed during the transition to DT.
It's supposed to go away as soon as we have proper DT support for DSS.

In this case it has just been a convenient place to set the gpios at
boot time. The gpios are not touched after that.

> model these as panels and a generic driver which controls the panel
> could request and control pins and gpios as needed I suppose.
>=20
> gpio controller cannot drive default pull direction, that is the job
> of the driver using the gpio.

I agree. But what to do when there is no driver that uses the gpio, but
the gpio still affects the drivers? That's more or less the situation her=
e.

The SDP board has an LCD and a PicoDLP projector, and the board
designers have shared resources between those, meaning only one can be
used at a time.

Having the GPIO pulled down means that LCD2 won't have backlight
(although the gpio doesn't actually enable the backlight, it just
handles the routing if I'm not mistaken) , but PicoDLP will have
something (parallel video datalines, if I recall right).

I can't add that GPIO to either the LCD driver or the PicoDLP driver, as
it's not a property of either of them.

 Tomi



--OU8GVJ1AgjxfUhRBVIBq9BWU8UGThDt4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSalcGAAoJEPo9qoy8lh71pIIP/12q4uVvtiQgRUA7efYCq85W
dmAt7Z+ZX5FEHUIX9vaFLaJTwKa4z50pKcBG8VEhhOVNA4YEXB7GpPqFxk+lguNS
w29Y1TN2WfkRXgiSWIApndoVFDik6z9JWRJe+mP/GG+e9hTeUn8sdk4VoE0qImJt
/GB2yhpzvwTCBjOR6iaPRB5SMuYokER4dxfJky9HiZt05zZru+SYbqECeawLlRfJ
RI+13j+ic1lWqOeDu/PPKnFdZzzowHYI6eRkA+kyisDri7Fzy2v+tN6EUI55ciNR
84+d+uz9GmHjjc23nS0gQvdMiF9HidmyeqTVSbTD3P1AxgqTc55mAe6Z3SL03iSb
D2CBe18kDrtdDoAbJXauvS/l3r3NogqkKtfEocG4BMd4B23jf7y293NQeCwhKo2L
Zy4r/APJyz1OgYO8c0J0YlZohEur/Mm0GbueJdPIJ8ZdhzIU92unwYZpeds899bS
DWZvaGw+5nRnvUHIi1cUeBr6MekeBZOfo86gMY1JFiK7mxKq29Uu4Ao3AxcNq9QP
Z/IAlgM+ZE1SwKQdOrVZW8AzjkB6PxFKkJUVdu6vi6pZLrFNyfjfYoMELpbTAYYl
JIysyWWQ6NLhWVotxAisjCQGo3iqhLUGbBuRfiD6MATeYVhQfIi8coW3TrHGTKB8
gmxkTjzttCu0KTKA93Yb
=lWL0
-----END PGP SIGNATURE-----

--OU8GVJ1AgjxfUhRBVIBq9BWU8UGThDt4F--
