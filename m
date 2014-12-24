From: Nishanth Menon <nm@ti.com>
Subject: v3.19-rc1 regression(?) on N900
Date: Wed, 24 Dec 2014 16:57:38 -0600
Message-ID: <549B44E2.6080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbaLXW5j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Dec 2014 17:57:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>

based on automated testing with u-boot as a chained bootloader..

v3.18: boots fine:
https://github.com/nmenon/kernel-test-logs/blob/v3.18/omap2plus_defconfig/n900.txt

v3.19-rc1: hung
https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc1/omap2plus_defconfig/n900.txt

in the interim, my farm had a bit of breakdown around the time of n900
breakdown..

as per my last functional linux-next logs:
https://github.com/nmenon/kernel-test-logs/blob/next-20141204/omap2plus_defconfig/n900.txt
-> hung.
https://github.com/nmenon/kernel-test-logs/blob/next-20141112/omap2plus_defconfig/n900.txt
-> working.

DEBUG_LL, CONFIG_DEBUG_OMAP3UART3=y and early_printk did not yield
information either

Note: I am using the combined uImage+dtb image.[2]

I think this might just be my setup..(i use chained loader ->
NOLO->u-boot->serial download->kernel) but anyways.. Since Pali
thought others might be interested in sharing experience...

[1]   http://slexy.org/raw/s2osxhhwbR
[2]
https://github.com/nmenon/linux-2.6-playground/commit/177f5f71b3f21ea484ee4b09a2e0c015de522417

-- 
Regards,
Nishanth Menon
