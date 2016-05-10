From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 4/5] usb: dwc3: omap: Pass VBUS and ID events transparently
Date: Tue, 10 May 2016 13:13:21 +0300
Message-ID: <87vb2mgr0e.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-5-git-send-email-rogerq@ti.com> <87d1oui6eh.fsf@linux.intel.com> <5731B155.6010109@ti.com> <871t5ai5ye.fsf@linux.intel.com> <5731B436.6020801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B436.6020801@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>> Don't make any decisions regarding VBUS session based on ID
>>>>> status. That is best left to the OTG core.
>>>>>
>>>>> Pass ID and VBUS events independent of each other so that OTG
>>>>> core knows exactly what to do.
>>>>>
>>>>> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>
>>>> I have a feeling this will regress OMAP5432 uEVM. Did you test with th=
at
>>>> board ?
>>>>
>>>
>>> Yes. Any specific test case you would like me to test?
>>> For now I'm just doing enumeration with g_zero.
>>=20
>> IIRC OMAP5 uEVM didn't have separate VBUS and ID GPIOs. How are you
>> handling that case ?
>>=20
> It comes from the PMIC, extcon-palmas.c.

alright, then :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbRBAAoJEIaOsuA1yqREwYMP/0hvjq4gshhktoAftQiP24tk
4YE4nDBcuR0zrUAX0EWsBLd4fmzFUebJxqYEXKhMYjB12esZzj5stfJP2HR+gSQs
kExJeqBCP2FVT21/IGP7QGu9c/6oRagdpCfEYUrefKysp87pcu3Ml+0zroUGtiSb
TftqQbaGtkQ1wHtbi5kp5aZFdFmBR8hc1r8oX+Ybf7LCCwZdejT1HPxhot9QC2dY
RslWWCSPVXOhyVORCaT9bkCySVbf3wBDl1dl2h57Kec4VtyHk6aJ+Wlc1r3XzEP8
boNbnpKkQvtdRC2JznsXZgY7pXs5mkguXpOlqll1gan2bpveF+Ng5yhZU5pGkyCN
+q4HqiG6CKtkfaTyoRR0csGsgWoaflS7vwfBOKNH6yQ/C58qf2gkWVrtp0cdmLfz
FeuibFjGZMBB56uJNKmnwbOoyNzV1NcAqGR9z394xYB0LZ/62DBY8t5Xh/ZUDaB7
qA8kJOwYD+H8he9XUlbL0hPL3CtKOVzm+DHZREBrUTDvkxtoad4S2X5gs/f5L64J
qJ7YlS+y0gmeque8e1pexrQA1BIs/AiJH/6kyNYNmWbKABW9sLFmU6BOyhz6NaAE
754ByA7mW++Yl3kfkgejHQYeVrELVd1a8iLEPyQ9xFtJuWulJq86L0sbYTl10VGt
8BIvhGY+7N4v/ZAeG1oA
=POAO
-----END PGP SIGNATURE-----
--=-=-=--
