From: green <greenfreedom10@gmail.com>
Subject: N810: external mmc died?
Date: Wed, 29 Jul 2009 12:29:48 -0600
Message-ID: <20090729182948.GN7597@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvAn5G4Ewe70kJ1i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:52478 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbZG2S3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 14:29:52 -0400
Received: by yxe26 with SMTP id 26so1648490yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 29 Jul 2009 11:29:52 -0700 (PDT)
Content-Disposition: inline
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--LvAn5G4Ewe70kJ1i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was working on moving Debian's root from internal mmc (because it still =
=0D
doesn't work with linux-omap) to external mmc, running standard Maemo and =
=0D
connected by USB to the MMC cards (with the cards mounted), when suddenly t=
he =0D
N810 reset.  I have no idea why, but now external MMC does not work.=0D
=0D
I have been using this card for a while and have not had any problems with =
it; =0D
it surely can also be considered still nearly 'new'.=0D
=0D
I reflashed Maemo with the latest RX-44_DIABLO_5.2008.43-7_PR_COMBINED_MR0_=
ARM =0D
(and checked md5sum) and now I get the following from dmesg with either an =
open =0D
or close of the external MMC slot.=0D
=0D
[ 2292.843750] menelaus 1-0072: Setting voltage 'VMMC' to 3100 mV (reg 0x0a=
, val 0xf8)=0D
[ 2292.953125] menelaus 1-0072: Setting voltage 'VMMC' to 3000 mV (reg 0x0a=
, val 0xb8)=0D
[ 2295.320312] menelaus 1-0072: Shutting off 'VMMC'=0D
=0D
No device ever shows up in /dev, only mmcblk0 (the internal MMC).  When I =
=0D
connect by USB to the MMC cards, I see in the logs on my Debian system:=0D
=0D
kernel: scsi 43:0:0:0: Direct-Access     Nokia    N810              031 PQ:=
 0 ANSI: 2=0D
kernel: scsi 43:0:0:1: Direct-Access     Nokia    N810              031 PQ:=
 0 ANSI: 2=0D
kernel: sd 43:0:0:0: [sdb] 3932160 512-byte hardware sectors: (2.01 GB/1.87=
 GiB)=0D
kernel: sd 43:0:0:0: [sdb] Write Protect is off=0D
kernel: sd 43:0:0:0: [sdb] Mode Sense: 0f 00 00 00=0D
kernel: sd 43:0:0:0: [sdb] Assuming drive cache: write through=0D
kernel: sd 43:0:0:0: [sdb] 3932160 512-byte hardware sectors: (2.01 GB/1.87=
 GiB)=0D
kernel: sd 43:0:0:0: [sdb] Write Protect is off=0D
kernel: sd 43:0:0:0: [sdb] Mode Sense: 0f 00 00 00=0D
kernel: sd 43:0:0:0: [sdb] Assuming drive cache: write through=0D
kernel: sdb: sdb1=0D
kernel: sd 43:0:0:0: [sdb] Attached SCSI removable disk=0D
kernel: sd 43:0:0:0: Attached scsi generic sg1 type 0=0D
kernel: sd 43:0:0:1: [sdc] Attached SCSI removable disk=0D
kernel: sd 43:0:0:1: Attached scsi generic sg2 type 0=0D
=0D
No information about the external MMC.=0D
=0D
Thanks for any hints.=0D

--LvAn5G4Ewe70kJ1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpwlRwACgkQ682C+dBP+oQK6wCgp0J3wkYVurYywk0DfFcjN8ZV
DQgAn0CLpb+QB6MEELB1UR3LQBRFzFYB
=1mJ0
-----END PGP SIGNATURE-----

--LvAn5G4Ewe70kJ1i--
