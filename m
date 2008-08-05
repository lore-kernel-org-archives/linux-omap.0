From: "Abraham Arce" <abraham.arce.moreno@gmail.com>
Subject: Re: omap ldp board(3430) failed to read/write NAND flash device after booting from nfs
Date: Tue, 5 Aug 2008 10:31:25 -0500
Message-ID: <cb8016980808050831h698d7847g6c23c81724c6020c@mail.gmail.com>
References: <48986C5E.7090206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:17977 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502AbYHEPb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 11:31:26 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1486098ywe.1
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2008 08:31:25 -0700 (PDT)
In-Reply-To: <48986C5E.7090206@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zou Tao <zoutao51@gmail.com>
Cc: linux-omap@vger.kernel.org

Tao,

> I have booted the omap ldp board with nfs. I want to bootup from flash.
> so I want to test if linux kernel could read/write flash device.

before booting, execute a  'nand unlock' in u-boot

>> > / # dd if=/dev/mtblock4 of=test2  count=1

# dd if=/dev/mtdblock4 of=test2  count=1
1+0 records in
1+0 records out

>> > / # / # dd if=ext2.img of=/dev/mtdblock5 count=4

# dd if=rd-ext2.bin of=/dev/mtdblock5 count=4
4+0 records in
4+0 records out
# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00080000 00020000 "X-Loader-NAND"
mtd1: 00080000 00020000 "U-Boot-NAND"
mtd2: 00040000 00020000 "Boot Env-NAND"
mtd3: 00400000 00020000 "Kernel-NAND"
mtd4: 0fac0000 00020000 "File System - NAND"
# dd if=rd-ext2.bin of=/dev/mtdblock4 count=4
4+0 records in
4+0 records out

Best Regards
Abraham
