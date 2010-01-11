From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH] AM35xx: Add clock support for new modules on AM35xx
Date: Mon, 11 Jan 2010 23:38:26 +0530
Message-ID: <4B4B691A.30504@ti.com>
References: <1260971823-8532-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.0912171818150.12561@utopia.booyaka.com> <4B2B5A0F.9050304@ti.com> <alpine.DEB.2.00.1001051134240.2083@utopia.booyaka.com> <4B470D28.7010900@ti.com> <alpine.DEB.2.00.1001081558530.28650@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53499 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0AKSId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 13:08:33 -0500
In-Reply-To: <alpine.DEB.2.00.1001081558530.28650@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Sat, 09-Jan-10 4:37 AM +0530, Paul Walmsley wrote:
> Hello Ranjith,
> 
> On Fri, 8 Jan 2010, Ranjith Lohithakshan wrote:
> 
>> These ACK bits are for the target IdleAck status. I will add a custom
>> find_companion code for AM35xx.
> 
> ...
> 
>> OK. I will extend the existing find_idlest to pass back what value needs
>> to be checked as you suggested. I will make this change as a separate patch.
> 
> Both of the above sound good.
> 
>> All the VBUSP (interface) clocks are derived from core_l3_clk and I am
>> making them as part of core_l3_clk domain. The rmii_ck/emac_fck and
>> vpfe_fck are sourced from external clock sources. (AM35XX TRM section
>> 4.7.7.12)
> 
> ...
> 
>> rmii_ck and vpfe_fck are from off-chip sources. These are fixed rate
>> clocks being fed to the chip. Do we need to associate a dummy or virtual
>> clock domain for these clocks or is it OK if we treat it similar to the
>> way we currently treat 32K timer clock (RATE_FIXED, clockops_null, no
>> clock domain and having no parent)?
> 
> I guess it will be fine to add these with no clockdomain until we add an 
> external clockdomain.  One last question - do you know if these external 
> clocks require the CORE powerdomain to be powered for them to be routed?  
> I believe this is the case for some of the external clocks that are routed 
> through the CM on OMAP3.

These external clocks are routed directly from IO to the respective
modules. They are not controlled by CM.

 - Ranjith
