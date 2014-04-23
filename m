From: Nishanth Menon <nm@ti.com>
Subject: linux-next regressions (next-20140423 A15: uevm/dra7)
Date: Wed, 23 Apr 2014 08:47:45 -0500
Message-ID: <5357C481.4090906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44910 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbaDWNrq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 09:47:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>

Hi,

Will be great if someone else could confirm as well.

next-20140423-multi_lpae_defconfig
 1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2HJJ9SKzM
 2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2HoDCbtO0
TOTAL = 2 boards, Booted Boards = 0, No Boot boards = 2

next-20140423-multi_v7_defconfig
 1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2070nXdAg
 2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s20wKQEqGp
TOTAL = 2 boards, Booted Boards = 0, No Boot boards = 2

next-20140423-omap2plus_defconfig
 1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2XrqUmRqz
 2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2gQkdoTH4


Exactly the same setup (rootfs and bootloader) as of yesterday's built
image:
next-20140422-omap2plus_defconfig
 1: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s20sRLHVgN
 2: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20ZxlYWaB
TOTAL = 2 boards, Booted Boards = 2, No Boot boards = 0


-- 
Regards,
Nishanth Menon
