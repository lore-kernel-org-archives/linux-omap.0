From: "Sam Duan" <sam_duan@ovt.com.cn>
Subject: prcm_34xx.c--compiler error
Date: Tue, 25 Nov 2008 12:22:54 +0800
Message-ID: <003e01c94eb5$7df5fd10$79e1f730$@com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [220.248.103.35] ([220.248.103.35]:55254 "EHLO mail.ovt.com.cn"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbYKYEXM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 23:23:12 -0500
Received: from MICROSOF825AC7 (soc.ovt.com.cn [220.248.103.34])
	(authenticated bits=0)
	by mail.ovt.com.cn (8.13.1/8.13.1) with ESMTP id mAP4KZb2026620
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 12:20:37 +0800
Content-Language: zh-cn
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

I am new here, pardon me if this mail is not suitable and please point out
to me.
When CONFIG_OMAP3_PM was enabled with omapkernel2.6.27 for omapzoom
board(configured with "omap_ldp_pm_defconfig"), I got errors: "initializer
element is not constant" from line 66 to line 467 in prcm_34xx.c. All errors
relates to initialization for dom_reg[].regdef[].reg_addr,
dpll_reg[].regdef[].reg_addr, clksel_reg[].reg_addr..if we missed some
initialization in prcm-regs.h(line 40) for "typedef struct { volatile u32
offset[4096]; } __regbase32;"? I am not clear how the initialization
working.
The kernel can be built OK with "omap_ldp_defconfig" following steps in
"Getting Started with Linux OMAP Kernel".
I googled this error but couldn't find any information useful for this
issue. Did anybody meet the same problem?

Appreciate for your attention.

Sam Duan

