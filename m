From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/44] outer cache changes
Date: Fri, 28 Mar 2014 13:50:00 -0500
Message-ID: <5335C458.8070202@ti.com>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37335 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbaC1Sub (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 14:50:31 -0400
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap <linux-omap@vger.kernel.org>

On 03/16/2014 07:13 PM, Russell King - ARM Linux wrote:
> This patch series is where I'm currently at with the total mess which
> is L2 cache support.  That's putting it mildly.  This isn't intended
> for anyone to pick up - this is still mostly in development.

Quick boot test against v3.14-rc8 showed no regressions for the
platforms I ran through - ofcourse, the tests are basic boot, and
unfortunately not any comprehensive cache performance tests.


russell-l2c-fc0adeb-v3.14-rc8-test-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20BepYQRE
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2UN5rONP3
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s24AcPGSZL
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2IArYgC7S
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s20JBi80c7
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s21KDOKenY
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2lXBwgynB
 8: beaglebone:  Boot PASS: http://slexy.org/raw/s2KzNGNIBt
 9: OMAP3430-Labrador(LDP):  Boot FAIL: http://slexy.org/raw/s21ekHLEY5
(legacy problem - fix in linux-next)
10: pandaboard-es:  Boot PASS: http://slexy.org/raw/s20dKIf8sa
11:    sdp2430:  Boot PASS: http://slexy.org/raw/s20jxn1zA5
12:    sdp3430:  Boot PASS: http://slexy.org/raw/s21m0nx262
13:    sdp4430:  Boot PASS: http://slexy.org/raw/s21IxkfYTm
14: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20AKR1hRy
TOTAL = 14 boards, Booted Boards = 13, No Boot boards = 1

Vs:

v3.14-rc8-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21CKn6A7h
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20eC7gQ9T
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20amKvVx5
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2yVk3doef
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s22SsOWHaY
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s21TDD4jhW
 7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s20ltoXaiZ
 8: beaglebone:  Boot PASS: http://slexy.org/raw/s2DkrTbwG3
 9: OMAP3430-Labrador(LDP):  Boot FAIL: http://slexy.org/raw/s2JDOKtx9U
(legacy problem - fix in linux-next)
10: pandaboard-es:  Boot PASS: http://slexy.org/raw/s21WGaaGut
11:    sdp2430:  Boot PASS: http://slexy.org/raw/s2Nr9p1Zyf
12:    sdp3430:  Boot PASS: http://slexy.org/raw/s2kh0cfpGC
13:    sdp4430:  Boot PASS: http://slexy.org/raw/s2Q6VyjmyW
14: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s216EEpDwU
TOTAL = 14 boards, Booted Boards = 13, No Boot boards = 1


Please feel to add:
Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
