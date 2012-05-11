From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
Date: Fri, 11 May 2012 04:36:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205110400510.3201@utopia.booyaka.com>
References: <20120510172449.13418.66815.stgit@dusk> <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com> <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com> <4FACDC63.7060605@ti.com> <alpine.DEB.2.00.1205110333240.3201@utopia.booyaka.com>
 <4FACDEDB.7030903@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44790 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab2EKKgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 06:36:31 -0400
In-Reply-To: <4FACDEDB.7030903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>

On Fri, 11 May 2012, Cousson, Benoit wrote:

> But they are not separately gated for OMAP4 either. This is the modulemode
> trick that make us think that, but it just means that the PRCM should ensure
> that this clock is needed when at least one UART modulemode is enabled. In
> fact the SPI modules are using the same clock.
> 
> The modulemode is used to do some reference counting, but the gating is done
> globally. It was the same with the FCK_EN and ICK_EN in OMAP2&3.
> 
> The PRCM spec show only one global gating between FUNC_48M_FCLK and
> PER_48M_GFCLK. All the modules are sharing the exact same clock.

Well, on OMAP3 and AM3517, they do not all share the same clock.  If you 
look at the 34xx TRM vZU Table 17-11 "UART Clocks", you can see that the 
UART1 and 2 functional clocks are sourced from clocks managed by the CORE 
clockdomain, while UART3 is sourced from clocks managed by the PER 
clockdomain.  This is also expressed in our OMAP3 clock tree.

I realize this is slightly tangential to your point.  As to where the 
clock gating nodes are actually located on a given piece of silicon, 
unfortunately I have no way of confirming that, aside from power 
measurement.  You might be correct about what's going on with the AM3517 
but it would be nice to get some confirmation from the AM35xx PRCM 
engineer(s).  At this point one of two possibilities seem likely: either 
CM_FCLKEN1_CORE.EN_UART4 does nothing, or CM_FCLKEN1_CORE.EN_UART4 is 
necessary but not sufficient to get the UART4 to work.  If 
CM_FCLKEN1_CORE.EN_UART4 does not actually do anything then we need to 
remove it from the kernel and ideally file a documentation bug to get it 
removed from the TRM.  On the other hand, if we do have to enable 
CM_FCLKEN1_CORE.EN_UART4 to deassert the IdleAck to UART4, but the PRCM 
usecounting is broken, then I guess we'll need to add a workaround to the 
hwmod code to essentially support multiple "main clocks".


- Paul
