From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
Date: Fri, 2 Mar 2012 13:44:17 -0800
Message-ID: <20120302214416.GQ18901@atomide.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
 <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
 <20120302192058.GP18901@atomide.com>
 <4F512D72.1090002@ti.com>
 <4F513DCA.1070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56167 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518Ab2CBVoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 16:44:22 -0500
Content-Disposition: inline
In-Reply-To: <4F513DCA.1070301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, sameo@linux.intel.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [120302 13:06]:
> 
> I created a for_3.4/twl_irq_gpio_fix branch based on irqdomain/next
> with all the TWL + GPIO patches except the DTS and without the MMC
> hacks.
> 
> And I merged it into your hsmmc-gpio branch. There is a small
> conflict in gpio-twl4030 but otherwise it works on the SDP4430.

OK cool.
 
> I cannot test remotely with Panda or Beagle, the animals are already
> sleeping.
> 
> The branch is there if you want to check for OMAP3 as well.
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> for_3.4/twl_irq_gpio_fix

I'll give it a try at some point, looks like there's few more
hsmmc fixes needed first..

Tony
