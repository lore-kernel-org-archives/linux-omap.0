From: green <greenfreedom10@gmail.com>
Subject: N810 battery notes
Date: Sun, 9 Nov 2008 22:11:32 -0700
Message-ID: <20081110051132.GC8641@swansys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:45781 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbYKJFLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 00:11:51 -0500
Received: by el-out-1112.google.com with SMTP id z25so1041504ele.1
        for <linux-omap@vger.kernel.org>; Sun, 09 Nov 2008 21:11:49 -0800 (PST)
Content-Disposition: inline
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--E13BgyNx05feLLmH
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just some notes for the N810:

- Read battery voltage from /dev/retu with the kcbatt tool here:
http://mrrau.dyndns.org:23280/n800/kcbatt/

- Perhaps other things from this list could be read from /dev/retu the same=
=20
way, but I don't see the time here unfortunately:
http://marc.info/?l=3Dlinux-omap&m=3D120752529631862&w=3D2

- Set up bme for battery charging (use at your own risk of course):
1. Copy initfs to /root/initfs or somewhere
2. Put the two attached files in there and 'chmod +x' them
3. Run, as root: 'chroot initfs /c_bat' (after each boot)
4. Test; you should be able to charge your battery now

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=c_start

#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t tmpfs none -o size=512K /tmp
mkdir /tmp/dev
mknod /tmp/dev/retu c 10 $( grep retu /proc/misc | cut -d " " -f 2 )
mknod /tmp/dev/tahvo c 10 $( grep tahvo /proc/misc | cut -d " " -f 2 )
dsme -d -l stderr -v 0 -p /usr/lib/dsme/libstartup.so
waitfordsme

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=c_batt

#!/bin/sh
if ! test -e /tmp/dsme.pid ; then
 /c_start
fi
dsmetool -f "/usr/bin/bme_$( grep product /proc/component_version | cut -c 13- )"

--MW5yreqqjyrRcusr--

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkXwoQACgkQ682C+dBP+oTtmACeKHOoIfNmwuxRbenQUqbR/XI3
mRoAoNblVIrlTKtPEZ2v5yUwQCVSgSV3
=nkkO
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
