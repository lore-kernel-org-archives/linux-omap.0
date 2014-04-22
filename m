From: Nishanth Menon <nm@ti.com>
Subject: regressions in linux-next?
Date: Tue, 22 Apr 2014 08:18:24 -0500
Message-ID: <53566C20.6000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35562 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbaDVNSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 09:18:25 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s3MDIPEN012160
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 08:18:25 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s3MDIP5C004495
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 08:18:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

next-20140422-omap2plus_defconfig
 1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
 2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
 3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
 4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
 5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
>known
 6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX
 7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3icwS
 8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
 9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
12: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2N3afw0TI
13:       n900:  Boot PASS: http://slexy.org/raw/s21qmT6XCJ
14: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s28vlMGdeh
15: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20yHoGHdW
16:    sdp2430:  Boot PASS: http://slexy.org/raw/s20i8Ir3yn
17:    sdp3430:  Boot PASS: http://slexy.org/raw/s20t4VTeEB
18:    sdp4430:  Boot FAIL: http://slexy.org/raw/s21SHcOP01
19: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2qmlRZped
TOTAL = 19 boards, Booted Boards = 9, No Boot boards = 10

next-20140417-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2Yvz8RRkn
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2JFbaPPVA
>farm issues. - But peter reports fail as well.
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s29h2lXGuw
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s20Whu6Qjr
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21jBdk51T
 6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2118uUlle
>known.
 7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s29I92x0p3
 8: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s2GqJbMp7C
>farm issues
 9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2fb7JvizO
10: beaglebone:  Boot PASS: http://slexy.org/raw/s2uQNDnOlV
11: craneboard:  Boot PASS: http://slexy.org/raw/s2pTk8AgdX
12: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s2r2XdK8XF
13: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s213f9wx5p
14:       n900:  Boot PASS: http://slexy.org/raw/s2SaNcFG85
15: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2fR7PoakJ
16: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2IMJ75sNc
17:    sdp2430:  Boot PASS: http://slexy.org/raw/s207NAmPbO
18:    sdp3430:  Boot PASS: http://slexy.org/raw/s20Yzlg3lU
19:    sdp4430:  Boot PASS: http://slexy.org/raw/s21eYIZxtI
20: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2HIEtrDX9
TOTAL = 20 boards, Booted Boards = 17, No Boot boards = 3

next-20140416-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20LxN1Qn4
 2:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s202mfovsx
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2IAJlhTFg
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s213AOULx7
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s22NCBg38K
 6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s2IhClBS3N
>known
 7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2octtFj30
 8: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s20t9axfIr
 9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21FvZM0Gz
10: beaglebone:  Boot PASS: http://slexy.org/raw/s2119uANhW
11: craneboard:  Boot PASS: http://slexy.org/raw/s2FoVFiYaC
12: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s2FJjqu4MU
13: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s29X2FBMhu
14:       n900:  Boot PASS: http://slexy.org/raw/s2AcjThjhw
15: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2LF8KsxJw
16: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2E2KTBSFY
17:    sdp2430:  Boot PASS: http://slexy.org/raw/s20HnXbU9M
18:    sdp3430:  Boot PASS: http://slexy.org/raw/s20OuKg9mw
19:    sdp4430:  Boot PASS: http://slexy.org/raw/s25V9CJgUB
20: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21WFeZmTd
TOTAL = 20 boards, Booted Boards = 18, No Boot boards = 2

-- 
Regards,
Nishanth Menon
