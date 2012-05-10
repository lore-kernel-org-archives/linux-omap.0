From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: Misc cleanup
Date: Thu, 10 May 2012 09:18:26 -0700
Message-ID: <20120510161825.GD21851@atomide.com>
References: <1336461259-28596-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508183414.GZ5088@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1F2D1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30857 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2EJQSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 12:18:31 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA1F2D1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120510 01:37]:
> On Wed, May 09, 2012 at 00:04:14, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [120508 00:18]:
> > > Tony,
> > > 
> > > Please pull the following preparatory cleanup series to add OMAP5 minimal
> > > support. Boot tested on OMAP2430 SDP, OMAP3430 SDP and OMAP4430 SDP platforms.
> > > 
> > > I have dropped {[PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function}
> > > from this set since Paul is taking that one in his queue.
> > 
> > OK thanks, pulling this into cleanup-soc and merging into cleanup branch
> > with what we have in devel-hwmod.
> >  
> Tony,
> 
> 
> Just observed that, while merging cleanup-soc into cleanup branch you have 
> missed couple of lines from Satosh's original patch. Which leads to build 
> break on OMAP2 alone build.

OK thanks for letting me know, will take a look.

Tony
 
> Can you please merge below change,
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 833f153..c82783a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -122,6 +122,8 @@ obj-$(CONFIG_SOC_AM33XX)            += $(powerdomain-common)
>  clockdomain-common                     += clockdomain.o
>  clockdomain-common                     += clockdomains_common_data.o
>  obj-$(CONFIG_ARCH_OMAP2)               += $(clockdomain-common)
> +obj-$(CONFIG_ARCH_OMAP2)               += clockdomain2xxx_3xxx.o
> +obj-$(CONFIG_ARCH_OMAP2)               += clockdomains2xxx_3xxx_data.o
>  obj-$(CONFIG_SOC_OMAP2420)             += clockdomains2420_data.o
>  obj-$(CONFIG_SOC_OMAP2430)             += clockdomains2430_data.o
>  obj-$(CONFIG_ARCH_OMAP3)               += $(clockdomain-common)
> 
> 
> Thanks,
> Vaibhav
