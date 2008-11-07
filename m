From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] OMAP_LDP: Add Ethernet device support to make ldp
	boot succeess.
Date: Fri, 7 Nov 2008 17:55:10 +0200
Message-ID: <20081107155450.GI21860@frodo>
References: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com> <1226065287-3066-2-git-send-email-stanley.miao@windriver.com> <1226065287-3066-3-git-send-email-stanley.miao@windriver.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38467 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYKGPzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 10:55:23 -0500
Content-Disposition: inline
In-Reply-To: <1226065287-3066-3-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 07, 2008 at 09:41:26PM +0800, Stanley.Miao wrote:
> Add Ethernet device support in board-ldp.c to make ldp can boot and mount nfs
> successfully.

Normally, defconfig changes come in a separate patch. Please split
defconfig out of this patch and fix these:

WARNING: suspect code indent for conditional statements
#292: FILE: arch/arm/mach-omap2/board-ldp.c:213:
+       if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {

ERROR: code indent should use tabs where possible
#293: FILE: arch/arm/mach-omap2/board-ldp.c:214:
+               printk(KERN_ERR "Failed to request GPMC mem for smc911x\n");$

ERROR: code indent should use tabs where possible
#294: FILE: arch/arm/mach-omap2/board-ldp.c:215:
+               return;$

WARNING: suspect code indent for conditional statements
#305: FILE: arch/arm/mach-omap2/board-ldp.c:226:
+       if (omap_request_gpio(eth_gpio) < 0) {

ERROR: code indent should use tabs where possible
#306: FILE: arch/arm/mach-omap2/board-ldp.c:227:
+               printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",$

ERROR: code indent should use tabs where possible
#307: FILE: arch/arm/mach-omap2/board-ldp.c:228:
+                       eth_gpio);$

ERROR: code indent should use tabs where possible
#308: FILE: arch/arm/mach-omap2/board-ldp.c:229:
+               return;$

ERROR: code indent should use tabs where possible
#319: FILE: arch/arm/mach-omap2/board-ldp.c:240:
+        ldp_init_smc911x();$

-- 
balbi
