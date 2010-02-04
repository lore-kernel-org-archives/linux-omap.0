From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
Date: Thu, 4 Feb 2010 14:42:50 +0000
Message-ID: <20100204144250.GB27344@n2100.arm.linux.org.uk>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-3-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Woodruff Richard <r-woodruff2@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 04, 2010 at 07:55:46PM +0530, Santosh Shilimkar wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 1a14d18..6241f10 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -56,12 +56,41 @@ static inline void l2x0_inv_line(unsigned long addr)
>  	writel(addr, base + L2X0_INV_LINE_PA);
>  }
>  
> +#ifdef CONFIG_PL310_ERRATA_588369
> +extern void omap_smc1(u32 fn, u32 arg);
> +static void debug_writel(unsigned long val)
> +{

You could move the external declaration into this function, thereby
making it entirely local to this function (and hiding it from the
file scope.)
