From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: use CONFIG_CPUFREQ_DT
Date: Mon, 15 Dec 2014 09:53:01 +0530
Message-ID: <CAOh2x=mTg8O-cqjkPPL6hSS3Jspk8h8xrdHGCR04iPNMYEK-Gw@mail.gmail.com>
References: <1418404738-19124-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418404738-19124-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Linux PM list <linux-pm@vger.kernel.org>, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 12, 2014 at 10:48 PM, Nishanth Menon <nm@ti.com> wrote:
> CONFIG_GENERIC_CPUFREQ_CPU0 disappeared with commit bbcf071969b20f
> ("cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'")
>
> Use the renamed CONFIG_CPUFREQ_DT generic driver. It looks like with
> v3.18-rc1, commit bbcf071969b20f and fdc509b15eb3eb came in via
> different trees causing the resultant v3.18-rc1 to be non-functional for
> cpufreq as default supported with omap2plus_defconfig.
>
> Fixes: fdc509b15eb3eb ("ARM: omap2plus_defconfig: Add cpufreq to defconfig")
> Signed-off-by: Nishanth Menon <nm@ti.com>

Whomsoever applies it, please add:

Cc: <stable@vger.kernel.org>        # 3.18

> ---
>
> NOTE: as of v3.18 tag, The following still need to be fixed - I do not have all
> the platforms impacted to make a generic change, so CCying folks who might be interested
>
> arch/arm/configs/shmobile_defconfig:CONFIG_GENERIC_CPUFREQ_CPU0=y
> arch/arm/configs/multi_v7_defconfig:CONFIG_GENERIC_CPUFREQ_CPU0=y

I have fixed them now.

>
>  arch/arm/configs/omap2plus_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 3e09286..5fc0dbe 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -68,7 +68,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>  CONFIG_CPU_FREQ_GOV_USERSPACE=y
>  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> -CONFIG_GENERIC_CPUFREQ_CPU0=y
> +CONFIG_CPUFREQ_DT=y
>  # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
>  CONFIG_CPU_IDLE=y
>  CONFIG_BINFMT_MISC=y

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
