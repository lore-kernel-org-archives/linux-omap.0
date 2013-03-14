From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
Date: Thu, 14 Mar 2013 11:29:33 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC281C1@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58402 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757118Ab3CNL3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 07:29:47 -0400
In-Reply-To: <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "khilman@linaro.org" <khilman@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, March 04, 2013 5:06 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; khilman@linaro.org; paul@pwsan.com; Nayak,
> Rajendra; linux-arm-kernel@lists.infradead.org; Hiremath, Vaibhav
> Subject: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for
> debugSS module control
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Currently there is no clean mechanism to control debugSS module and
> you have to always keep clocks enabled, either,
> 
>     - By enabling it during boot as part of clk_init function
>       (post common-clock migration).
>     Or
>     - By having HWMOD_INIT_NO_IDLE flag in hwmod data
>       (Joel submitted patch for AM335x earlier).
> 
> Based on the discussion with Kevin H,
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg81771.html
> 
> This patch introduces new kernel parameter "omap_debugss_en",
> which will allow user to control debugSS module enable/disable
> part during boot-time.
> 
> In case of OMAP3, the debugSS is part of EMU domain and
> is currently controlled by clock tree alone.
> 
> In case of OMAP4, the debugSS is part of EMU domain and
> is currently controlled by clock tree, as MODULEMODE_SWCTRL
> is not defined for hwmod.
> 
> In case of AM335x, the debugSS is in wakeup domain and is currently
> controlled through hwmod alone. Currently we keep it always enabled.
> 
> Testing:
> 	- Tested on AM335x based EVM and BeagleBone platform
> 
> 	  As required, without this flag the debugSS module will be
> disabled
> 	  during kernel boot.
> 
> OMAP (2/3/4) may require some changes from clock/hwmod perspective
> in order to use this new parameter.
> I am still looking into OMAP spec and this RFC version of patch-series
> is to get comments or opinion from list.
> 
> Vaibhav Hiremath (3):
>   ARM: AM33XX: clock: Add debugSS clock nodes to clock tree
>   ARM: AM33XX: hwmod: Add hwmod data for debugSS
>   ARM: OMAP2+: Add command line parameter for debugSS module control
> 
>  Documentation/kernel-parameters.txt        |    3 +
>  arch/arm/mach-omap2/Makefile               |    2 +-
>  arch/arm/mach-omap2/cclock33xx_data.c      |   47 +++++++++++++++--
>  arch/arm/mach-omap2/debugss.c              |   80
> ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   69 ++++++++++++++++----
> ----
>  5 files changed, 173 insertions(+), 28 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/debugss.c

Kevin/Tony,

Any comments or input on this patch series?

Thanks,
Vaibhav



