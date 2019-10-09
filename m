From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2+: force iomem for omap_interconnect_sync
Date: Wed, 9 Oct 2019 17:14:24 +0100
Message-ID: <20191009161423.GB1337@shell.armlinux.org.uk>
References: <20191009133902.28405-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191009133902.28405-1-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 09, 2019 at 02:39:02PM +0100, Ben Dooks wrote:
> Force the type of omap_interconnect_sync to avoid the
> following sparse warnign:
> 
> arch/arm/mach-omap2/omap4-common.c:142:27: warning: incorrect type in assignment (different address spaces)
> arch/arm/mach-omap2/omap4-common.c:142:27:    expected void [noderef] <asn:2> *static [toplevel] sram_sync
> arch/arm/mach-omap2/omap4-common.c:142:27:    got void *
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> ---
>  arch/arm/mach-omap2/omap4-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 5c3845730dbf..d27c5f61d708 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -139,7 +139,7 @@ static int __init omap4_sram_init(void)
>  		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
>  			__func__);
>  	else
> -		sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
> +		sram_sync = (void __force __iomem *)gen_pool_alloc(sram_pool, PAGE_SIZE);

Not sure about this one - did you check whether the memory returned
here really is iomem memory?  If it isn't iomem memory, then the
warning should remain.

Never hide a valid sparse warning - to do so goes against the whole
point of sparse checks.  It isn't "pointing out that a cast is missing,
we must add a cast", the point of sparse is to find and identify where
the code is actually incorrect - in other words, MMIO accessors are
used on memory that is not MMIO, or direct dereferences are used on
memory that is MMIO.  If we go around merely casting the warnings away,
it makes sparse completely pointless.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
