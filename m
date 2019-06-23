From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH 03/15] ARM: ep93xx: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 17:23:55 +0200
Message-ID: <20190623172355.3b29752d8131800750f846fa@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
        <20190623151313.970-4-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-4-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.com, namhyung@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

On Sun, 23 Jun 2019 22:13:01 +0700
Phong Tran <tranmanphong@gmail.com> wrote:

> [arch/arm/mach-ep93xx/clock.c:102]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> [arch/arm/mach-ep93xx/clock.c:132]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> [arch/arm/mach-ep93xx/clock.c:140]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> [arch/arm/mach-ep93xx/core.c:1001]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> [arch/arm/mach-ep93xx/core.c:1002]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/mach-ep93xx/soc.h | 132 ++++++++++++++++++++++-----------------------
>  1 file changed, 66 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
> index f2dace1c9154..831ea5266281 100644
> --- a/arch/arm/mach-ep93xx/soc.h
> +++ b/arch/arm/mach-ep93xx/soc.h
> @@ -109,89 +109,89 @@
>  #define EP93XX_SYSCON_REG(x)		(EP93XX_SYSCON_BASE + (x))
>  #define EP93XX_SYSCON_POWER_STATE	EP93XX_SYSCON_REG(0x00)
>  #define EP93XX_SYSCON_PWRCNT		EP93XX_SYSCON_REG(0x04)
> -#define EP93XX_SYSCON_PWRCNT_FIR_EN	(1<<31)
> -#define EP93XX_SYSCON_PWRCNT_UARTBAUD	(1<<29)
> -#define EP93XX_SYSCON_PWRCNT_USH_EN	(1<<28)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2M1	(1<<27)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2M0	(1<<26)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P8	(1<<25)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P9	(1<<24)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P6	(1<<23)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P7	(1<<22)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P4	(1<<21)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P5	(1<<20)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P2	(1<<19)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P3	(1<<18)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P0	(1<<17)
> -#define EP93XX_SYSCON_PWRCNT_DMA_M2P1	(1<<16)
> +#define EP93XX_SYSCON_PWRCNT_FIR_EN	(1U<<31)

Could you please use BIT() for this?

> +#define EP93XX_SYSCON_PWRCNT_UARTBAUD	(1U<<29)
> +#define EP93XX_SYSCON_PWRCNT_USH_EN	(1U<<28)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M1	(1U<<27)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M0	(1U<<26)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P8	(1U<<25)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P9	(1U<<24)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P6	(1U<<23)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P7	(1U<<22)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P4	(1U<<21)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P5	(1U<<20)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P2	(1U<<19)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P3	(1U<<18)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P0	(1U<<17)
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P1	(1U<<16)
>  #define EP93XX_SYSCON_HALT		EP93XX_SYSCON_REG(0x08)
>  #define EP93XX_SYSCON_STANDBY		EP93XX_SYSCON_REG(0x0c)
>  #define EP93XX_SYSCON_CLKSET1		EP93XX_SYSCON_REG(0x20)
> -#define EP93XX_SYSCON_CLKSET1_NBYP1	(1<<23)
> +#define EP93XX_SYSCON_CLKSET1_NBYP1	(1U<<23)
>  #define EP93XX_SYSCON_CLKSET2		EP93XX_SYSCON_REG(0x24)
> -#define EP93XX_SYSCON_CLKSET2_NBYP2	(1<<19)
> -#define EP93XX_SYSCON_CLKSET2_PLL2_EN	(1<<18)
> +#define EP93XX_SYSCON_CLKSET2_NBYP2	(1U<<19)
> +#define EP93XX_SYSCON_CLKSET2_PLL2_EN	(1U<<18)
>  #define EP93XX_SYSCON_DEVCFG		EP93XX_SYSCON_REG(0x80)
> -#define EP93XX_SYSCON_DEVCFG_SWRST	(1<<31)
> -#define EP93XX_SYSCON_DEVCFG_D1ONG	(1<<30)
> -#define EP93XX_SYSCON_DEVCFG_D0ONG	(1<<29)
> -#define EP93XX_SYSCON_DEVCFG_IONU2	(1<<28)
> -#define EP93XX_SYSCON_DEVCFG_GONK	(1<<27)
> -#define EP93XX_SYSCON_DEVCFG_TONG	(1<<26)
> -#define EP93XX_SYSCON_DEVCFG_MONG	(1<<25)
> -#define EP93XX_SYSCON_DEVCFG_U3EN	(1<<24)
> -#define EP93XX_SYSCON_DEVCFG_CPENA	(1<<23)
> -#define EP93XX_SYSCON_DEVCFG_A2ONG	(1<<22)
> -#define EP93XX_SYSCON_DEVCFG_A1ONG	(1<<21)
> -#define EP93XX_SYSCON_DEVCFG_U2EN	(1<<20)
> -#define EP93XX_SYSCON_DEVCFG_EXVC	(1<<19)
> -#define EP93XX_SYSCON_DEVCFG_U1EN	(1<<18)
> -#define EP93XX_SYSCON_DEVCFG_TIN	(1<<17)
> -#define EP93XX_SYSCON_DEVCFG_HC3IN	(1<<15)
> -#define EP93XX_SYSCON_DEVCFG_HC3EN	(1<<14)
> -#define EP93XX_SYSCON_DEVCFG_HC1IN	(1<<13)
> -#define EP93XX_SYSCON_DEVCFG_HC1EN	(1<<12)
> -#define EP93XX_SYSCON_DEVCFG_HONIDE	(1<<11)
> -#define EP93XX_SYSCON_DEVCFG_GONIDE	(1<<10)
> -#define EP93XX_SYSCON_DEVCFG_PONG	(1<<9)
> -#define EP93XX_SYSCON_DEVCFG_EONIDE	(1<<8)
> -#define EP93XX_SYSCON_DEVCFG_I2SONSSP	(1<<7)
> -#define EP93XX_SYSCON_DEVCFG_I2SONAC97	(1<<6)
> -#define EP93XX_SYSCON_DEVCFG_RASONP3	(1<<4)
> -#define EP93XX_SYSCON_DEVCFG_RAS	(1<<3)
> -#define EP93XX_SYSCON_DEVCFG_ADCPD	(1<<2)
> -#define EP93XX_SYSCON_DEVCFG_KEYS	(1<<1)
> -#define EP93XX_SYSCON_DEVCFG_SHENA	(1<<0)
> +#define EP93XX_SYSCON_DEVCFG_SWRST	(1U<<31)
> +#define EP93XX_SYSCON_DEVCFG_D1ONG	(1U<<30)
> +#define EP93XX_SYSCON_DEVCFG_D0ONG	(1U<<29)
> +#define EP93XX_SYSCON_DEVCFG_IONU2	(1U<<28)
> +#define EP93XX_SYSCON_DEVCFG_GONK	(1U<<27)
> +#define EP93XX_SYSCON_DEVCFG_TONG	(1U<<26)
> +#define EP93XX_SYSCON_DEVCFG_MONG	(1U<<25)
> +#define EP93XX_SYSCON_DEVCFG_U3EN	(1U<<24)
> +#define EP93XX_SYSCON_DEVCFG_CPENA	(1U<<23)
> +#define EP93XX_SYSCON_DEVCFG_A2ONG	(1U<<22)
> +#define EP93XX_SYSCON_DEVCFG_A1ONG	(1U<<21)
> +#define EP93XX_SYSCON_DEVCFG_U2EN	(1U<<20)
> +#define EP93XX_SYSCON_DEVCFG_EXVC	(1U<<19)
> +#define EP93XX_SYSCON_DEVCFG_U1EN	(1U<<18)
> +#define EP93XX_SYSCON_DEVCFG_TIN	(1U<<17)
> +#define EP93XX_SYSCON_DEVCFG_HC3IN	(1U<<15)
> +#define EP93XX_SYSCON_DEVCFG_HC3EN	(1U<<14)
> +#define EP93XX_SYSCON_DEVCFG_HC1IN	(1U<<13)
> +#define EP93XX_SYSCON_DEVCFG_HC1EN	(1U<<12)
> +#define EP93XX_SYSCON_DEVCFG_HONIDE	(1U<<11)
> +#define EP93XX_SYSCON_DEVCFG_GONIDE	(1U<<10)
> +#define EP93XX_SYSCON_DEVCFG_PONG	(1U<<9)
> +#define EP93XX_SYSCON_DEVCFG_EONIDE	(1U<<8)
> +#define EP93XX_SYSCON_DEVCFG_I2SONSSP	(1U<<7)
> +#define EP93XX_SYSCON_DEVCFG_I2SONAC97	(1U<<6)
> +#define EP93XX_SYSCON_DEVCFG_RASONP3	(1U<<4)
> +#define EP93XX_SYSCON_DEVCFG_RAS	(1U<<3)
> +#define EP93XX_SYSCON_DEVCFG_ADCPD	(1U<<2)
> +#define EP93XX_SYSCON_DEVCFG_KEYS	(1U<<1)
> +#define EP93XX_SYSCON_DEVCFG_SHENA	(1U<<0)
>  #define EP93XX_SYSCON_VIDCLKDIV		EP93XX_SYSCON_REG(0x84)
> -#define EP93XX_SYSCON_CLKDIV_ENABLE	(1<<15)
> -#define EP93XX_SYSCON_CLKDIV_ESEL	(1<<14)
> -#define EP93XX_SYSCON_CLKDIV_PSEL	(1<<13)
> +#define EP93XX_SYSCON_CLKDIV_ENABLE	(1U<<15)
> +#define EP93XX_SYSCON_CLKDIV_ESEL	(1U<<14)
> +#define EP93XX_SYSCON_CLKDIV_PSEL	(1U<<13)
>  #define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
>  #define EP93XX_SYSCON_I2SCLKDIV		EP93XX_SYSCON_REG(0x8c)
> -#define EP93XX_SYSCON_I2SCLKDIV_SENA	(1<<31)
> -#define EP93XX_SYSCON_I2SCLKDIV_ORIDE   (1<<29)
> -#define EP93XX_SYSCON_I2SCLKDIV_SPOL	(1<<19)
> +#define EP93XX_SYSCON_I2SCLKDIV_SENA	(1U<<31)
> +#define EP93XX_SYSCON_I2SCLKDIV_ORIDE   (1U<<29)
> +#define EP93XX_SYSCON_I2SCLKDIV_SPOL	(1U<<19)
>  #define EP93XX_I2SCLKDIV_SDIV		(1 << 16)
>  #define EP93XX_I2SCLKDIV_LRDIV32	(0 << 17)
>  #define EP93XX_I2SCLKDIV_LRDIV64	(1 << 17)
>  #define EP93XX_I2SCLKDIV_LRDIV128	(2 << 17)
>  #define EP93XX_I2SCLKDIV_LRDIV_MASK	(3 << 17)
>  #define EP93XX_SYSCON_KEYTCHCLKDIV	EP93XX_SYSCON_REG(0x90)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1<<31)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
> -#define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1U<<31)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1U<<16)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1U<<15)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1U<<0)
>  #define EP93XX_SYSCON_SYSCFG		EP93XX_SYSCON_REG(0x9c)
>  #define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)
>  #define EP93XX_SYSCON_SYSCFG_REV_SHIFT	(28)
> -#define EP93XX_SYSCON_SYSCFG_SBOOT	(1<<8)
> -#define EP93XX_SYSCON_SYSCFG_LCSN7	(1<<7)
> -#define EP93XX_SYSCON_SYSCFG_LCSN6	(1<<6)
> -#define EP93XX_SYSCON_SYSCFG_LASDO	(1<<5)
> -#define EP93XX_SYSCON_SYSCFG_LEEDA	(1<<4)
> -#define EP93XX_SYSCON_SYSCFG_LEECLK	(1<<3)
> -#define EP93XX_SYSCON_SYSCFG_LCSN2	(1<<1)
> -#define EP93XX_SYSCON_SYSCFG_LCSN1	(1<<0)
> +#define EP93XX_SYSCON_SYSCFG_SBOOT	(1U<<8)
> +#define EP93XX_SYSCON_SYSCFG_LCSN7	(1U<<7)
> +#define EP93XX_SYSCON_SYSCFG_LCSN6	(1U<<6)
> +#define EP93XX_SYSCON_SYSCFG_LASDO	(1U<<5)
> +#define EP93XX_SYSCON_SYSCFG_LEEDA	(1U<<4)
> +#define EP93XX_SYSCON_SYSCFG_LEECLK	(1U<<3)
> +#define EP93XX_SYSCON_SYSCFG_LCSN2	(1U<<1)
> +#define EP93XX_SYSCON_SYSCFG_LCSN1	(1U<<0)
>  #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
>  
>  /* EP93xx System Controller software locked register write */

-- 
Alexander Sverdlin.
