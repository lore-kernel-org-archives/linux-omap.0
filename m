From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Build broken on linus/master?
Date: Fri, 26 Oct 2012 07:48:17 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBE9565@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39576 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756882Ab2JZHsX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 03:48:23 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>

Hi,

Compiling the current linus/master (2ab3f29) using omap2plus_defconfig
throws up the following error

$make -j7 uImage
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/dma-mapping.h:76:0,
                 from arch/arm/kernel/asm-offsets.c:15:
/datalocal/kernel/arch/arm/include/asm/dma-mapping.h: In function 'dma_mapping_error':
/datalocal/kernel/arch/arm/include/asm/dma-mapping.h:94:2: error: implicit declaration of function 'debug_dma_mapping_error'
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

Regards,
Vaibhav B.


