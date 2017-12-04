From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] ARM: dts: dra7: Disable USB metastability workaround for USB2
Date: Mon, 04 Dec 2017 13:40:11 +0200
Message-ID: <87r2sau3fo.fsf@linux.intel.com>
References: <1509456360-2638-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509456360-2638-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger Quadros <rogerq@ti.com> writes:

> The metastability workaround causes Erratic errors [1]
> on the HighSpeed USB PHY which can cause upto 2 seconds
> delay in enumerating to a USB host while in Gadget mode.
>
> Disable the Run/Stop metastability workaround to avoid this
> ill effect. We are aware that this opens up the opportunity
> for Run/Stop metastability, however this issue has never been
> observed in TI releases so we think that Run/Stop metastability
> is a lesser evil than the PHY Erratic errors. So disable it.
>
> [1] USB controller trace during gadget enumeration
>     irq/90-dwc3-969   [000] d...    52.323145: dwc3_event: event (0000090=
1): Erratic Error [U0]
>     irq/90-dwc3-969   [000] d...    52.560646: dwc3_event: event (0000090=
1): Erratic Error [U0]
>     irq/90-dwc3-969   [000] d...    52.798144: dwc3_event: event (0000090=
1): Erratic Error [U0]
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

FWIW:

Acked-by: Felipe Balbi <felipe.balbi@linux/intel.com>

I'm taking the dwc3 counterpart to v4.16

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlolNBsACgkQzL64meEa
mQaJKhAAwrGW59+8FpcvEnzfxnEzF9ANszx6ncYhoBnYaJAGeAPAZOyCiyu7FCqW
TBcJZLm7dVv5YATAKm6Pg5yO7164A/3A9si6D8UbxVdq702xCU3CLPNH39IoTuvT
A2x6pHm6MGVcSiQ0yPrEXzv03jeViuXmFwhzqeM1mKwjcfbph4vrg82GzJ6Zv0tF
BlLuU20EPnKQlKyK+XpwpeYhpyInSOe6BmCKIpEk9F+1vtz1J2b2T/DLv6OYN6Sw
x7D9wYZ2NpwMtgdMMY9lG6mnA4eO8jjV2/YIa+x1u3+LdUOcd/qOxz6oWwbPhPa1
PveGgEVTT3ii8kHIHJ5oSPOCfJAuz0RETIdCWoZl98m/Y1yKNeguF90KnMQolIhg
ob1aBCwT2AbVmJiOucAcuauRDPsbPXbfVBxHoVVSu+lTEww2AzR7IBNGe5xYy3Mn
zaQ5Qr1zmobJ/qeLwHyZdVHeOyNYWaNtK01P8U4g2THTjGDMajx8zEuCVXLZBagW
9T+je+AIy8rLJZxj+gfLz8WXMNytggZnW40wC5rYGq58kfJAUn0LCbPqCqp4pF+t
+3AybiNVXD5jdFwsf/JSwim/ocXWttLn8ikESIRY41nE179Buftd1IBxcfnxiZ3E
cMHU5nHUSOZeA21KFDmtE4x0y+UASvsh4roI0chyDHtZsFf7Gjo=
=DUWg
-----END PGP SIGNATURE-----
--=-=-=--
