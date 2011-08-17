From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: powerdomains: Make all powerdomain target states
 as ON at init
Date: Tue, 16 Aug 2011 19:56:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108161952000.9948@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com> <20110715080315.GC2611@legolas.emea.dhcp.ti.com> <alpine.DEB.2.00.1107150204510.16606@utopia.booyaka.com> <20110715081725.GE2611@legolas.emea.dhcp.ti.com> <alpine.DEB.2.00.1107150222400.16606@utopia.booyaka.com>
 <20110715083753.GG2611@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42591 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1HQB4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 21:56:47 -0400
In-Reply-To: <20110715083753.GG2611@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Hi,

On Fri, 15 Jul 2011, Felipe Balbi wrote:

> How about something like:
> 
> /*
>  * Program target state of all power domains to ON. This is to prevent
>  * power domains from hitting low power states during boot up and
>  * potentially causing accesses to the address space of an IP while it
>  * is disabled.
>  *
>  * PM late init code will make sure of disabling all unused IPs later.
>  */
> 
> not sure if it's a lot better though.

It's not directly related to accesses to the IP block's address space.  
The problem happens when the driver (or the hwmod code) for a particular 
device causes the last clock in a clockdomain to be disabled.  This allows 
the clockdomain to go INACTIVE.

At that point, if all of the clockdomains in the powerdomain are INACTIVE, 
the powerdomain itself will switch to its "next power state". If the 
bootloader had programmed the next power state to be OFF, for example, 
then all devices in that powerdomain will lose context. 

If this happens before the PM code initializes, or if the PM code is not 
compiled in, then this will cause some strange behavior or crashes, since 
the kernel won't be expecting devices to lose their context at that point.


- Paul
