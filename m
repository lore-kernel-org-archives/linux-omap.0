From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clean up and standardize WFI handling
 for 3.9
Date: Sun, 10 Feb 2013 17:28:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302101726020.2672@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com> <20130210170827.GK4801@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57760 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab3BJR2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 12:28:12 -0500
In-Reply-To: <20130210170827.GK4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

On Sun, 10 Feb 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130208 09:31]:
> > 
> > ----------------------------------------------------------------
> > On OMAP2+ devices, standardize and clean up WFI entry and WFI blocking.
> > 
> > Basic test logs are available here:
> > 
> >    http://www.pwsan.com/omap/testlogs/wfi_devel_a_3.9/20130208085027/
> 
> Thanks pulled into omap-for-v3.9/pm-wfi. While merging this into
> omap-for-v3.9/tmp-merge, got the following merge conlict. Maybe
> take a look if it's correct merge?

...

>   	}
>   
> - 	omap2_sram_idle();
> - 
> - 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
> + 	/* WFI */
> + 	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
>   }

The inline asm is intended to replace the omap2_sram_idle() call.  I'd 
suggest:

        }

        /* WFI */
        asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");

        pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 }

as the end product.


- Paul
