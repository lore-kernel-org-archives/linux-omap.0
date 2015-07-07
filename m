From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/6] ARM: AM43xx: Add the PRM IRQ register offsets
Date: Tue, 7 Jul 2015 14:55:42 +0300
Message-ID: <559BBE3E.809@ti.com>
References: <1434954176-9605-1-git-send-email-j-keerthy@ti.com> <1434954176-9605-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434954176-9605-3-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com
Cc: galak@codeaurora.org, pawel.moll@arm.com, linux-kernel@vger.kernel.org, paul@pwsan.com, bcousson@baylibre.com, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/22/2015 09:22 AM, Keerthy wrote:
> Add the PRM IRQ register offsets.

This patch doesn't apply cleanly to 4.2-rc1.

-Tero

>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   arch/arm/mach-omap2/prcm43xx.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
> index d026199..ec1ac5c 100644
> --- a/arch/arm/mach-omap2/prcm43xx.h
> +++ b/arch/arm/mach-omap2/prcm43xx.h
> @@ -25,6 +25,10 @@
>   #define AM43XX_PRM_WKUP_INST				0x2000
>   #define AM43XX_PRM_DEVICE_INST				0x4000
>
> +/* PRM_IRQ offsets */
> +#define AM43XX_PRM_IRQSTATUS_MPU_OFFSET			0x0004
> +#define AM43XX_PRM_IRQENABLE_MPU_OFFSET			0x0008
> +
>   /* RM RSTCTRL offsets */
>   #define AM43XX_RM_PER_RSTCTRL_OFFSET			0x0010
>   #define AM43XX_RM_GFX_RSTCTRL_OFFSET			0x0010
> @@ -146,4 +150,5 @@
>   #define AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET		0x04a0
>   #define AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET		0x0068
>   #define AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET		0x0070
> +#define AM43XX_PRM_IO_PMCTRL_OFFSET			0x0024
>   #endif
>
