From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Without MACH_ option Early printk (DEBUG_LL)
Date: Fri, 31 Aug 2012 17:23:12 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA9EC8B@DBDE01.ent.ti.com>
References: <5040D03B.2050304@ti.com>
 <20120831171336.GA6978@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41601 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab2HaRX0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 13:23:26 -0400
In-Reply-To: <20120831171336.GA6978@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 31, 2012 at 22:43:36, Russell King - ARM Linux wrote:
> On Fri, Aug 31, 2012 at 08:24:51PM +0530, Vaibhav Hiremath wrote:
> > Hi Russell & Tony,
> > 
> > AM335X EVM (based on AM33XX device) only supports DT boot mode and
> > doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
> > baseport submission we had aligned that, we won't create separate EVM
> > options, killing the board file all-together.
> > 
> > Having said that, the early printk option (DEBUG_LL) is broken, the
> > auto-generated file "./include/generated/mach-types.h" still refers to
> > CONFIG_MACH_AM335XEVM option,
> > 
> > #ifdef CONFIG_MACH_AM335XEVM
> > # ifdef machine_arch_type
> > #  undef machine_arch_type
> > #  define machine_arch_type     __machine_arch_type
> > # else
> > #  define machine_arch_type     MACH_TYPE_AM335XEVM
> > # endif
> > # define machine_is_am335xevm() (machine_arch_type == MACH_TYPE_AM335XEVM)
> > #else
> > # define machine_is_am335xevm() (0)
> > #endif
> 
> machine types are entirely meaningless for DT based systems.
> 
> > Can you comment on this? Based on that I will submit the patch.
> 
> Pointless.  You can't use machine_is_am335xevm() when you're using DT.
> 

They how do you recommend to resolve early prink issue (required during 
decompression)?

Thanks,
Vaibhav

