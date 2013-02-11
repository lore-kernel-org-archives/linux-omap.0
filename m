From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clean up and standardize WFI handling
 for 3.9
Date: Mon, 11 Feb 2013 09:37:32 -0800
Message-ID: <20130211173731.GO4801@atomide.com>
References: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com>
 <20130210170827.GK4801@atomide.com>
 <alpine.DEB.2.00.1302101726020.2672@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27724 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758256Ab3BKRhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 12:37:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302101726020.2672@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130210 09:31]:
> Hi Tony
> 
> On Sun, 10 Feb 2013, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [130208 09:31]:
> > > 
> > > ----------------------------------------------------------------
> > > On OMAP2+ devices, standardize and clean up WFI entry and WFI blocking.
> > > 
> > > Basic test logs are available here:
> > > 
> > >    http://www.pwsan.com/omap/testlogs/wfi_devel_a_3.9/20130208085027/
> > 
> > Thanks pulled into omap-for-v3.9/pm-wfi. While merging this into
> > omap-for-v3.9/tmp-merge, got the following merge conlict. Maybe
> > take a look if it's correct merge?
> 
> ...
> 
> >   	}
> >   
> > - 	omap2_sram_idle();
> > - 
> > - 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
> > + 	/* WFI */
> > + 	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
> >   }
> 
> The inline asm is intended to replace the omap2_sram_idle() call.  I'd 
> suggest:
> 
>         }
> 
>         /* WFI */
>         asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
> 
>         pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
>  }
> 
> as the end product.

OK thanks.

This branch should probably have been based on your earlier PM branch
based on v3.8-rc5 that was already merged as omap-for-v3.9/pm-signed into
arm-soc for-next.

Now merging this branch based on v3.8-rc6 requires me to create a merge
base by merging the earlier branch with v3.8-rc6 and then resolving
the self-inflicted merge conflict in order for me to generate a pull request
without a non-trivial merge conflict. Just a bunch of extra hassle to
deal with with additional risk of merging things wrong. Anyways merging
into omap-for-v3.9/pm-wfi-take2.

Regards,

Tony
