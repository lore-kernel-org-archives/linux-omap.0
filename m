From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DRA722: remove redundant definition of 1.0 device
Date: Wed, 2 Mar 2016 16:24:20 -0600
Message-ID: <56D76814.20804@ti.com>
References: <1456957275-2025-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456957275-2025-1-git-send-email-vishalm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vishal Mahaveer <vishalm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/02/2016 04:21 PM, Vishal Mahaveer wrote:
> Remove duplicate definition of Rev 1.0 device.
> Fixes: 81032e34e184 ("ARM: DRA752: Add ID detect for ES2.0")
> 
If tony is ok fixing the beautification...

> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
> ---
>  arch/arm/mach-omap2/soc.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
> index 79ca3c3..83d3547 100644
> --- a/arch/arm/mach-omap2/soc.h
> +++ b/arch/arm/mach-omap2/soc.h
> @@ -471,7 +471,6 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
>  #define DRA752_REV_ES2_0	(DRA7XX_CLASS | (0x52 << 16) | (0x20 << 8))
>  #define DRA722_REV_ES1_0	(DRA7XX_CLASS | (0x22 << 16) | (0x10 << 8))
> -#define DRA722_REV_ES1_0	(DRA7XX_CLASS | (0x22 << 16) | (0x10 << 8))
>  
>  void omap2xxx_check_revision(void);
>  void omap3xxx_check_revision(void);
> 
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
