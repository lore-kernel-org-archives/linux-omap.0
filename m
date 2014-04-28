From: Nishanth Menon <nm@ti.com>
Subject: next-20140428 (regression: DEADLOCK)
Date: Mon, 28 Apr 2014 07:51:03 -0500
Message-ID: <535E4EB7.5010605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51258 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836AbaD1MvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 08:51:04 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s3SCp4JG028213
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 07:51:04 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s3SCp4mw004312
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 07:51:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

omap2plus_defconfig shows for the following platform deadlock with
console_lock.

 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2biDSRTAP
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20deZjf34
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21NM1bLxs
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2022AFyZ6
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21Dq284CM
 6: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2aK24U5ON
 7: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s21j15I8kK
 8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21jO02jIK
 9: craneboard:  Boot PASS: http://slexy.org/raw/s22JGqMSfY
10: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s260y1Opd1
11:       n900:  Boot PASS: http://slexy.org/raw/s20IDKmJ6L
12: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2dJcyep9A
13:    sdp2430:  Boot PASS: http://slexy.org/raw/s20Oldnm8I
14:    sdp3430:  Boot PASS: http://slexy.org/raw/s2Mo7s3ttZ
15: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s2qXj7HFTJ


 =============================================
 [ INFO: possible recursive locking detected ]
 3.15.0-rc2-next-20140428-00002-gd0ca5e6 #1 Not tainted
 ---------------------------------------------
 swapper/0/0 is trying to acquire lock:
  (console_lock){+.+...}, at: [<c07d1124>] con_init+0xc/0x28c

 but task is already holding lock:
  (console_lock){+.+...}, at: [<c008c224>] vprintk_emit+0x200/0x590

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(console_lock);
   lock(console_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 1 lock held by swapper/0/0:
  #0:  (console_lock){+.+...}, at: [<c008c224>] vprintk_emit+0x200/0x590


-- 
Regards,
Nishanth Menon
