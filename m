From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: mainline - build breaks with omap3_defconfig
Date: Thu, 4 Mar 2010 19:36:38 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCE50@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42976 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845Ab0CDOGq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 09:06:46 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

Felipe already reported one issue with the board-omap3touchbook.c
causing a build break. After working around that, there's another
build break when compiling the 4430SDP board file.

  CC      arch/arm/mach-omap2/board-4430sdp.o
/tmp/cc7lJWsG.s: Assembler messages:
/tmp/cc7lJWsG.s:45: Error: selected processor does not support `dsb'
/tmp/cc7lJWsG.s:46: Error: selected processor does not support `smc'
make[1]: *** [arch/arm/mach-omap2/board-4430sdp.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2


Only reporting this for now - will take a look later.
If someone already has the patch to fix this, let me know so I
won't duplicate effort.

- Anand
