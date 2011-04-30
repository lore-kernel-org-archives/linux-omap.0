From: Sebastian Reichel <sre@debian.org>
Subject: problem with "undefined instruction"
Date: Sat, 30 Apr 2011 18:23:57 +0200
Message-ID: <20110430162357.GA14287@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:54315 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab1D3QYN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Apr 2011 12:24:13 -0400
Received: from sre.ring0.de (unknown [93.223.76.62])
	by smtp.ring0.de (Postfix) with ESMTP id 8962A81507
	for <linux-omap@vger.kernel.org>; Sat, 30 Apr 2011 16:23:59 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm currently trying to get a mainline based kernel running on my pandaboard.
The problem is, that it's crashing very early during the init phase because of
"undefined instruction" exceptions:

[    1.867980] udevd (56): undefined instruction: pc=401e6ed4
[    1.874603] Code: 9cd0 fffe e92d 4ff0 (ed2d)
[    1.977752] modprobe (69): undefined instruction: pc=400c6ed4
[    1.977783] Code: 9cd0 fffe e92d 4ff0 (ed2d)
[    1.978240] init (1): undefined instruction: pc=40149ed4
[    1.978240] Code: 9cd0 fffe e92d 4ff0 (ed2d)
[    2.005706] Kernel panic - not syncing: Attempted to kill init!

Exactly the same userland boots fine with the original 2.6.35 kernel, so it's
probably not the userland's fault. But I searched for the byte combination
anyway and found it in libc.so:

   32ecc:   9cd0        ldr r4, [sp, #832]  ; 0x340
   32ece:   fffe e92d   vtbl.8  d30, {d14-d15}, d29

00032ed0 <_IO_vfprintf>:
   32ed0:   e92d 4ff0   stmdb   sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
   32ed4:   ed2d 8b02   vpush   {d8}

Can you please tell me what's missing in my kernel? I uploaded
.config and full boot messages here:

http://elektranox.org/omap-kernel/config.txt (kernel's .config)
http://elektranox.org/omap-kernel/dmesg.txt (full boot output)

-- Sebastian

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNvDedAAoJENju1/PIO/qahvQP/Rf8ZW6VANweX4/tDBlu3Tn1
pgITEzBtiFPZl5Lgbnjgo47JAdmvOAnGImHpAQ25LVnaZSFbQyxQytuOSkL7tFb8
4k7uNuuHJ1PfHddMTaA6U0HhKNq1BlFAmConro+ecFsFXzA/n7v1TX9Xnxe4E0Jc
NMVwL15SN65zt8ICiCvcGRKQ1YkQqzgqkrUmB30wLdBxu28m8mznEl6Wq8sapZDW
Dl8Nda8z7AiL1ga11wzFgDuEJV472/9WnNozbvZN4Hq5C4cfx2bc66N7soeWGGYy
iF0IxGxRzHOieYjyCFNoE+2ylWxVxcyD6nnDOuP01a+NPgydbV/mAonO7DUnSAi1
7JB5bVj8u21mPMQwpfFFUxeN9HPp5y9HplMPq0+JQasl78n/r3w2REZ6rgXjE5c3
npsaRPSODCxrtLFc9xamO5C+U9Mn71fZCG3tQGdDsc5HosSW5+nSiSfW+y6BDR8o
L15G7CHKQ3+EZvvHObGbCKoh5RXmVUgPHlH1wGNQlI1xOL7AORLTfTHwb/b6bMWQ
TgoywPOy+hY9QrcNV1+XoTkPV8vTAXsJKe+kws1bTeaE17HeemYE1D29q/pAHYq5
eQFZhPbyThxa9d1sVCP7vfWCVVBagrFqV75jAIhg9OCD0YMNicWhtujT7SW8Xtky
GYd38M4JLFY9JvkrVHh4
=oJWG
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
