From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Problem with early debugging (arch/arm/boot/compressed/head.S)
Date: Fri, 16 Dec 2016 07:34:48 +0100
Message-ID: <20161216073448.1da2d374@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/b9_AFNorlAo8edEGNsaSVhq"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/b9_AFNorlAo8edEGNsaSVhq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear All,

My SoC: Cortex-A15, TI (AM57xx)

My setup: Linux v4.9: tag v4.9-rc8

Toolchain: TI's SDK:
ti-am572x-idk-sdk/linux-devkit/sysroots/x86_64-arago-linux/usr/bin/arm-linu=
x-gnueabihf-

I'm trying to get early print messages on UART1 (0x4806a000).

Relevant .config defines:

CONFIG_DEBUG_LL=3Dy
CONFIG_DEBUG_LL_INCLUDE=3D"debug/omap2plus.S"
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DEBUG_OMAP2UART1=3Dy

've enabled debugging in the arch/arm/boot/compressed/head.S file (#define =
DEBUG).

Unfortunately I do have following errors:

CC arch/arm/boot/compressed/decompress.o
arch/arm/boot/compressed/head.S: Assembler messages:
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `sub =
,r3,r1'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `ldr =
r3,[,#0]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `ldr =
r1,[,#4]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `str =
r3,[,#0]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `str =
r3,[,#4]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `str =
r3,[,#8]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `str =
r3,[,#0]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `str =
r3,[,#4]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `str =
r3,[,#8]'
arch/arm/boot/compressed/head.S:1286: Error: ARM register expected -- `ldr =
,[,#8]'
arch/arm/boot/compressed/head.S:1286: Error: shift expression expected -- `=
add r3,r3,'
arch/arm/boot/compressed/head.S:1286: Error: shift expression expected -- `=
add r1,r1,'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `sub =
,r3,r1'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `ldr =
r3,[,#0]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `ldr =
r1,[,#4]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `str =
r3,[,#0]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `str =
r3,[,#4]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `str =
r3,[,#8]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `str =
r3,[,#0]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `str =
r3,[,#4]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `str =
r3,[,#8]'
arch/arm/boot/compressed/head.S:1304: Error: ARM register expected -- `ldr =
,[,#8]'
arch/arm/boot/compressed/head.S:1304: Error: shift expression expected -- `=
add r3,r3,'
arch/arm/boot/compressed/head.S:1304: Error: shift expression expected -- `=
add r1,r1,'
scripts/Makefile.build:393: recipe for target 'arch/arm/boot/compressed/hea=
d.o' failed

Those are related to loadsp macro (also defined in head.S file), which
is very short:

 .macro	loadsp,	rb, tmp
	        push {r7}
	        addruart r7, \rb, \tmp
	        pop {r7}
		.endm

Any ideas how to fix this issue? Any hints?

I initially thought that this is compiler configuration issue - but
those errors are on many compilers (also incliding TI's SDK compiler).

Any ideas or hints how to proceed?

Best regards,

=C5=81ukasz Majewski


--Sig_/b9_AFNorlAo8edEGNsaSVhq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhTixEACgkQf9/hG2YwgjEyLgCdEg70gMj02GS25NNCutZoRuSE
SI8An3xwboV1HshEGGh7lZcLoxCOkPnL
=pvJX
-----END PGP SIGNATURE-----

--Sig_/b9_AFNorlAo8edEGNsaSVhq--
