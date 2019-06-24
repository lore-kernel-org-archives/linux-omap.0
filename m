From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V2 04/15] ARM: exynos: cleanup cppcheck shifting error
Date: Mon, 24 Jun 2019 14:58:13 +0100
Message-ID: <20190624135813.ojywq36nljk4ukyj@shell.armlinux.org.uk>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190624135105.15579-5-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624135105.15579-5-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pieralisi@arm
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 08:50:54PM +0700, Phong Tran wrote:
> [arch/arm/mach-exynos/suspend.c:288]: (error) Shifting signed 32-bit
> value by 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/mach-exynos/suspend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index be122af0de8f..b6a73dc5bde4 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -285,7 +285,7 @@ static void exynos_pm_set_wakeup_mask(void)
>  	 * Set wake-up mask registers
>  	 * EXYNOS_EINT_WAKEUP_MASK is set by pinctrl driver in late suspend.
>  	 */
> -	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
> +	pmu_raw_writel(exynos_irqwake_intmask & ~(BIT(31)), S5P_WAKEUP_MASK);

Parens around BIT() are no longer required.

>  }
>  
>  static void exynos_pm_enter_sleep_mode(void)
> -- 
> 2.11.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
