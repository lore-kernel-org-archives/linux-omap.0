From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 13:56:26 +0300
Message-ID: <87ziqen739.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-9-git-send-email-rogerq@ti.com> <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <20160620114904.GC26936@shlinux2> <8737o8qd00.fsf@linux.intel.com> <20160621060517.GA5108@shlinux2> <877fdjovef.fsf@linux.intel.com> <20160621090738.GD5108@shlinux2> <87h9cmoo4s.fsf@linux.intel.com> <20160621104321.GJ22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621104321.GJ22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Chen <hzpeterchen@gmail.com>, Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Felipe Balbi <balbi@kernel.org> [160621 03:06]:
>> 8<----------------------------------------------------------------------
>> 	vbus =3D read(VBUS_STATE); /* could be a gpio_get_value() */
>>         id =3D read(ID_STATE); /* could be a gpio_get_value() */
>>=20
>>         set_role(id);
>>         set_vbus(vbus);
>
> We should use regulator framework API for set_vbus() because of
> the delays involved bringing it up. And we already have separate
> PHY and charger chips where VBUS is provided by the charger chip.

yeah, no arguments there.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaR1aAAoJEIaOsuA1yqREk1oP/jr4Lu4TOrfM2t0/RTz16/lJ
a4as6W1SBEwe4+KSO5civ8dgbZN0FujEjOm0NNDXgIQyx8URDQp4JtIOOhsfUONE
H+onmSDxjU4EMND4P4Yy/BkKf1ih30MG+47U9+Q/xHTaZHoMTv1XzK5pN+YpC0To
2Md8iJWbxShotwbIiakF8TLRexVsULGI+sgbb6IYjVnj/y1Y+q8cFHS9z2DVnqnA
RUMdU7Eo+IHoO97M5tkCdYwBxgh1shPi7flipaF0VlSoxg8ZzN8WNq9kwBPrOjfq
A+tX93RX2WtosDZkf7F0Y/RiZleRKs4hSg6vQDz+hkqIPLeTPj8wnKmnStrDdJqH
Q3CX6rlKKcgownoxyZ2WLdJoZt9856ctrcbhubZRD3d2fWNmgtOVyb1nAe0DDEm+
3qR0ifSQIpM8srZsDbuvhV6YX2ADCMwbDyjJtxbDpx937dPGUCTPXtSHxCSJZgSc
Lzx6TnQ07Dx12J/Nd5YL+0aj3/GM+U5jCGjrjNGdYE4rEcVUdt3qwZAIL1uDwoi9
wyzKy8CDzinlICwHWXUT9PztEhfC+Eiynia+iiodHI29CV1b6BIb2OrB9+aM+htP
vR/6NL/ph6rRQTys6UDyLkkvtYO7AYhxM01VkFO5sguCQCzqOeAV9IJf6J6i2qqH
VZ/F2NdKMd0A3Szp3pqi
=hUAi
-----END PGP SIGNATURE-----
--=-=-=--
