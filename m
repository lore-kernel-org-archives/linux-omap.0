From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/26] ARM: OMAP2+: add omapdss_init_of()
Date: Fri, 13 Dec 2013 10:40:53 +0200
Message-ID: <52AAC815.1020704@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-6-git-send-email-tomi.valkeinen@ti.com> <2199639.FbGhznOLP9@avalon> <52A96603.5030709@ti.com> <52AAC615.504@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="s5eEUC6CIkhaO1lo238NtgqWtBrq3UA3J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3LMIk7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 03:40:59 -0500
In-Reply-To: <52AAC615.504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--s5eEUC6CIkhaO1lo238NtgqWtBrq3UA3J
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 10:32, Archit Taneja wrote:
> On Thursday 12 December 2013 01:00 PM, Tomi Valkeinen wrote:
>> On 2013-12-12 01:10, Laurent Pinchart wrote:
>>> Hi Tomi,
>>>
>>> On Wednesday 04 December 2013 14:28:32 Tomi Valkeinen wrote:
>>>> omapdss driver uses a omapdss platform device to pass platform speci=
fic
>>>> function pointers and DSS hardware version from the arch code to the=

>>>> driver. This device is needed also when booting with DT.
>>>>
>>>> This patch adds omapdss_init_of() function, called from
>>>> board-generic at
>>>> init time, which creates the omapdss device.
>>>
>>> Is this a temporary solution that you plan to later replace with DT-o=
nly
>>> device instantiation ?
>>
>> It's a long term task to remove the "virtual" omapdss device. Removing=

>> the platform data that we pass has been very difficult.
>=20
> Even if we remove the platform data, what would be the right place to
> register the drm, fb and vout devices? We need to make sure their
> drivers are probed only after omapdss is initialised.

That's the same issue as we have already, so removing omapdss doesn't
affect that.

I don't think we have any good way to ensure those devices are not
probed before omapdss. We just have to manage the case that omapdss has
not been probed yet, by checking if omapdss is there and if not, return
EPROBE_DEFER.

>> For example, we need to get the OMAP revision to know which OMAP DSS
>> hardware we have. We can't get that information from the DSS hardware
>> (thank you, HW designers! ;).
>>
>=20
>> Another is DSI pin muxing. I think we need a new pinmuxing driver for
>> that, or maybe change pinmux-single quite a bit. The DSI pinmuxing is
>> very simple, but the register fields are varying lengths and at varyin=
g
>> positions, so pinmux-single doesn't work for it.
>=20
> I have seen other OMAP drivers passing control module register info to
> their DT node. Instead of having a pinmux driver for a single register,=

> we might want to consider just passing the control module register, and=

> take care of the reg fields and masks in the OMAP DSI driver itself.

Yes, that's also one option. Quite ugly, though =3D).

 Tomi



--s5eEUC6CIkhaO1lo238NtgqWtBrq3UA3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqsgVAAoJEPo9qoy8lh71JpoP/2v09d+PoSv6MIAcO9uStrsy
pjP15fvNDJQFbF9o9VFE2GqEZ5EU9NrfQAd7Zc8F7mX0vVHscvflKcDOvWczbtF0
bZtKqZB3VtwhG1PQHRYx7lZPUWaCQ4iKgNiBGSoiT75gcA5w4taPY6Jd/Bk781zl
e9SaRnA6FFWQXQZgUCMixbfYXv8QqJKNBSl4utYKTWwbOpO1ZKsMCDsnteC2OvEB
E1d5vUCRqAhQNAToDDXLtkpjg60MmufLEgmTQn+zNO/AQRU+ag0qNdgUFEW2G7xE
ojZSnHtrlP6mxIBV9Ylz/StHVv84kL5fr11KNoydPNJ0vOFKpTSM8O6sKTjbgQCN
YAKDd47jiiVTpxeqdpqsN1gaaBNvS9EDNVz64WPww7K5e57kQpqQsLLtfE0RVByo
cGc35Kh/sAcpYzBmvB92rB4HrwSiuhsGREwAoHJNE54imkhPxgpJPVYMz8SoQMDc
SQBEr9VoxHcjFx9iwiu2tlRQkHFbfogJRTJ4mT/GIwhmbOha736f8lTjbU+F9FsZ
TrMR1VVGYNlasmufVHKnEhjhMnY+DwIDcvfARgiSV+KSwVRR6AApVQzSjms5dS79
L5r2vROrtolXJ8JdvdgXmkQUzdUhpEB1ROYpuIYFsPJ1Lp70mIPkefd87LllEZnU
+CElrHYVfhO8XFMGRmva
=G2CS
-----END PGP SIGNATURE-----

--s5eEUC6CIkhaO1lo238NtgqWtBrq3UA3J--
