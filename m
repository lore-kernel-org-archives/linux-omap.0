From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Without MACH_ option Early printk (DEBUG_LL)
Date: Fri, 31 Aug 2012 18:13:36 +0100
Message-ID: <20120831171336.GA6978@n2100.arm.linux.org.uk>
References: <5040D03B.2050304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48701 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab2HaRNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 13:13:55 -0400
Content-Disposition: inline
In-Reply-To: <5040D03B.2050304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 31, 2012 at 08:24:51PM +0530, Vaibhav Hiremath wrote:
> Hi Russell & Tony,
> 
> AM335X EVM (based on AM33XX device) only supports DT boot mode and
> doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
> baseport submission we had aligned that, we won't create separate EVM
> options, killing the board file all-together.
> 
> Having said that, the early printk option (DEBUG_LL) is broken, the
> auto-generated file "./include/generated/mach-types.h" still refers to
> CONFIG_MACH_AM335XEVM option,
> 
> #ifdef CONFIG_MACH_AM335XEVM
> # ifdef machine_arch_type
> #  undef machine_arch_type
> #  define machine_arch_type     __machine_arch_type
> # else
> #  define machine_arch_type     MACH_TYPE_AM335XEVM
> # endif
> # define machine_is_am335xevm() (machine_arch_type == MACH_TYPE_AM335XEVM)
> #else
> # define machine_is_am335xevm() (0)
> #endif

machine types are entirely meaningless for DT based systems.

> Can you comment on this? Based on that I will submit the patch.

Pointless.  You can't use machine_is_am335xevm() when you're using DT.
