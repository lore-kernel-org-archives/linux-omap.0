From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 16:51:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306261641040.6135@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83ECC9548@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-584488462-1372265504=:6135"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53316 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab3FZQvp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 12:51:45 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECC9548@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rini, Tom" <trini@ti.com>, "khilman@ti.com" <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-584488462-1372265504=:6135
Content-Type: TEXT/PLAIN; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 Jun 2013, Hiremath, Vaibhav wrote:

> That=92s not quite true, I remember going through your log in detail mult=
iple
> Times.
>=20
> The issue is, for appended DTB you must enable 2 config options,
>=20
> CONFIG_ARM_APPENDED_DTB =3D y
> CONFIG_ARM_ATAG_DTB_COMPAT =3D y

Maybe you should look again.  Both of these options are set in the=20
am33xx_only Kconfig which is used here for the Beaglebone-White boot.


- Paul


$ find . -type f -name "am33xx_only" -exec fgrep -q CONFIG_ARM_APPENDED_DTB=
=3Dy '{}' ';' -print   |fgrep test_v3. | sort -t. -k3,3 -n
=2E/test_v3.7/20121211094536/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc1/20121017205513/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc2/20121020134755/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc3/20121028162003/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc4/20121104142910/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc5/20121111081034/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc6/20121117093152/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc7/20121127152704/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc8/20121204220128/build/am33xx_only/am33xx_only
=2E/test_v3.8/20130218214403/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc1/20121228031713/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc2/20130103093341/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc3/20130109222058/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc4/20130120122039/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc5/20130126003323/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc6/20130206155004/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc7/20130210080644/build/am33xx_only/am33xx_only
=2E/test_v3.9/20130429104339/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc1/20130312100243/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc2/20130314094808/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc3/20130317194234/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc4/20130324120244/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc5/20130331205513/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc6/20130410123059/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc7/20130414220303/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc8/20130422154921/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc1/20130518212204/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc2/20130527225935/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc3/20130527220737/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc3/20130603032237/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc4/20130603034317/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc5/20130609031534/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc6/20130616211951/build/am33xx_only/am33xx_only
$ find . -type f -name "am33xx_only" -exec fgrep -q CONFIG_ARM_ATAG_DTB_COM=
PAT=3Dy '{}' ';' -print   |fgrep test_v3. | sort -t. -k3,3 -n
=2E/test_v3.7/20121211094536/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc1/20121017205513/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc2/20121020134755/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc3/20121028162003/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc4/20121104142910/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc5/20121111081034/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc6/20121117093152/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc7/20121127152704/build/am33xx_only/am33xx_only
=2E/test_v3.7-rc8/20121204220128/build/am33xx_only/am33xx_only
=2E/test_v3.8/20130218214403/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc1/20121228031713/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc2/20130103093341/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc3/20130109222058/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc4/20130120122039/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc5/20130126003323/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc6/20130206155004/build/am33xx_only/am33xx_only
=2E/test_v3.8-rc7/20130210080644/build/am33xx_only/am33xx_only
=2E/test_v3.9/20130429104339/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc1/20130312100243/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc2/20130314094808/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc3/20130317194234/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc4/20130324120244/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc5/20130331205513/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc6/20130410123059/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc7/20130414220303/build/am33xx_only/am33xx_only
=2E/test_v3.9-rc8/20130422154921/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc1/20130518212204/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc2/20130527225935/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc3/20130527220737/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc3/20130603032237/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc4/20130603034317/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc5/20130609031534/build/am33xx_only/am33xx_only
=2E/test_v3.10-rc6/20130616211951/build/am33xx_only/am33xx_only

--843723315-584488462-1372265504=:6135--
