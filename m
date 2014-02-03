From: Nishanth Menon <nm@ti.com>
Subject: v3.14-rc1 boot status
Date: Mon, 3 Feb 2014 10:53:36 -0600
Message-ID: <52EFC990.9050303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58348 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaBCQxl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Feb 2014 11:53:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, "tony@atomide.com" <tony@atomide.com>

Considering the major changes with clk nodes into DT, the following
are quick boot tests with device tree:

Quick boot sanity test (with a few patches for legacy platforms):

v3.14-rc1-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2AKEgkxU9
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20CdjJ4oo
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21053Cq8K
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21E6m0UOt
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s208teprqq
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s20OORN3oW
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s21f8QQAjn
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot PASS: http://slexy.org/raw/s21ZBXC2HR
10:        ldp:  Boot PASS: http://slexy.org/raw/s21ZpTCgWR
11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s21StYLTDC
12:    sdp2430:  Boot PASS: http://slexy.org/raw/s21pkJQBCC
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2P9r3VWN1
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2wbnRJ9Bt
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20DkN9UcU
TOTAL = 15 boards, Booted Boards = 14, No Boot boards = 1

v3.14-rc1-multi_v7_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21Vpd4BiB
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s21wdiu05m
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21pFN5cLj
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2A6AIA1gm
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21B55p49v
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s20LRQIVtP
 7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s21rflCYX9
 8:      crane: No Image built - Missing platform support?:
 9:       dra7:  Boot PASS: http://slexy.org/raw/s2029LQLsl
10:        ldp:  Boot PASS: http://slexy.org/raw/s21QHWjLUH
11: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s20OxI5Z34
12:    sdp2430:  Boot FAIL: http://slexy.org/raw/s21h8cCKLU
(expected fail: v6 platform)
13:    sdp3430:  Boot PASS: http://slexy.org/raw/s2l3ecrzah
14:    sdp4430:  Boot PASS: http://slexy.org/raw/s20lITWp6p
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2QkMn2zTL
TOTAL = 15 boards, Booted Boards = 13, No Boot boards = 2

-- 
Regards,
Nishanth Menon
