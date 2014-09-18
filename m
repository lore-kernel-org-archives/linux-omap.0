From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/12] ARM: omap2plus_defconfig: Add cpufreq to defconfig
Date: Thu, 18 Sep 2014 11:11:31 -0500
Message-ID: <20140918161131.GA32319@kahuna>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
 <1410837126-31553-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbaIRQLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 12:11:55 -0400
Content-Disposition: inline
In-Reply-To: <1410837126-31553-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 20:12-20140915, Tony Lindgren wrote:
> Note that we can now use the CONFIG_GENERIC_CPUFREQ_CPU0,
> so let's only enable that.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index fc63855..9d232a5 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -43,6 +43,13 @@ CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
>  CONFIG_KEXEC=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_GENERIC_CPUFREQ_CPU0=y
> +# CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set

With this
we get performace as the default governor.

could we use CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND as the default
instead? on Many TI SoCs using Highest frequency is not really too nice
of an idea for long periods of time. And not everything is upstream to
support things optimially - example avs class 0, 1.5 ABB consolidation
with cpufreq etc.. We definitely need thermal enabled as well for device
safety needs.

I propose the following instead:
@@ -43,6 +43,14 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
+# CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
 CONFIG_CPU_IDLE=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM_DEBUG=y
@@ -162,7 +170,9 @@ CONFIG_SENSORS_LM75=m
 CONFIG_THERMAL=y
 CONFIG_THERMAL_GOV_FAIR_SHARE=y
 CONFIG_THERMAL_GOV_USER_SPACE=y
+CONFIG_CPU_THERMAL=y
 CONFIG_TI_SOC_THERMAL=y
+CONFIG_TI_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
 CONFIG_DRA752_THERMAL=y

-- 
Regards,
Nishanth Menon
