From: Felipe Balbi <balbi@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 15:15:28 +0300
Message-ID: <20120514121527.GF22242@arwen.pp.htv.fi>
References: <1336996151.2333.3.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HkfZ6fDZyisrdUtK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:47603 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752624Ab2ENMRR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 08:17:17 -0400
Received: by lbbgj10 with SMTP id gj10so3970016lbb.23
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 05:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336996151.2333.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org


--HkfZ6fDZyisrdUtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 14, 2012 at 02:49:11PM +0300, Tomi Valkeinen wrote:
> Hi Felipe,
>=20
> I'm seeing the following crash on Panda, when booting with today's
> linux-next, using the attached config.
>=20
>  Tomi
>=20
>=20
> [    1.923400] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
> [    1.923400] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000036
> [    1.938171] pgd =3D c0004000
> [    1.941009] [00000036] *pgd=3D00000000
> [    1.944763] Internal error: Oops: 5 [#1] SMP ARM
> [    1.949584] Modules linked in:
> [    1.952789] CPU: 0    Not tainted  (3.4.0-rc7-next-20120514-10436-g776=
9ab8 #450)
> [    1.960540] PC is at kobject_get+0xc/0x4c
> [    1.964721] LR is at get_device+0x14/0x1c
> [    1.968933] pc : [<c0250d60>]    lr : [<c02ac47c>]    psr: 20000113
> sp : ebc31d98  ip : 00000003  fp : eb36d1dc
> [    1.979553] r10: eb36c128  r9 : eb349880  r8 : fc0ab000
> [    1.985015] r7 : eb348408  r6 : c06f2830  r5 : eb348408  r4 : 0000001a
> [    1.991851] r3 : eb349880  r2 : 00000000  r1 : c04bf2b4  r0 : 0000001a
> [    1.998687] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt kernel
> [    2.006317] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
> [    2.012329] Process swapper/0 (pid: 1, stack limit =3D 0xebc302f8)
> [    2.018615] Stack: (0xebc31d98 to 0xebc32000)
> [    2.023162] 1d80:                                                     =
  eb349880 c0c788f4
> [    2.031707] 1da0: eb348408 c02ac47c eb349880 c033d604 eb36c128 c035bdc=
8 c035bdb0 0000007c
> [    2.040283] 1dc0: eb348400 00000010 eb348408 c047dddc ebeba630 0000000=
0 c0c76fd8 eb348408
> [    2.048828] 1de0: c0c76fd8 c0c76fe8 00000000 c071c0ac 00000000 c0728b8=
0 0000009e c02b0e68
> [    2.057373] 1e00: c02b0e50 c02afab8 c02b10f0 eb348408 c02afcd0 0000000=
0 00000000 c0c76f94
> [    2.065948] 1e20: c0728b80 c02ae1dc ebc412d8 ebebbe94 eb348408 eb34843=
c c070fbc0 c02af9dc
> [    2.074493] 1e40: eb348408 eb348408 c070fbc0 c02aefb8 eb348408 eb34841=
0 ebd7c808 c02ad840
> [    2.083038] 1e60: c06f8438 00000000 ebebbd78 eb3498c0 ebebbd40 c069044=
4 00000000 eb348400
> [    2.091583] 1e80: eb348408 00000003 eb3498c0 ebebbd40 c0690444 c0728b8=
0 0000009e c02b1480
> [    2.100158] 1ea0: eb348400 00000000 ebd7c808 eb3498c0 ebd7dd00 c047e7a=
0 ebd7c808 c0c76fd8
> [    2.108703] 1ec0: c0c76fe8 00000000 c071c16c c02b0e68 c02b0e50 c02afab=
8 22222222 ebd7c808
> [    2.117248] 1ee0: c071c16c ebd7c83c 00000000 c067882c c0728b80 c02afcc=
c c071c16c c02afc38
> [    2.125793] 1f00: 00000000 c02ae258 ebc412a8 ebd76790 c071c16c c070fbc=
0 ebebbdc0 c02af16c
> [    2.134368] 1f20: c0598c20 00000000 ebc489c0 c071c16c c0728b80 ebc3000=
0 00000000 c067882c
> [    2.142913] 1f40: c0690444 c0728b80 0000009e c02b0200 00000000 c067884=
4 c0728b80 ebc30000
> [    2.151458] 1f60: 00000000 c067882c c0728b80 c0008730 c061fe04 c06207e=
4 c149014e c066dbe4
> [    2.160003] 1f80: c0678850 00000000 c05dc310 00000001 00000006 0000000=
6 c058cec4 c0678844
> [    2.168579] 1fa0: 0000001c 00000006 c0678850 c067882c c0690444 c0728b8=
0 0000009e c0647928
> [    2.177124] 1fc0: 00000006 00000006 c06471c4 00000000 00000000 0000000=
0 c0647810 c0014f34
> [    2.185668] 1fe0: 00000013 00000000 00000000 00000000 00000000 c0014f3=
4 81aaaa8a 3a80a8aa
> [    2.194244] [<c0250d60>] (kobject_get+0xc/0x4c) from [<c02ac47c>] (get=
_device+0x14/0x1c)
> [    2.202697] [<c02ac47c>] (get_device+0x14/0x1c) from [<c033d604>] (usb=
_get_transceiver+0x1c/0x28)
> [    2.212005] [<c033d604>] (usb_get_transceiver+0x1c/0x28) from [<c035bd=
c8>] (omap2430_musb_init+0x
> 18/0x184)
> [    2.222106] [<c035bdc8>] (omap2430_musb_init+0x18/0x184) from [<c047dd=
dc>] (musb_probe+0x1bc/0x5a
> 0)
> [    2.231567] [<c047dddc>] (musb_probe+0x1bc/0x5a0) from [<c02b0e68>] (p=
latform_drv_probe+0x18/0x1c

looks like MUSB is probing before transceiver driver... could it be ?
Can you check transceiver has actually probed ? I guess panda's using
twl6030-usb.c

--=20
balbi

--HkfZ6fDZyisrdUtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsPdeAAoJEIaOsuA1yqREF/8P/R6u5X1ghpoKZrnkzs/ETy5S
EQsWnUCIlv8ttFnB63CIJtfcxQxN5PeoYR7+BntAitLEIZvckRviBoK/Wt4GZ/FS
SgvtWJ+ufJBSoU1n4lZiHF+zbgdb2crhq0NcTK/Y5mbMmkJMfXqFv5G5WmuAVsKU
GNjRs5djDRUvgV5CsqWATa++PU/F2Q7TJ/WiO5jH1S+6h+MLlV1Ojs/BTHQaren7
XtxtOzPrGX0ge9b2bJxM3QAwvoF6LWFYexvjQXf4S5al5a3AKbgSubm0rpG6Kfa+
NmwxqksoBsHi8lQWsGN25qJwV285I9MaEnP2Slq/lWAw86t/MjZuv1/+AgtTX5Xs
SAFran++4lq8dAT6coQ2WV33hQ3e+uKRaHTHZJtiiF8bsffYW2Vrr/mKnpDtrKWk
29RY7iblulGsEJNjA6pG5atSaUinU7uTyh7s311YbanqrJYlC4C3qt0y1E20dnz0
NE3hWDFNrj/qoreEdSnkEu1q+t+lINv8GmaqZj5XT6fLydz46yHjfb5aoynLht9/
zsteAcGpj951k3sI5OHVPhL+sP3RmXl6dXr9wm0hTwamfNl8B12ulEYYfnYDU2s8
XNE7Pob3+ELQofpb6AvFnFfM4khxBjMDG3K7JJ/ak2uTHXJA6n2m3p+L4rh71CrH
kkavIHG1CqM1m8E+iXKI
=1EED
-----END PGP SIGNATURE-----

--HkfZ6fDZyisrdUtK--
