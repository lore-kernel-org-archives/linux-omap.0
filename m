From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: multi_v7_defconfig: Enable more OMAP family platforms
Date: Thu, 9 Apr 2015 16:15:18 -0500
Message-ID: <1428614121-3374-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756221AbbDIVQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 17:16:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Nishanth Menon <nm@ti.com>

Hi,

As of next-20150409 tag, the following platforms (I have access
to) report failures for AM437x-sk and legacy beaglebone (white).
omap2plus_defconfig boots up fine on these platforms.

So, the basic minimum stuff I could pickup to fix up beaglebone-white
and am437x-sk.

This series is still missing the magic sauce for LDP - will try to
track that down later as well.

This series is based on next-20150409

multi_v7_defconfig (as on next-20150409)
 1:                     am335x-evm: BOOT: PASS: am335x-evm.txt
 2:                      am335x-sk: BOOT: PASS: am335x-sk.txt
 3:                     am3517-evm: BOOT: PASS: am3517-evm.txt
 4:                      am37x-evm: BOOT: PASS: am37x-evm.txt
 5:                      am437x-sk: BOOT: FAIL: am437x-sk.txt
 6:                    am43xx-epos: BOOT: PASS: am43xx-epos.txt
 7:                   am43xx-gpevm: BOOT: PASS: am43xx-gpevm.txt
 8:                 BeagleBoard-XM: BOOT: PASS: beagleboard.txt
 9:            beagleboard-vanilla: BOOT: PASS: beagleboard-vanilla.txt
10:               beaglebone-black: BOOT: PASS: beaglebone-black.txt
11:                     beaglebone: BOOT: FAIL: beaglebone.txt
12:                     craneboard: BOOT: PASS: craneboard.txt
13:                     dra72x-evm: BOOT: PASS: dra72x-evm.txt
14:                     dra7xx-evm: BOOT: PASS: dra7xx-evm.txt
15:         OMAP3430-Labrador(LDP): BOOT: FAIL: ldp.txt
16:                           n900: BOOT: PASS: n900.txt
17:                      omap5-evm: BOOT: PASS: omap5-evm.txt
18:                  pandaboard-es: BOOT: PASS: pandaboard-es.txt
19:             pandaboard-vanilla: BOOT: PASS: pandaboard-vanilla.txt
20:                        sdp3430: BOOT: PASS: sdp3430.txt
21:                        sdp4430: BOOT: PASS: sdp4430.txt

After this series:
 1:                     am335x-evm: BOOT: PASS: am335x-evm.txt
 2:                     am3517-evm: BOOT: PASS: am3517-evm.txt
 3:                      am37x-evm: BOOT: PASS: am37x-evm.txt
 4:                      am437x-sk: BOOT: PASS: am437x-sk.txt
 5:                    am43xx-epos: BOOT: PASS: am43xx-epos.txt
 6:                   am43xx-gpevm: BOOT: PASS: am43xx-gpevm.txt
 7:                 BeagleBoard-XM: BOOT: PASS: beagleboard.txt
 8:            beagleboard-vanilla: BOOT: PASS: beagleboard-vanilla.txt
 9:               beaglebone-black: BOOT: PASS: beaglebone-black.txt
10:                     beaglebone: BOOT: PASS: beaglebone.txt
11:                     craneboard: BOOT: PASS: craneboard.txt
12:                     dra72x-evm: BOOT: PASS: dra72x-evm.txt
13:                     dra7xx-evm: BOOT: PASS: dra7xx-evm.txt
14:         OMAP3430-Labrador(LDP): BOOT: FAIL: ldp.txt
15:                           n900: BOOT: PASS: n900.txt
16:                      omap5-evm: BOOT: PASS: omap5-evm.txt
17:                  pandaboard-es: BOOT: PASS: pandaboard-es.txt
18:             pandaboard-vanilla: BOOT: PASS: pandaboard-vanilla.txt
19:                        sdp3430: BOOT: PASS: sdp3430.txt
20:                        sdp4430: BOOT: PASS: sdp4430.txt
TOTAL = 20 boards, Booted Boards = 19, No Boot boards = 1

Nishanth Menon (3):
  ARM: multi_v7_defconfig: Enable beaglebone PMIC TPS65217
  ARM: multi_v7_defconfig: Enable AM437x PMIC TPS65218
  ARM: multi_v7_defconfig: Enable generic SoC internal OMAP regulators

 arch/arm/configs/multi_v7_defconfig |    6 ++++++
 1 file changed, 6 insertions(+)

Regards,
Nishanth Menon
-- 
1.7.9.5

