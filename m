From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl support
Date: Thu, 06 Sep 2012 10:27:30 +0200
Message-ID: <50485E72.7010900@pengutronix.de>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com> <50473D92.9000500@pengutronix.de> <504759B4.6060203@pengutronix.de> <20120905232609.GL1303@atomide.com> <331ABD5ECB02734CA317220B2BBEABC13EA27D69@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0EE4EBC362DA897C283FD01"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA27D69@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0EE4EBC362DA897C283FD01
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/06/2012 08:09 AM, AnilKumar, Chimata wrote:
> On Thu, Sep 06, 2012 at 04:56:10, Tony Lindgren wrote:
>> * Marc Kleine-Budde <mkl@pengutronix.de> [120905 06:55]:
>>> On 09/05/2012 01:54 PM, Marc Kleine-Budde wrote:
>>>> On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
>>>>> Adds suspend/resume functionality of d_can driver along with d_can
>>>>> raminit support which is required to initialize RAM while data
>>>>> transmission.
>>>>>
>>>>> This patch series also adds pinctrl support to c_can driver. These
>>>>> patches were tested on AM335x-EVM.
>>>>>
>>>>> This patch-series is based ontop of runtimePM patch submitted
>>>>> earlier - https://patchwork.kernel.org/patch/1348081/
>>>>
>>>> Looks good, I'll apply the series after Tony acks the patch 3
>>>> ([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata t=
o
>>>> pass d_can raminit).
>>>
>>> I've pushed all patches to can-next/master [1]. When Tony gives his A=
ck,
>>> I'll send David a pull request (of a tree including that Ack).
>>
>> To me it looks like we can avoid the platform callbacks and the ram
>> init changes to the driver by implementing right runtime PM calls
>> for omap/am33xx. So NAK on few patches, and ACK on one :)
>>
>=20
> Marc,
>=20
> Can you please queue ACK patch for 3.7, I will submit v3 for rest of
> the patches, once we found the clear way of doing RAMINIT.

Done. I've updated the master branch on my repo[1]. I'll send a pull
request to David soon.

Marc

[1] https://gitorious.org/linux-can/linux-can-next
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE0EE4EBC362DA897C283FD01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBIXnYACgkQjTAFq1RaXHMsKwCglo19FHu1HKmILOxFOGO5OoVl
dNMAoJBBvPWnpVEL/dMJcIxCkwroKYX6
=s6tw
-----END PGP SIGNATURE-----

--------------enigE0EE4EBC362DA897C283FD01--
