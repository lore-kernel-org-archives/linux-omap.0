From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] usb: dwc3: core.h: add some register definitions
Date: Mon, 20 Jun 2016 15:04:48 +0300
Message-ID: <8760t4qd5r.fsf@linux.intel.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com> <1465564650-27516-2-git-send-email-rogerq@ti.com> <87fus8qkep.fsf@linux.intel.com> <5767D921.60509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5767D921.60509@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> Roger Quadros <rogerq@ti.com> writes:
>>> Add OTG and GHWPARAMS6 register definitions
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  drivers/usb/dwc3/core.h | 84 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>>  1 file changed, 83 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>> index 8fb6361..32bb7531 100644
>>> --- a/drivers/usb/dwc3/core.h
>>> +++ b/drivers/usb/dwc3/core.h
>>> @@ -197,6 +197,15 @@
>>>  #define DWC3_GCTL_GBLHIBERNATIONEN	(1 << 1)
>>>  #define DWC3_GCTL_DSBLCLKGTNG		(1 << 0)
>>>=20=20
>>> +/* Global Status Register */
>>> +#define DWC3_GSTS_OTG_IP	BIT(10)
>>> +#define DWC3_GSTS_BC_IP		BIT(9)
>>> +#define DWC3_GSTS_ADP_IP	BIT(8)
>>> +#define DWC3_GSTS_HOST_IP	BIT(7)
>>> +#define DWC3_GSTS_DEVICE_IP	BIT(6)
>>> +#define DWC3_GSTS_CSR_TIMEOUT	BIT(5)
>>> +#define DWC3_GSTS_BUS_ERR_ADDR_VLD	BIT(4)
>>> +
>>>  /* Global USB2 PHY Configuration Register */
>>>  #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
>>>  #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
>>> @@ -269,7 +278,12 @@
>>>  #define DWC3_MAX_HIBER_SCRATCHBUFS		15
>>>=20=20
>>>  /* Global HWPARAMS6 Register */
>>> -#define DWC3_GHWPARAMS6_EN_FPGA			(1 << 7)
>>> +#define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
>>> +#define DWC3_GHWPARAMS6_OTG3SUPPORT		BIT(13)
>>> +#define DWC3_GHWPARAMS6_ADPSUPPORT		BIT(12)
>>> +#define DWC3_GHWPARAMS6_HNPSUPPORT		BIT(11)
>>> +#define DWC3_GHWPARAMS6_SRPSUPPORT		BIT(10)
>>> +#define DWC3_GHWPARAMS6_EN_FPGA			BIT(7)
>>=20
>> Keep consistency, we don't use BIT() here.
>>=20
> Checkpatch was complaining.

then you should first convert everything to BIT() first, right?

> But I can revert to the non BIT format for consistency.

works for me.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ9vgAAoJEIaOsuA1yqREJ9kQAKHEtKdoznv+3iKa5vIV+yRE
nDHRv2LNasZz+1wpqhk2qEJpaBEsRllKvNccXSefzxWTFc2alE2dN+c5Jne6rQOL
Bvh8eCwdTIjNrjXUN2+uKAUt/M1N6N1o88w2KvpIPRrVetUww6f4Jgs+lIYodB5S
FQDT3XFzTuwEQ/1nFIna43obaXWpM/u9NnBSAtI1vop5q5SemkTIv/ZhM6e9ahOv
Y97fxk78YKOolQZaC5Og11LCHohLP2Q+9JaQ9UP/6pEij3r8eR5Enx5ml2+B/9s3
1YP1Une2YOikAWjhn+UNAAYgnIYHK0sA3BkNmyk+EdUMEiXhHEhKbseDWq//05Ry
Zfrv6dG0ywwbVPhySAw1ItPXOfOl5h2rr3CkAjaz/7ZnuHVwPySAFZoUhOt28UzC
c8bLlt6nZnPW71z0QaZNSGJWKZ1b5EdFmHdPVeVVcxk6o2jfh0RWdTV1muohM1Lz
K0FK1GYxQ6rL1IfqEHUV+l2j8YiMwGlk2+DqAu1RKSM2Gm3AY49Wj4yIlsO/ndEL
OO0UusU1mnVapadA7vNN2drGO3LnC0qMg25Ry417nCCTsTBQ8qPvRJF+crBFFujE
bbnNURe8xlrmkUhKq3kCk4QXdhdEC0uOykJGGGH98r8Qlho9ZbRFH6mYhmTH1Jwj
mHb4H6jyl6uNbDv4i6Tq
=ao3d
-----END PGP SIGNATURE-----
--=-=-=--
