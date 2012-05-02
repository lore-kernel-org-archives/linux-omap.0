From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Wed, 2 May 2012 03:09:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205020255150.19695@utopia.booyaka.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com> <20120418231837.GT21106@atomide.com> <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com> <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com> <20120426190524.GZ3739@atomide.com> <79CD15C6BA57404B839C016229A409A83EA008E5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57759 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500Ab2EBJJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 05:09:12 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA008E5@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:

> I will be waiting for your comment and conformation on, which family AM33xx 
> device should fall in? Please refer to the mail-chain -
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67275.html

This decision turns out to be pretty important; it certainly affects the 
AM33xx PRM/CM/clockdomain/powerdomain patches that I've been looking at.

Here is my suggestion, based on our previous practice.  I am not so 
sure that it is the best way, but it seems pretty reasonable"

Using CONFIG_ARCH_OMAP3 for CONFIG_ARCH_OMAPAM33XX doesn't make sense, as 
far as I can tell.  The main area of similarity between the other 
CONFIG_ARCH_OMAP3 and AM33xx is the Cortex-A8.  And even that MPU 
subsystem is quite different between, say, the 3430/3630 and the AM33xx.  
Most of the AM33xx is quite different from the 3430/3630: OMAP4-style PRCM 
interface, OMAP4-style interconnect, etc.  Plus, most of the 
CONFIG_ARCH_OMAP3 code in our codebase is very 3430/3630-specific, like 
the PM code.

This would seem to suggest that we should use CONFIG_ARCH_OMAP4.  But that 
option currently assumes an OMAP4-style MPU subsystem: SMP Cortex-A9, 
PL310, etc.  None of that is true for AM335x.

So first we have to decide whether the CONFIG_ARCH_OMAP* options should 
have a strong dependency on the MPU type, as they currently do; or whether 
they should focus on the way the SoC is integrated.

If we take the former option, then we should add a new 
CONFIG_ARCH_OMAPAM33XX Kconfig option to arch/arm/Makefile, at the same 
level as CONFIG_ARCH_OMAP1/2/3/4.  Similarly, we should add a 
CONFIG_ARCH_OMAPTI81XX Kconfig option.

However, if we take the second option, then we can probably shoehorn the 
AM33XX and the TI81xx chips into CONFIG_ARCH_OMAP4.

Either way, it would be good to get AM33xx and TI81xx out of 
CONFIG_ARCH_OMAP3, since keeping them there will require lots of 
changes across the codebase to stop using CONFIG_ARCH_OMAP3 and use the 
CONFIG_SOC_* Kconfig options instead.


- Paul
