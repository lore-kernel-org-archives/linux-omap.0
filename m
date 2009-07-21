From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: Reading from ISP registers fails
Date: Tue, 21 Jul 2009 13:14:57 +0300
Message-ID: <4A659521.6000606@nokia.com>
References: <a187869d0907210137x4995178au73c34182e6c3d47e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57256 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbZGUKPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 06:15:30 -0400
In-Reply-To: <a187869d0907210137x4995178au73c34182e6c3d47e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext matthias schwarz <matthias.schw@googlemail.com>
Cc: linux-omap@vger.kernel.org

ext matthias schwarz wrote:
> Hello there,
> 
> i just wrote a little kernel-module, which only executes the following
> lines of code:
> 
> u32 syn_mode;
> void* iomem;
> struct resource* resource_ptr;
> 
> resource_ptr = request_mem_region(0x480BC000, 0xFFF, "isp_ccdc");
> 
> iomem = ioremap(OMAP3ISP_REG(ISP_SYSCONFIG), 8);
> if(iomem == NULL) {
> 	printk("ioremap returned zero\n");
> 	return 0;
> }
> syn_mode = ioread32(iomem);
> 
> 
> 
> The resulting behaviour does not depend on which ISP register i am
> trying to read, it also happens for "OMAP3ISP_CCDC_REG_BASE +
> ISPCCDC_SYN_MODE" for example. And also when using
> "omap_readl(address)" to read those registers.
> 
> So when this code is executed i get:
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xd80bc004
> Internal error: : 1028 [#1] PREEMPT
> Internal error: : 1028 [#1] PREEMPT
> Modules linked in:Modules linked in: camera(+) camera(+) ipv6 ipv6
> 
> CPU: 0    Not tainted  (2.6.28-omap1 #15)
> [...]
> 
> 
> Hope someone can help me with what might be wrong.
> Thank you,
> Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

You need to enable interface clocks before accessing any peripheral registers.

regards,
-roger
