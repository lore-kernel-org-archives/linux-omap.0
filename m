From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] io.c for OMAP3430
Date: Wed, 30 May 2007 06:41:48 -0700
Message-ID: <20070530134148.GD28353@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C470106287E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470106287E@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070529 21:13]:
> Hi Tony,
> 
> I have incorporated your review comments for io.c. 
> 
> Please do let me know if you find any further issues.
> 
> I have incorporated other review comments from Andrew and Trilok, will regenerate and publish
> the patch set once we agree upon these (irq.c and io.c) patch set.

Well I was thinking we'd have different structs:

#ifdef CONFIG_ARCH_OMAP24XX
static struct map_desc omap24xx_io_desc[] __initdata = {
       ...
};
#endif

#ifdef CONFIG_ARCH_OMAP34XX
static struct map_desc omap34xx_io_desc[] __initdata = {
       ...
       };
#endif
       
void __init omap2_map_common_io(void)
{
 	if (cpu_is_omap24xx()) {
        	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
	} else if (cpu_is_omap34xx()) {
		iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
	}
	...
}

We should actually have separate one for 2420 and 2430 too to avoid
ifdefs within the structs.

Regards,

Tony
