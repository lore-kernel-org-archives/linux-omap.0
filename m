From: Felipe Balbi <balbi@ti.com>
Subject: Re: omap-usb-tll build broken in linux next
Date: Thu, 20 Sep 2012 22:29:44 +0300
Message-ID: <20120920192943.GB12417@arwen.pp.htv.fi>
References: <20120920183442.GH28835@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:39042 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab2ITTef (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Sep 2012 15:34:35 -0400
Received: by lbbgj3 with SMTP id gj3so2886522lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 12:34:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120920183442.GH28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Samuel Ortiz <sameo@linux.intel.com>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 20, 2012 at 11:34:42AM -0700, Tony Lindgren wrote:
> Hi Keshava & Felipe,
>=20
> Looks like we have something broken in linux next:
>=20
> make[2]: *** No rule to make target `drivers/mfd/omap-usb-tll.o', needed =
by `drivers/mfd/built-in.o'.  Stop.
>=20
> This is at least with my n8x0 config, see the attached file.

I guess this is related to Keshava's latest series. Samuel had to apply
things manually, maybe a git add was missed for the new file ?

--=20
balbi

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQW26nAAoJEIaOsuA1yqREqDQP/jTq+u5UGD2QDkycrzReRe6n
8DRstj7f8Rx/xWQDjUusGhjEMgozaJUhc5C/TRyIdSd/KmATpo1bDqWpM515ChY6
OvQlj7R//t7ILHBdBJT0751HfcaIfkiqMJfHkhbdcqI8Fkox9bGUmFMe86uN6sbw
WSftSPxF4HavapiNPGv5nd/HzR4WTphOOeNlYo9zVnvIpwGBLA79jo/HKk09brvK
oPHc3IA9dCTvju62uou+v8h0sFA3eTmHzi8iBSK2tVinjXLJccqx1u9bn0k831bi
B4CXjmPzc3KofyA3m3DAi1W/1kVK3uJKSPQzpba+W54FF/VGdSiWK24dyur2OOWT
RDmFAxfY6NuJ3lEZTlH9spfpmd6MaRty9lIHsoUMHRczUq50grJaofGAFnjLN5ab
Y8SIshyHBa8cIf6d67aOUSULAgaVYFJ9IMGPnBEXSNgUv52xeHwIKLj0t97qEYQx
3oCpjIfwy9XuRAOGJFekXOVgF9sv3plAyteJf/Gh8OMe3pCQW60K1zBduEKTRz0A
Gu7hhbnp9lka3yyXpdo1Hql59w+pk9j2GTfh0WAAjXU1JVqa3eFCp6MSpcfzPHSe
O++AYnRsHg1VRrL4YFNKsiZPciMCgNWoyo8JJeF+4A2ns4UZeHJ08I3y0TLooAvl
dqrMKi1qME/pYVQrToij
=nzgi
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
