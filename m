From: matthias schwarz <matthias.schw@googlemail.com>
Subject: Reading from ISP registers fails
Date: Tue, 21 Jul 2009 10:37:18 +0200
Message-ID: <a187869d0907210137x4995178au73c34182e6c3d47e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39915 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbZGUIhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 04:37:19 -0400
Received: by fxm18 with SMTP id 18so2447006fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 01:37:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello there,

i just wrote a little kernel-module, which only executes the following
lines of code:

u32 syn_mode;
void* iomem;
struct resource* resource_ptr;

resource_ptr = request_mem_region(0x480BC000, 0xFFF, "isp_ccdc");

iomem = ioremap(OMAP3ISP_REG(ISP_SYSCONFIG), 8);
if(iomem == NULL) {
	printk("ioremap returned zero\n");
	return 0;
}
syn_mode = ioread32(iomem);



The resulting behaviour does not depend on which ISP register i am
trying to read, it also happens for "OMAP3ISP_CCDC_REG_BASE +
ISPCCDC_SYN_MODE" for example. And also when using
"omap_readl(address)" to read those registers.

So when this code is executed i get:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xd80bc004
Internal error: : 1028 [#1] PREEMPT
Internal error: : 1028 [#1] PREEMPT
Modules linked in:Modules linked in: camera(+) camera(+) ipv6 ipv6

CPU: 0    Not tainted  (2.6.28-omap1 #15)
[...]


Hope someone can help me with what might be wrong.
Thank you,
Matthias
