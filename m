From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Store reboot mode to SAR scratchpad
 memory before restart
Date: Tue, 29 Mar 2016 18:50:43 -0500
Message-ID: <56FB14D3.5090207@ti.com>
References: <1459279517-17479-1-git-send-email-contact@paulk.fr>
 <1459279517-17479-2-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279517-17479-2-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Mahaveer, Vishal" <vishalm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 03/29/2016 02:25 PM, Paul Kocialkowski wrote:
> This adds support for storing the reboot mode command to SAR scratchpad memory,
> at a location compatible with TI kernels, so that bootloaders can grab the
> reboot mode and act upon it.
> 
> Currently, upstream U-Boot has support for this feature on OMAP4.

Since this impacts more SoCs than OMAP4, + Vishal.

> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/mach-omap2/common.h           |  1 +
>  arch/arm/mach-omap2/omap4-common.c     | 12 ++++++++++++
>  arch/arm/mach-omap2/omap4-restart.c    |  2 +-
>  arch/arm/mach-omap2/omap4-sar-layout.h |  3 +++
>  4 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index f7666b9..d773385 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -258,6 +258,7 @@ extern bool gic_dist_disabled(void);
>  extern void gic_timer_retrigger(void);
>  extern void omap_smc1(u32 fn, u32 arg);
>  extern void __iomem *omap4_get_sar_ram_base(void);
> +extern void omap4_sar_ram_write_boot_mode(const char *cmd);
>  extern void omap_do_wfi(void);
>  
>  #ifdef CONFIG_SMP
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 949696b..85f251e 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -265,6 +265,18 @@ void __iomem *omap4_get_sar_ram_base(void)
>  	return sar_ram_base;
>  }
>  
> +void omap4_sar_ram_write_boot_mode(const char *cmd)
> +{
> +	void __iomem *sar_base;
> +
> +	sar_base = omap4_get_sar_ram_base();
> +
> +	if (!cmd)
> +		strncpy(sar_base + BOOT_MODE_OFFSET, "", BOOT_MODE_SIZE);
> +	else
> +		strncpy(sar_base + BOOT_MODE_OFFSET, cmd, BOOT_MODE_SIZE);
> +}

> +
>  /*
>   * SAR RAM used to save and restore the HW
>   * context in low power modes
> diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
> index e17136a..74f29b5 100644
> --- a/arch/arm/mach-omap2/omap4-restart.c
> +++ b/arch/arm/mach-omap2/omap4-restart.c
> @@ -22,6 +22,6 @@
>   */
>  void omap44xx_restart(enum reboot_mode mode, const char *cmd)
>  {
> -	/* XXX Should save 'cmd' into scratchpad for use after reboot */
> +	omap4_sar_ram_write_boot_mode(cmd);

I think you might have noticed that the function gets reused for more
SoCs than just OMAP4. Did you consider the impact on other SoCs?


A) I would suggest you should download the TRMs from TI website and
check the impact this change has for all other platforms.
B) on certain platforms like DRA74 SoCs, warm reset cannot be used -
instead all warm resets are converted to cold resets. what that means is
that you'd probably want to update the reset reason to a PMIC scratch
pad register.

>  	omap_prm_reset_system();
>  }
> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
> index 792b106..247b2bf 100644
> --- a/arch/arm/mach-omap2/omap4-sar-layout.h
> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> @@ -20,6 +20,7 @@
>  #define SAR_BANK4_OFFSET		0x3000
>  
>  /* Scratch pad memory offsets from SAR_BANK1 */
> +#define BOOT_MODE_OFFSET			0xa0c
>  #define SCU_OFFSET0				0xfe4
>  #define SCU_OFFSET1				0xfe8
>  #define OMAP_TYPE_OFFSET			0xfec
> @@ -28,6 +29,8 @@
>  #define L2X0_AUXCTRL_OFFSET			0xff8
>  #define L2X0_PREFETCH_CTRL_OFFSET		0xffc
>  
> +#define BOOT_MODE_SIZE				0xf
> +
>  /* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
>  #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
>  #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
> 


-- 
Regards,
Nishanth Menon
