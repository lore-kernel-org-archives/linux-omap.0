From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: Boot process stuck on 3430SDP ES3.0
Date: Tue, 11 Nov 2008 15:20:35 -0600
Message-ID: <A24693684029E5489D1D202277BE894413BEFCB1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57972 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbYKKVUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 16:20:43 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mABLKbTw008283
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 15:20:42 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mABLKbYq006071
	for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2008 15:20:37 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I'm having this trouble in an apparently random fashion. The boot process seems to be stuck at this point:

********************** Log start **********************
...
<6>i2c /dev entries driver
i2c /dev entries driver
<4>Driver 'sd' needs updating - please use bus_type methods
Driver 'sd' needs updating - please use bus_type methods
<6>omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
<6>Using buffer write method
Using buffer write method
<6>Using auto-unlock on power-up/resume
Using auto-unlock on power-up/resume
<5>cfi_cmdset_0001: Erase suspend on write enabled
cfi_cmdset_0001: Erase suspend on write enabled
<7>erase region 0: offset=0x0,size=0x40000,blocks=512
<7>omapflash.0: program region size/ctrl_valid/ctrl_inval = 1024/16/16
<7>omapflash.0: 1 set(s) of 1 interleaved chips --> 8 partitions of 16384 KiB
<5>Creating 4 MTD partitions on "omapflash.0":
Creating 4 MTD partitions on "omapflash.0":
<5>0x00000000-0x00040000 : "Bootloader-NOR"
0x00000000-0x00040000 : "Bootloader-NOR"
<5>0x00040000-0x00080000 : "Params-NOR"
0x00040000-0x00080000 : "Params-NOR"
<5>0x00080000-0x00280000 : "Kernel-NOR"
0x00080000-0x00280000 : "Kernel-NOR"

********************** Log stop **********************

I'm using an 3430SDP-VG5.0.1 (ES3.0) board. Any ideas why this could be happening?

Regards,
Sergio
