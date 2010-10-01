From: Anand Gadiyar <gadiyar@ti.com>
Subject: omap2plus_defconfig fails to compile on linux-next with OMAP2 support
Date: Sat, 2 Oct 2010 02:23:40 +0530
Message-ID: <d535c21381247edbf11365b7cf635577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37199 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756174Ab0JAUxu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:53:50 -0400
Received: by mail-wy0-f169.google.com with SMTP id 36so3840258wyb.28
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 13:53:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Tony,

linux-next as of 20101001 fails to build on omap2plus_defconfig with
multiple
build errors. I've resolved many of those, but this one remains as long
as CONFIG_ARCH_OMAP2 is enabled.

I'm not sure how to fix this, so just reporting it for now.

- Anand


  CC      arch/arm/kernel/swp_emulate.o
/tmp/ccxJtmP3.s: Assembler messages:
/tmp/ccxJtmP3.s:343: Error: selected processor does not support ARM mode
`ldrexb r6,[r5]'
/tmp/ccxJtmP3.s:344: Error: selected processor does not support ARM mode
`strexb r1,r3,[r5]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel] Error 2
