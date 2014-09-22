From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v4 5/5] mtd: nand: Constrain omap_elm to built-in
Date: Mon, 22 Sep 2014 16:15:00 -0300
Message-ID: <54207534.9040104@vanguardiasur.com.ar>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1411231996-6387-6-git-send-email-ezequiel@vanguardiasur.com.ar> <20140922185849.GT1193@ld-irv-0074>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UoDeQiAJMXDo2JOKQUxdvck6exdGMpKiP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:58514 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbaIVTQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2014 15:16:19 -0400
Received: by mail-qg0-f44.google.com with SMTP id f51so3481930qge.31
        for <linux-omap@vger.kernel.org>; Mon, 22 Sep 2014 12:16:18 -0700 (PDT)
In-Reply-To: <20140922185849.GT1193@ld-irv-0074>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UoDeQiAJMXDo2JOKQUxdvck6exdGMpKiP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 09/22/2014 03:58 PM, Brian Norris wrote:
> On Sat, Sep 20, 2014 at 05:53:16PM +0100, Ezequiel Garcia wrote:
>> This fixes the following build error when omap2_nand is chosen built-i=
n,
>> and omap_elm is chosen as a module:
>>
>>   drivers/mtd/nand/omap2.c:2010: undefined reference to `elm_config'
>>   drivers/mtd/nand/omap2.c:1980: undefined reference to `elm_config'
>>   drivers/mtd/nand/omap2.c:1927: undefined reference to `elm_config'
>>   drivers/mtd/nand/omap2.c:1444: undefined reference to `elm_decode_bc=
h_error_page'
>>
>> Fix this by making omap_elm a 'bool' driver.
>=20
> Hmm, so we're sacrificing a "feature" (that omap2 + omap_elm can both b=
e
> built as modules) because we haven't solved one particular developer UI=

> inconsistency (that we don't prevent the config combination of
> MTD_NAND_OMAP2=3Dy and MTD_NAND_OMAP_BCH=3Dm)? I wouldn't tend to sacri=
fice
> the feature for the sake of a bad config.
>=20

FWIW, I agree with you, as already said to Roger.
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--UoDeQiAJMXDo2JOKQUxdvck6exdGMpKiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUIHU0AAoJEIOKbhOEIHKi+HwP/RCa3PoaAEtjpr5+62VfOESl
utNY6SNljX/0fRuSNAnasuPoYqzcRPv0+Skbv4V91IU9NuoZtNDn1rwC/tAqWaTV
zMjFbRL8mzxAPfvONhjJO2/D+hmU2wgzMc8cBzHVO9fV7UyZKf704clFfQmS5TFf
sGXIvRm8BcpVEDQgnETLlijbkp0zH16seCiXqARd6otAFYmyD4vaNm+mpc6wL3H0
9Qmj/pfpwZj7dwEi5Zaa/U3VKQeUTnk9e2eVm0SXdYuz63k4+QP4rqapDdq16ZnU
Rs14xcRL7e9MgBTZ8mcnQz9NvMutgGNWjORRhiHDH+2BYXygqmWQnhYi22vhAZ9H
tDcAXZMrudIdmi+Sknd1RSdJNa0D+LHpFiWmzrQnRb/qjCCKNomRJfxCUDbAtTJA
k7GriciYoiupEq6zvtTy1siXHn8yTJl45mbRtfrhSRyehbbnUhS2QK+mnLAl/DoZ
gzsB6U8wlsJ+7fDloG/FIosaGLCjnIKyRwKwDAp+hRVX0o4kdHa+0S2iJJrYqq/H
MiddfIOPpRZrQB+3hUW8lzL0/ec0YNtLfVL87xqU24mRmio2L5cnP/lVckVn2DC0
eQLLYr89HlmXlrc/yhsYzTYiQ7mRphZt0WQauyb1+tSW5F6DY2AxuQId5hp5v5UR
lOdGau3ngVSTrF+rKDOG
=Y+R8
-----END PGP SIGNATURE-----

--UoDeQiAJMXDo2JOKQUxdvck6exdGMpKiP--
