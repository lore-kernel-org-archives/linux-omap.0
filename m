From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 4/5] usb: dwc3: omap: Pass VBUS and ID events transparently
Date: Tue, 10 May 2016 13:05:13 +0300
Message-ID: <871t5ai5ye.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-5-git-send-email-rogerq@ti.com> <87d1oui6eh.fsf@linux.intel.com> <5731B155.6010109@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B155.6010109@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> On 10/05/16 12:55, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq@ti.com> writes:
>>> Don't make any decisions regarding VBUS session based on ID
>>> status. That is best left to the OTG core.
>>>
>>> Pass ID and VBUS events independent of each other so that OTG
>>> core knows exactly what to do.
>>>
>>> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>=20
>> I have a feeling this will regress OMAP5432 uEVM. Did you test with that
>> board ?
>>=20
>
> Yes. Any specific test case you would like me to test?
> For now I'm just doing enumeration with g_zero.

IIRC OMAP5 uEVM didn't have separate VBUS and ID GPIOs. How are you
handling that case ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbJZAAoJEIaOsuA1yqREMF4P/RbsFxnGXsFt8fflHl+gV9wd
YXgZ0/T6Jg2oYyRE9FUhmPqb7hb/+Jj6jwwAEW+kJb9Qc1AlaVj9WkM1HfKQ8NOv
gNb3h6ZHKMK2zNrQ0GavI0fHsEsuu9CkYte1TzBCxaWdNMJR8bV1oquETox0gKRK
JHJdt7d4lx2rEmCwH7ldV0yF802oThxXN3M+l9WQPSiD2BoRtf9TnJgHuHGerXY+
mWpb1/6e+EzekZt1iOrJD85i6VrpVkxkAtkAHetqZPsNUZRpYF2ju26GAXsyx8zh
MGUdvOS0ZROuhFoWzz6GjcYYuxr+9VDuEk7VSLZ+Z92rkVWQEGTbeobF7JT0fqJH
zX4ym2gdcqgI0rWbFRZQQwp97mGURvcWxZOxJznplvH6NlJMgFao6+bO+sxAjM3o
RtZLrjj6VY91ShY9M5mXL0fTaCYfkHBd3ANz0KmUUcT2ATJr5FZ0/WInTfaHjfiZ
fQ4lf6PiRJtc+C6JicaBHoAT3WFb/ZRlEctXva54M25O9XDI9l1NKWAuIrxNXNik
ZiVXwNltFDMSfOJEkEcpRQdsQjCkzFg8W1eUHuAv6hRBG00PrH2WJHylYw3xF1Ht
tQraXNIPEMtq9YLqB56huv67M2xWvU3SiHOCmfzOSGtG8d5yU6u1KIOMgQhIBieI
6jhg6vmR13KOZqIDkph9
=ad47
-----END PGP SIGNATURE-----
--=-=-=--
