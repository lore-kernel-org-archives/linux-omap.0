From: Paul Walmsley <paul@pwsan.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 23:17:27 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809042312410.25143@utopia.booyaka.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com> <20080904094655.GB10426@flint.arm.linux.org.uk> <20080904161033.GQ23085@atomide.com> <20080904161248.GC2309@flint.arm.linux.org.uk>
 <20080904162917.GR23085@atomide.com> <20080904170733.GD2309@flint.arm.linux.org.uk> <20080904175810.GS23085@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36599 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYIEFR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:17:28 -0400
In-Reply-To: <20080904175810.GS23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org


Hello Russell, Tony,

in arch/arm/plat-omap/include/mach/io.h, shouldn't these casts be 
"__force void __iomem *" ?   

#define IO_ADDRESS(pa)		((void __iomem *)__IO_ADDRESS(pa))
#define OMAP1_IO_ADDRESS(pa)	((void __iomem *)__OMAP1_IO_ADDRESS(pa))
#define OMAP2_IO_ADDRESS(pa)	((void __iomem *)__OMAP2_IO_ADDRESS(pa))

sparse is emitting warnings again - i.e.,

arch/arm/mach-omap2/irq.c:150:21: warning: cast adds address space to 
expression (<asn:2>)


- Paul
