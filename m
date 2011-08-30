From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] AM35x: voltage: Basic initialization
Date: Tue, 30 Aug 2011 15:26:28 -0700
Message-ID: <87aaaqmt7v.fsf@ti.com>
References: <1313754573-11498-1-git-send-email-abhilash.kv@ti.com>
	<1313754573-11498-2-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1313754573-11498-2-git-send-email-abhilash.kv@ti.com> (Abhilash
	K. V.'s message of "Fri, 19 Aug 2011 17:19:31 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: premi@ti.com, linux@arm.linux.org.uk, sameo@linux.intel.com, tony@atomide.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, david.woodhouse@intel.com
List-Id: linux-omap@vger.kernel.org

Abhilash K V <abhilash.kv@ti.com> writes:

> From: Sanjeev Premi <premi@ti.com>
>
> This patch adds the basic initialization of voltage layer
> for AM35x. Since AM35x doesn't support voltage scaling,
> Many functions have been defined to plug into existing
> voltage layer.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

[...]

> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> index def230f..b45d145 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -67,6 +67,38 @@ static struct omap_vdd_info *omap3_vdd_info[] = {
>  	&omap3_vdd2_info,
>  };
>  
> +/*
> + * AM35x VDD structures
> + *
> + * In AM35x there neither scalable voltage domain nor any hook-up with
> + * voltage controller/processor. However, when trying to re-use the hwmod
> + * database for OMAP3, definition of "core" voltage domain is necessary.
> + * Else, changes in hwmod data structures grow spirally.
> + *
> + * As a workaround, "core" voltage domain is defined below. The definition
> + * doesn't lead to any side-effects.

Except the side-effect of a bunch of unused data, and nop functions that
just clutter things up in a not-very-maintainable way.

For SoCs without scalable voltage domains, we need to fix the underlying
problems in the core code for how to cleanly re-use hwmods.

Fortunately, this core code cleanup is now in progress, so it shouldn't
be long now where we can do this cleanly.

Kevin
