From: green <greenfreedom10@gmail.com>
Subject: Re: N810: linux-2.6.26-rc2-omap1 with muru.com N810 patches
Date: Thu, 15 May 2008 11:54:48 -0500
Message-ID: <20080515165448.GB8875@swansys>
References: <20080515140914.GA30594@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:13208 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYEORCL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 13:02:11 -0400
Received: by py-out-1112.google.com with SMTP id u52so438179pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 10:02:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080515140914.GA30594@swansys>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2008.05.15, 136, green wrote:
> I have built a Debian Sid armel chroot on the N810 and have compiled many=
=20
> kernels in the chroot.  I send the kernels to the N810 using the flasher =
(-f=20
> -k $IMAGE -R).

I've also built 2.6.26-rc2-omap1 (with muru.com N810 patches) on my amd64=
=20
system using the gnueabi tools from emdebian.org.

gcc 4.3.0-4
binutils 2.18.1~cvs20080103-4

Same results.
>  - The NOKIA splash screen is displayed for about 20 seconds and then the=
 N810=20
> powers off.

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILGrY682C+dBP+oQRAlsbAKD4LBV5QE83jc50dA3QfUzd8AxnvQCglYCb
o4ZCrw59jLB1wK2ByN8eQQ8=
=yFyT
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
