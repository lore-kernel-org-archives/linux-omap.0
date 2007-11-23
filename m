From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix typo in arch/arm/mach-omap2/clock34xx.h
Date: Fri, 23 Nov 2007 13:44:20 -0800
Message-ID: <20071123214420.GN559@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804E3D34D@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804E3D34D@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Gadiyar, Anand <gadiyar@ti.com> [071123 06:35]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Fix typo in clock34xx.h
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6-NOV23/arch/arm/mach-omap2/clock34xx.h
> ===================================================================
> --- linux-omap-2.6-NOV23.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-23 11:36:45.841170240 -0500
> +++ linux-omap-2.6-NOV23/arch/arm/mach-omap2/clock34xx.h	2007-11-23 11:36:55.411715296 -0500
> @@ -1088,7 +1088,7 @@
>  };
>  
>  static struct clk hsotgusb_ick = {
> -	.name		= "hsotgusb_fck",
> +	.name		= "hsotgusb_ick",
>  	.parent		= &core_l3_ick,
>  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
>  	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,

Pushing today.

Tony
