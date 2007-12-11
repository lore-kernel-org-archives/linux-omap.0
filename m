From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [PATCH 1/2] OMAP Security HW accel: Adding base address and
 interruption on header files.
Date: Tue, 11 Dec 2007 11:10:26 -0400
Message-ID: <475EA862.8020708@indt.org.br>
References: <1196980234-14975-1-git-send-email-david.cohen@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1196980234-14975-1-git-send-email-david.cohen@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Cohen <david.cohen@indt.org.br>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi David,

I just tested and it is working fine.

Acked-by: Anderson Briglia <anderson.briglia@indt.org.br>

ext David Cohen wrote:
> This patch adds the base address and interruption on header files for the
> OMAP security hw module acceleration.
> 
> Signed-off-by: David Cohen <david.cohen@indt.org.br>
> ---
>  include/asm-arm/arch-omap/irqs.h     |    2 ++
>  include/asm-arm/arch-omap/omap16xx.h |    5 +++++
>  include/asm-arm/arch-omap/omap24xx.h |    8 ++++++++
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
> index ec58dfd..1242696 100644
> --- a/include/asm-arm/arch-omap/irqs.h
> +++ b/include/asm-arm/arch-omap/irqs.h
> @@ -177,6 +177,7 @@
>  #define INT_1610_DMA_CH14	(61 + IH2_BASE)
>  #define INT_1610_DMA_CH15	(62 + IH2_BASE)
>  #define INT_1610_NAND		(63 + IH2_BASE)
> +#define INT_1610_SHA1MD5	(91 + IH2_BASE)
>  
>  /*
>   * OMAP-730 specific IRQ numbers for interrupt handler 2
> @@ -264,6 +265,7 @@
>  #define INT_24XX_GPTIMER10	46
>  #define INT_24XX_GPTIMER11	47
>  #define INT_24XX_GPTIMER12	48
> +#define INT_24XX_SHA1MD5	51
>  #define INT_24XX_I2C1_IRQ	56
>  #define INT_24XX_I2C2_IRQ	57
>  #define INT_24XX_HDQ_IRQ	58
> diff --git a/include/asm-arm/arch-omap/omap16xx.h b/include/asm-arm/arch-omap/omap16xx.h
> index db85276..d576e59 100644
> --- a/include/asm-arm/arch-omap/omap16xx.h
> +++ b/include/asm-arm/arch-omap/omap16xx.h
> @@ -44,6 +44,11 @@
>  #define OMAP16XX_DSPREG_SIZE	SZ_128K
>  #define OMAP16XX_DSPREG_START	0xE1000000
>  
> +#define OMAP16XX_SEC_BASE	0xFFFE4000
> +#define OMAP16XX_SEC_DES	(OMAP16XX_SEC_BASE + 0x0000)
> +#define OMAP16XX_SEC_SHA1MD5	(OMAP16XX_SEC_BASE + 0x0800)
> +#define OMAP16XX_SEC_RNG	(OMAP16XX_SEC_BASE + 0x1000)
> +
>  /*
>   * ---------------------------------------------------------------------------
>   * Interrupts
> diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
> index adc89a8..3d6673d 100644
> --- a/include/asm-arm/arch-omap/omap24xx.h
> +++ b/include/asm-arm/arch-omap/omap24xx.h
> @@ -48,6 +48,7 @@
>  #define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
>  #define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
>  #define OMAP2420_SMS_BASE	0x68008000
> +#define OMAP2420_SEC_BASE	(L4_24XX_BASE + 0xA0000)
>  
>  #define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
>  #define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
> @@ -77,6 +78,13 @@
>  /* Camera */
>  #define OMAP24XX_CAMERA_BASE	(L4_24XX_BASE + 0x52000)
>  
> +/* Security */
> +#define OMAP2420_SEC_RNG_BASE	(OMAP2420_SEC_BASE + 0x0000)
> +#define OMAP2420_SEC_DES_BASE	(OMAP2420_SEC_BASE + 0x2000)
> +#define OMAP2420_SEC_SHA1MD5_BASE (OMAP2420_SEC_BASE + 0x4000)
> +#define OMAP2420_SEC_AES_BASE	(OMAP2420_SEC_BASE + 0x6000)
> +#define OMAP2420_SEC_PKA_BASE	(OMAP2420_SEC_BASE + 0x8000)
> +
>  #if defined(CONFIG_ARCH_OMAP2420)
>  
>  #define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
