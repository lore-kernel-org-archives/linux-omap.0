From: green <greenfreedom10@gmail.com>
Subject: Re: N810: external mmc died?
Date: Wed, 29 Jul 2009 13:12:31 -0600
Message-ID: <20090729191231.GO7597@swansys>
References: <20090729182948.GN7597@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBPbvmIlJjvpbu6L"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:59280 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZG2TSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 15:18:25 -0400
Received: by wa-out-1112.google.com with SMTP id j5so147866wah.21
        for <linux-omap@vger.kernel.org>; Wed, 29 Jul 2009 12:18:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090729182948.GN7597@swansys>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--zBPbvmIlJjvpbu6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'll try again, the message was botched up somehow with ^M everywhere...


I was working on moving Debian's root from internal mmc (because it still=
=20
doesn't work with linux-omap) to external mmc, running standard Maemo and=
=20
connected by USB to the MMC cards (with the cards mounted), when suddenly t=
he=20
N810 reset.  I have no idea why, but now external MMC does not work.

I have been using this card for a while and have not had any problems with =
it;=20
it surely can also be considered still nearly 'new'.

I reflashed Maemo with the latest RX-44_DIABLO_5.2008.43-7_PR_COMBINED_MR0_=
ARM=20
(and checked md5sum) and now I get the following from dmesg with either an =
open=20
or close of the external MMC slot.

[ 2292.843750] menelaus 1-0072: Setting voltage 'VMMC' to 3100 mV (reg 0x0a=
, val 0xf8)
[ 2292.953125] menelaus 1-0072: Setting voltage 'VMMC' to 3000 mV (reg 0x0a=
, val 0xb8)
[ 2295.320312] menelaus 1-0072: Shutting off 'VMMC'

No device ever shows up in /dev, only mmcblk0 (the internal MMC).  When I=
=20
connect by USB to the MMC cards, I see in the logs on my Debian system:

kernel: scsi 43:0:0:0: Direct-Access     Nokia    N810              031 PQ:=
 0 ANSI: 2
kernel: scsi 43:0:0:1: Direct-Access     Nokia    N810              031 PQ:=
 0 ANSI: 2
kernel: sd 43:0:0:0: [sdb] 3932160 512-byte hardware sectors: (2.01 GB/1.87=
 GiB)
kernel: sd 43:0:0:0: [sdb] Write Protect is off
kernel: sd 43:0:0:0: [sdb] Mode Sense: 0f 00 00 00
kernel: sd 43:0:0:0: [sdb] Assuming drive cache: write through
kernel: sd 43:0:0:0: [sdb] 3932160 512-byte hardware sectors: (2.01 GB/1.87=
 GiB)
kernel: sd 43:0:0:0: [sdb] Write Protect is off
kernel: sd 43:0:0:0: [sdb] Mode Sense: 0f 00 00 00
kernel: sd 43:0:0:0: [sdb] Assuming drive cache: write through
kernel: sdb: sdb1
kernel: sd 43:0:0:0: [sdb] Attached SCSI removable disk
kernel: sd 43:0:0:0: Attached scsi generic sg1 type 0
kernel: sd 43:0:0:1: [sdc] Attached SCSI removable disk
kernel: sd 43:0:0:1: Attached scsi generic sg2 type 0

No information about the external MMC.

Thanks for any hints.

--zBPbvmIlJjvpbu6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpwnx8ACgkQ682C+dBP+oRqKACdEBEhNKPzikT+05tIiVMqjAMi
wf8AnR+J27+Kuk8cHSCuHBb31yfTiksq
=4H3n
-----END PGP SIGNATURE-----

--zBPbvmIlJjvpbu6L--
