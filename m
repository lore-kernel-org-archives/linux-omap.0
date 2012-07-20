From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
Date: Fri, 20 Jul 2012 14:41:27 -0700
Message-ID: <20120720214127.GB22263@animalcreek.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
 <1336770778-23044-3-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com>
 <20120718213246.GD27904@animalcreek.com>
 <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
 <20120719182602.GB24076@animalcreek.com>
 <alpine.DEB.2.00.1207191649040.14390@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:39602 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab2GTVl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 17:41:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207191649040.14390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ilya Yanok <yanok@emcraft.com>

On Thu, Jul 19, 2012 at 04:59:06PM -0600, Paul Walmsley wrote:
> + Ilya
> 
> Hi Mark
> 
> Maybe try something like this on top of the patch that disables the 
> MPU DPLL autoidle?
> 
> I don't know what am35xx_enable_emac_int() is supposed to do.  It seems 
> strange to clear the interrupt status bits when one is supposed to enable 
> the interrupts.  Maybe Ilya can shed some light on it.

Just an FYI for anyone following this thread.  Paul has contacted me
privately and said to not bother testing this patch.

Mark
