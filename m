From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: OMAP2+: Adjustments for seven function
 implementations
Date: Tue, 6 Jun 2017 23:51:46 -0700
Message-ID: <20170607065146.GE3730@atomide.com>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* SF Markus Elfring <elfring@users.sourceforge.net> [170603 11:24]:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 3 Jun 2017 20:12:34 +0200
> 
> Some update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (9):
>   Delete an error message for a failed memory allocation in omap_mcspi_init()
>   Delete an error message for a failed memory allocation in two functions
>   Delete an unnecessary variable initialisation in omap_init_mcbsp()
>   Improve a size determination in omap_init_mcbsp()
>   Delete an error message for a failed memory allocation in omap_init_mcbsp()
>   Improve a size determination in sr_dev_init()
>   Use kcalloc() in sr_set_nvalues()
>   SmartReflex: Delete an error message for a failed memory allocation in two functions
>   Delete an error message for a failed memory allocation in omap_timer_init()

Thanks for the patches. Many of these are no longer needed as
I've now dropped more of the legacy boot code as everything
for mach-omap2 is booting in device tree mode.

So I'm applying the following ones into omap-for-v4.13/soc.

Regards,

Tony

8< -------
ARM: OMAP2+: SmartReflex: Delete an error message for a failed memory allocation in two functions
ARM: OMAP2+: Use kcalloc() in sr_set_nvalues()
ARM: OMAP2+: Improve a size determination in sr_dev_init()
ARM: OMAP2+: Delete an error message for a failed memory allocation in two functions
