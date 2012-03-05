From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] arm: anticipate build breakages due in pending
 merge
Date: Mon, 5 Mar 2012 14:45:35 -0800
Message-ID: <20120305224534.GG12083@atomide.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
 <1330987310-8108-2-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1330987310-8108-2-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-next-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Gortmaker <paul.gortmaker@windriver.com> [120305 14:10]:
> Testing in linux-next has revealed that the omap2plus_defconfig
> will fail upon the merge of "arm-soc/for-next" as follows:
> 
> arch/arm/mach-omap2/control.c:238: error: 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
> arch/arm/mach-omap2/common.c:48: error: 'OMAP2420_SDRC_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/common.c:49: error: 'OMAP2420_SMS_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/common.c:50: error: 'OMAP242X_CTRL_BASE' undeclared here (not in a function)
>  [...]
> arch/arm/mach-omap2/common.c:167: error: 'OMAP4430_CM2_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/sdrc2xxx.c:108: error: 'OMAP2420_PRM_BASE' undeclared (first use in this function)
> arch/arm/mach-omap2/cm2xxx_3xxx.c:310: error: 'OMAP3430_CM_BASE' undeclared (first use in this function)
> 
> It appears that a once implicit path to <plat/hardware.h> has gone
> away once two of the arm streams come together.

Thanks this one is already waiting to be applied to arm-soc
tree.

Regards,

Tony
