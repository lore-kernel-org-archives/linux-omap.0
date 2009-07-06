From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: User/kernel memory split
Date: Mon, 6 Jul 2009 16:59:43 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D84C015D@dbde02.ent.ti.com>
References: <017301c9fe1f$91b92100$LocalHost@wipultra793>
 <B85A65D85D7EB246BE421B3FB0FBB59301D84C009A@dbde02.ent.ti.com>
 <01c701c9fe24$2339d440$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbZGFL3w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 07:29:52 -0400
In-Reply-To: <01c701c9fe24$2339d440$LocalHost@wipultra793>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hemanth,
                    I might be missing something but please see below:
>
>
>Hemanth,
>                   Why do you want the split? Do you have physical mem > 1G
>in your system?
>
>We want to fit 512MB RAM on 2.6.27 Kernel which doesnot have highmem option.
>We also donot want to disturb the current I/O memory map

[Romit] As long as your physical memory is slightly less than 1GB, I do not think highmem is necessary.
For I/O map: Kernel virtual addresses start from 0xC0000000. Adding 512M to it gives 0xE0000000. So the virtual memory for IO space needs to be after this.

Currently the IO Map is 
#define L4_WK_34XX_PHYS         L4_WK_34XX_BASE /* 0x48300000 */
#define L4_WK_34XX_VIRT         0xd8300000
#define L4_WK_34XX_SIZE         SZ_1M

#define L4_PER_34XX_VIRT        0xd9000000
#define L4_PER_34XX_SIZE        SZ_1M
#define L4_EMU_34XX_VIRT        0xe4000000
#define L4_EMU_34XX_SIZE        SZ_64M

#define OMAP34XX_GPMC_PHYS      OMAP34XX_GPMC_BASE /* 0x6E000000 */
#define OMAP34XX_GPMC_VIRT      0xFE000000
#define OMAP34XX_GPMC_SIZE      SZ_1M

#define OMAP343X_SMS_VIRT       0xFC000000
#define OMAP343X_SMS_SIZE       SZ_1M

#define OMAP343X_SDRC_PHYS      OMAP343X_SDRC_BASE /* 0x6D000000 */
#define OMAP343X_SDRC_VIRT      0xFD000000
#define OMAP343X_SDRC_SIZE      SZ_1M

This is a problem as the existing virtual memory maps for I/O space would overlap with 512M SDRAM. So, we need to redefine the virtual mapping after 0xe0000000. The IO_OFFSET is 0x90000000 currently. 

For L4_WK_34XX_VIRT we need a minimum of 0xe0000000 - 0x48300000 i.e. 0x97D00000 as the new IO_OFFSET.  But using this new IO_OFFSET for mapping OMAP343x_GPMC_VIRT would result in an overflow(0x6E000000 + 0x97D00000 = 0x105D00000).

Using ioremap for these regions might help. But this needs changes to most drivers. In that case these static mappings could go away and I think they should. Some ARM kernel expert may comment!

-Romit


