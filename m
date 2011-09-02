From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Fri, 2 Sep 2011 14:35:21 +0300
Message-ID: <20110902113519.GQ5148@legolas.emea.dhcp.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
 <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CBA8E@dbde02.ent.ti.com>
 <20110829083757.GD13925@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CBB7B@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L0TNCHh3fkwjpuuE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54187 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944Ab1IBLf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 07:35:27 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC4CBB7B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>


--L0TNCHh3fkwjpuuE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2011 at 03:16:55PM +0530, Gupta, Ajay Kumar wrote:
> I have compiled the differences in the register map between am35x and
> ti81xx and they are listed below.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Register			am35x [has one musb]	ti81xx [two musb interface]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> REVISION			0x00				0x0000 -> for USBSS
> 								0x1000 -> for musb0
> 								0x1800 -> for musb1
>=20
> ALL USBSS registers	Not present			Available from offset
> 								0x0000-0x0FFC
>=20
> USB_CTRL_REG		0x04				0x1014  -> for musb0
> 								0x1814  -> for musb1
>=20
> USB_STAT_REG		0x08				0x1018  -> for musb0
> 								0x1818  -> for musb1
>=20
> USB_EMULATION_REG		0x0c				Not present
> USB_AUTOREQ_REG		0x14				Not present
> USB_SRP_FIX_TIME_REG	0x18				Not present
> USB_TEARDOWN_REG		0x1c				Not present
>=20
> USB_IRQ_MERGED_STATUS	Present as part of		0x1020 -> for musb0
> 				EP_INTR_x or CORE_INTR_x	0x1820 -> for musb1
> 				register in am35x but
> 				at different offsets
>
> USB_IRQ_EOI			Same as above		0x1024 -> for musb0
> 								0x1824 -> for musb1
> USB_IRQ_STATUS_RAW_0	Same as above		0x1028 -> for musb0
> 								0x1828 -> for musb1
> USB_IRQ_STATUS_RAW_1	Same as above		0x102c -> for musb0
> 								0x182c -> for musb1
> USB_IRQ_STATUS_0		Same as above		0x1030 -> for musb0
> 								0x1830 -> for musb1
> USB_IRQ_STATUS_1		Same as above		0x1034 -> for musb0
> 								0x1834 -> for musb1
> USB_IRQ_ENABLE_SET_0	Same as above		0x1038 -> for musb0
> 								0x1838 -> for musb1
> USB_IRQ_ENABLE_SET_1	Same as above		0x103c -> for musb0
> 								0x183c -> for musb1
> USB_IRQ_ENABLE_CLR_0	Same as above		0x1040 -> for musb0
> 								0x1840 -> for musb1
> USB_IRQ_ENABLE_CLR_1	Same as above		0x1044 -> for musb0
> 								0x1844 -> for musb1
>=20
> EP_INTR_SRC_REG			0x20			Present as part of=20
> 								USB_IRQ_x register in
> 								ti81xx but at different
> 								offsets
> EP_INTR_SRC_SET_REG		0x24				Same as above
> EP_INTR_SRC_CLEAR_REG		0x28				Same as above
> EP_INTR_MASK_REG			0x2c				Same as above
> EP_INTR_MASK_SET_REG		0x30				Same as above
> EP_INTR_MASK_CLEAR_REG		0x34				Same as above
> EP_INTR_SRC_MASKED_REG		0x38				Same as above
> CORE_INTR_SRC_REG			0x40				Same as above
> CORE _INTR_SRC_SET_REG		0x44				Same as above
> CORE _INTR_SRC_CLEAR_REG	0x48				Same as above
> CORE _INTR_MASK_REG		0x4c				Same as above
> CORE _INTR_MASK_SET_REG		0x50				Same as above
> CORE _INTR_MASK_CLEAR_REG	0x54				Same as above
> CORE _INTR_SRC_MASKED_REG	0x58				Same as above
> USB_END_OF_INTR_REG		0x60				Same as above
>=20
> CPPI4.1 DMA	=09
> REVISION 				Not present			0x2000
> TEARDOWN FREE DESCRIPTOR	Not present			0x2004
> EMULATION CONTROL			Not present			0x2008
>=20
> TxCh0 GLOBAL_CONFIG		0x1800			0x2800
> RxCh0 GLOBAL_CONFIG 		0x1808			0x2808
> RxCh0 HOST_PKT_CFG_A		0x180c			0x280c
> RxCh0 HOST_PKT_CFG_B		0x1810			0x2810
> Similarly for all Ch till Ch #29	=09
>=20
> INTD REVISION			0x3000			Not present
> INTD EOI				0x3010			Not present
> INTD EOI Interrupt vector	0x3014			Not present
> INTD STATUS REG			0x3200-0x32FC		Not present
> QMGR REV				0x4000			0x4000
>=20
> Rest of CPPI4.1 DMA register offset are same	=09
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> If you compare am35x and da8x then you would find that they are mostly sa=
me
> and so should be merged. They both have one musb instances.
>=20
> Ti81xx has two musb interface and huge differences in register map as lis=
ted
> Above so ti81xx should be in a separate file.
>=20
> Apart from this, am35 and da8x is not yet runtime pm compatible but the c=
urrent
> patches supporting ti81x is runtime pm compliant.
>=20
> I think da8x and am35x files should be merged in a separate patch once th=
ey
> are tested after the merge.

Sure, let's try to merge them as soon as possible. Now, about this one.
I still think the wrapper is essentially the same, but the memory map is
different, right ? I mean, the programming model of the wrapper and its
features are the same, correct ? So, how about you abstract the memory
map by passing the address offsets via driver_data ? The thing is that
this is all duplicated code in a sense. Although the register map is
different, the HW block is the same, isn't it ? Just a few tweaks to
support multiple musb instances. In that case, I'm not very keen on
letting yet another very similar file to be added.

How about you add a very clean musb-dsps.c file (btw, at some point, I
want all glue layers to have musb- prepended to them) which, for now,
only handles this new chip, but it has memory map passed in via
driver_data ? Then it should be very simple to convert davinci, da8xx
and am35x to the new file.

You will probably need to revisit the other device's TRM to see what
needs to be abstracted or flaged somehow. What is board-specific and
what is silicon-specific and that sort of thing. But it will be a very
nice exercise and the output will be the deletion of three very similar
files.

--=20
balbi

--L0TNCHh3fkwjpuuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOYL93AAoJEAv8Txj19kN1Zm8H/ArUZ7/d98cxTsuAklWq/qLw
7TV3M+Yq9p4YmYbg3FBP/ZSY+T4jP/a79Gb7nQuUi6bkHpD58ls6ccGlSSrO4oAb
0xwtfhMVWDcPc1wdPMpFg6e7Kkx96ApU9B03OH4bP5t6k8ncGoRQzdcASPEOqbK6
6b65emEhgh3Ig+LKa57MxlXT49myvPF6V2zVNUrvLjlWGqEATxj5B7cNN8OZCHF0
GQUog1AN0nOHMsLEGsrsNK2XuH3JicKY9B72n4G8S4PhZhxNAYq+M14u5JjZEnWi
lTOz49l25AunESGY4mzQZ9E9G3KtW1/viwujwzj14E6eE6+atci8azMm/X58pCc=
=hCPV
-----END PGP SIGNATURE-----

--L0TNCHh3fkwjpuuE--
