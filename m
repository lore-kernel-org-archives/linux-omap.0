From: Anand Gadiyar <gadiyar@ti.com>
Subject: linux-next: omap2plus_defconfig does not build
Date: Wed, 13 Oct 2010 18:53:08 +0530
Message-ID: <a36d6a1047d959af6ea65cd7edacf6a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60695 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193Ab0JMNXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Oct 2010 09:23:16 -0400
Received: by mail-ww0-f46.google.com with SMTP id 17so833782wwb.3
        for <linux-omap@vger.kernel.org>; Wed, 13 Oct 2010 06:23:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Building omap2plus_defconfig (which enables support for
OMAP2420/2430/OMAP3
and OMAP4 in one image), I get the following build error.

  CC      arch/arm/kernel/swp_emulate.o
/tmp/ccg979qz.s: Assembler messages:
/tmp/ccg979qz.s:343: Error: selected processor does not support ARM mode
`ldrexb r6,[r5]'
/tmp/ccg979qz.s:344: Error: selected processor does not support ARM mode
`strexb r1,r3,[r5]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel] Error 2

I'm using CodeSourcery's 2010q1-202 toolchain based on gcc 4.4.1.

I haven't been following the lists closely the last few days, so I'm not
sure if this is a known issue. Just reporting it for now.

- Anand
