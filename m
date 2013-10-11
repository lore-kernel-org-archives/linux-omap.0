From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 6/6] mtd: nand: omap: updated devm_xx for all
 resource allocation and free calls
Date: Fri, 11 Oct 2013 11:28:40 -0700
Message-ID: <20131011182840.GW29913@atomide.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-7-git-send-email-pekon@ti.com>
 <20131011181515.GJ23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15488 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753438Ab3JKS3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 14:29:11 -0400
Content-Disposition: inline
In-Reply-To: <20131011181515.GJ23337@ld-irv-0074.broadcom.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Pekon Gupta <pekon@ti.com>, mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Brian Norris <computersforpeace@gmail.com> [131011 11:23]:
> Hi Pekon,
> 
> On Fri, Oct 11, 2013 at 07:06:43PM +0530, Pekon Gupta wrote:
> > "Managed Device Resource" or devm_xx calls takes care of automatic freeing
> > of the resource in case of:
> > - failure during driver probe
> > - failure during resource allocation
> > - detaching or unloading of driver module (rmmod)
> > Reference: Documentation/driver-model/devres.txt
> > 
> > Though OMAP NAND driver handles freeing of resource allocation in most of
> > the cases, but using devm_xx provides more clean and effortless approach
> > to handle all such cases.
> 
> Judging by your patch, I think you missed the point of the devm_*
> managed functions. They are useful because you don't need to do any of
> the cleanup (kfree(), iounmap(), etc.) yourself. I'll note the changes
> that are necessary below, but seeing as this is an add-on to your patch
> series, I may merge the rest of series without this, and if so, you can
> just resubmit this patch separately.

FYI, the .dts changes should be queued separately by Benoit to avoid
pointless merge conflicts. The arch/arm/mach-omap2/gpmc.c changes I
need to look, hopefully I can ack those for you today so you can take
the code related changes into the MTD tree.

Regards,

Tony
