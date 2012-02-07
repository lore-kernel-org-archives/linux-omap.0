From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 0/3] ARM: OMAP4: Remove hardcoded reg-offs for
 PWRSTCTRL & PWRSTST
Date: Tue, 7 Feb 2012 10:56:26 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317C25CC@DBDE01.ent.ti.com>
References: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36013 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899Ab2BGK4f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 05:56:35 -0500
In-Reply-To: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 03, 2012 at 17:13:53, Hiremath, Vaibhav wrote:
> This patch series removes the existing hard-coded way of providing
> offset to omap4_prminst_xxx API's and instead use offsets
> provided in powerdomainsxxxx_data.
> Also, hook up AM33XX device support to existing omap4 PRM code.
> 
> Background:
> ==========
> PRM module in AM33XX is closer to OMAP4 PRM module, so it complete
> sense to reuse all the code from existing OMAP4 implementation.
> Having said that, there is a catch here with respect to AM33XX device,
> 
> The register offset in PRM module is not consistent
> across (crazy IP integration), for example,
> 
> PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
> ===============================================
> PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
> PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
> PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
> PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08
> 
> So in order to reuse the existing OMAP4 code, we have to add
> seperate entry for register offsets, especially
> PWRSTCTRL & PWRSTST.
> 
> NOTE: Boot tested on AM335x EVM and AM37xEVM
> 
> Changes from V2:
> 	- As per Kevin's comment, created separate prm_base table
> 	  for am33xx and added __init function for prminst to
> 	  initialize prm_base table during boot time.
> 	- Minor comment from Kevin, to add extra line in patch 1/3
> Changes from V1:
>  	- As per Kevin's comment, patch is split into logical
> 	  commits for ease of review.
>   	- Added specific comment for cpu_is_xxx check order
> 	  change.
> 
> 
> Vaibhav Hiremath (3):
>   ARM: OMAP4: Remove hardcoded reg-offs for PWRSTCTRL & PWRSTST
>   ARM: OMAP4: prminst: Add boot time __init function for prminst
>   ARM: OMAP: am33xx: Hook-up am33xx support to existing prm code
> 

Kevin,

Any comments on this patch-series?

Thanks,
Vaibhav

>  arch/arm/mach-omap2/io.c                    |    3 ++
>  arch/arm/mach-omap2/omap_hwmod.c            |   44 +++++++++++++++++++--------
>  arch/arm/mach-omap2/powerdomain.h           |    4 ++
>  arch/arm/mach-omap2/powerdomain44xx.c       |   24 +++++++-------
>  arch/arm/mach-omap2/powerdomains44xx_data.c |    9 +++++
>  arch/arm/mach-omap2/prcm44xx.h              |    2 +
>  arch/arm/mach-omap2/prminst44xx.c           |   35 ++++++++++++++++-----
>  arch/arm/mach-omap2/prminst44xx.h           |    2 +-
>  8 files changed, 89 insertions(+), 34 deletions(-)
> 
> 

