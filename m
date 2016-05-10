From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 3/5] usb: dwc3: omap: Don't set POWERPRESENT
Date: Tue, 10 May 2016 13:04:33 +0300
Message-ID: <874ma6i5zi.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-4-git-send-email-rogerq@ti.com> <87futqi6gs.fsf@linux.intel.com> <5731B118.1010705@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B118.1010705@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> On 10/05/16 12:54, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq@ti.com> writes:
>>> TRM [1] recommends that POWERPRESENT bit must not be
>>> set and left at it's default value of 0.
>>>
>>> [1] OMAP542x TRM - http://www.ti.com/lit/pdf/swpu249
>>> Section 23.11.4.5.1 Mailbox VBUS/ID Management
>>>
>>> "Because PIPE powerpresent has a different meaning in host and in devic=
e mode,
>>> and because of the redundancy with the UTMI signals, the controller ORes
>>> together the appropriate PIPE and UTMI inputs to create its internal
>>> VBUS status. For that reason, it is recommended to leave field
>>> USBOTGSS_UTMI_OTG_STATUS[9] POWERPRESENT at its default value (=3D0), a=
nd only to
>>> fill in the USB2 VBUS status fields in the same register."
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>=20
>> to make sure we avoid regressions, do you mind sharing on which
>> platforms you tested this patch ?
>>=20
> I tested this on omap5-uevm and dra7-evm.
> My am437x board stopped working so couldn't test on that one.

would you have a colleague or perhaps an automated test-farm which could
run the test for you ? :-)

I can take the patch, no problem, but if there are any regressions don't
blame me :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbIxAAoJEIaOsuA1yqRE+4QP/3CxMQo9HtsYMHj+uxrzfAQj
o6H75+ByqRL36COwrQAmp1HVd+74netyNkRo11dqMEwfou6Z4BIAnDB8Nr9wSCdD
wkUCVBe52gxhvGqt9uKi+JvUZoBprMRm3kY4L+WNGLqzW6UOzNMY77S+HRDfCNE0
X6s4XhoFvIX3tj3IJXBVl3U9aznPnfqZYw9ZfUuHs/Ep8z2yecwlLQsKEPpNRQID
w/EvihPejdgkgZ4md0uTDBgDPHFh+tGkRP4ao7Jba4TfNZ6ex4GY+5Olk1FDk1Oy
h18e3dWyTWKEgqG+N3AsA/f6wb72In1Qe2J4c3AJTFEtxcWNpl0IHIvp5rWrxN9z
7wjwBI3iiCRD77kDQ0SMOSIBbOHtXmlLmD164I7uRMEaE8IoSx37Ni1FRSIGK/ss
D69OdOUwbtmPeKD0fh2LJ5TLhel1/E/9ALqVE1UIbdsMlFwkZ9ejqe4F3NTULFjU
OYMbOeBNLbzlyjPRgR3ufUdC+rGZyWqVHk30zRHG6IPFRUyq10+0RgzE19qLuoj8
Fz3GDHDUvfChPi9VDJ4UhJpJhgNG/+hlzTSKrowHJp5HCXs1uClxsyUwkQAb1djr
DDzO0TCxuWyBAEuzmVDWct4mqs4Q4FmFfJEgi3mK0j0Ofp8CgofNrsmKyYBJrgtG
WKfAMnY3ZtWMA5zDRbGB
=JL9k
-----END PGP SIGNATURE-----
--=-=-=--
