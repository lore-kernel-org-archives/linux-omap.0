From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clean up and standardize WFI handling
 for 3.9
Date: Sun, 10 Feb 2013 09:08:28 -0800
Message-ID: <20130210170827.GK4801@atomide.com>
References: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39009 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755316Ab3BJRIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 12:08:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302081726480.28008@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130208 09:31]:
> Hi,
> 
> The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:
> 
>   Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.9
> 
> for you to fetch changes up to 814a18a5d026464f56b3616704b985f9942b29a6:
> 
>   ARM: OMAP AM3517/05: hwmod data: block WFI when EMAC active (2013-02-06 13:48:56 -0700)
> 
> ----------------------------------------------------------------
> On OMAP2+ devices, standardize and clean up WFI entry and WFI blocking.
> 
> Basic test logs are available here:
> 
>    http://www.pwsan.com/omap/testlogs/wfi_devel_a_3.9/20130208085027/

Thanks pulled into omap-for-v3.9/pm-wfi. While merging this into
omap-for-v3.9/tmp-merge, got the following merge conlict. Maybe
take a look if it's correct merge?

Regards,

Tony


commit 61e16f1257d2175c01c19250acfd3ad2c2af0d4b
Merge: 195f894 3fae0d6
Author: Tony Lindgren <tony@atomide.com>
Date:   Sat Feb 9 20:25:38 2013 -0800

    Merge branch 'omap-for-v3.9/pm-wfi' into omap-for-v3.9/tmp-merge
    
    Conflicts:
    	arch/arm/mach-omap2/pm24xx.c

diff --cc arch/arm/mach-omap2/pm24xx.c
index b2a4df6,bc44bcd..f3444c4
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@@ -172,16 -174,18 +173,15 @@@ static void omap2_enter_mpu_retention(v
  		omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
  
  		/* Try to enter MPU retention */
 -		omap2_prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
 -				  OMAP_LOGICRETSTATE_MASK,
 -				  MPU_MOD, OMAP2_PM_PWSTCTRL);
 +		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
 +
  	} else {
  		/* Block MPU retention */
 -
 -		omap2_prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
 -						 OMAP2_PM_PWSTCTRL);
 +		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
  	}
  
- 	omap2_sram_idle();
- 
- 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
+ 	/* WFI */
+ 	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (zero) : "memory", "cc");
  }
  
  static int omap2_can_sleep(void)
