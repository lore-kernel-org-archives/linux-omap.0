From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To add OMAP 2430 Support
Date: Thu, 9 Nov 2006 04:22:10 +0200
Message-ID: <20061109022209.GC9740@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, Richard Woodruff <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061103 20:46]:
> Hi all,
> 
> Attached are set of patches to get OMAP 2430 "minimal" support on to the
> tree. 
> 
> With these patches I was able to boot the kernel on 2430SDP and have
> verified booting the same on 2420 H4 (just to confirm it doesn't break
> any existing 2420 functionality).

Cool. Can you please inline your patches next time to allow easier
commenting on the code?
 
> Please do let me know for any issues, I would be glad to correct and
> re-submit them.

Looks OK in general, just one comment below.

> +#define sync_p_port_write()	\
> +	({ int dv = 0;	\
> +		 __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 4" : : "r" (dv));	\
> +	})
> +
> /*
>  * OMAP2 has a number of different interrupt controllers, each interrupt
>  * controller is identified as its own "bank". Register definitions are
> @@ -48,6 +53,7 @@ static struct omap_irq_bank {
> static void omap_ack_irq(unsigned int irq)
> {
> 	__raw_writel(0x1, irq_banks[0].base_reg + INTC_CONTROL);
> +	sync_p_port_write();
> }
> 
> static void omap_mask_irq(unsigned int irq)

I'd leave this out of the patch for now until we know if it's
still needed. If it's needed, there should probably be arm generic
function for it. Maybe dwb() or something like that? :)

I think at some point Richard Woodruff said that he had to drain
write buffer for timer writes because of some inaccuracy. Richard,
could you please clarify it again? I don't think I've seen these
issues on 2420 myself, but maybe some timer test code could expose
it?

Regards,

Tony
