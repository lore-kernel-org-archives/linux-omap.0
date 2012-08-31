From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Without MACH_ option Early printk (DEBUG_LL)
Date: Fri, 31 Aug 2012 20:24:51 +0530
Message-ID: <5040D03B.2050304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34317 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab2HaOzJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 10:55:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Russell & Tony,

AM335X EVM (based on AM33XX device) only supports DT boot mode and
doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
baseport submission we had aligned that, we won't create separate EVM
options, killing the board file all-together.

Having said that, the early printk option (DEBUG_LL) is broken, the
auto-generated file "./include/generated/mach-types.h" still refers to
CONFIG_MACH_AM335XEVM option,

#ifdef CONFIG_MACH_AM335XEVM
# ifdef machine_arch_type
#  undef machine_arch_type
#  define machine_arch_type     __machine_arch_type
# else
#  define machine_arch_type     MACH_TYPE_AM335XEVM
# endif
# define machine_is_am335xevm() (machine_arch_type == MACH_TYPE_AM335XEVM)
#else
# define machine_is_am335xevm() (0)
#endif


So I am thinking of changing the config_xxx option to SOC_AM33XX or
ARCH_OMAP2PLUS, something like below,

am335xevm        SOC_AM33XX          AM335XEVM         3589

OR

am335xevm        ARCH_OMAP2PLUS      AM335XEVM         3589


Can you comment on this? Based on that I will submit the patch.

Thanks,
Vaibhav
