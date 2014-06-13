From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 00/19] irqchip: crossbar: driver fixes
Date: Fri, 13 Jun 2014 11:01:22 -0400
Message-ID: <20140613150122.GP8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:08PM +0530, Sricharan R wrote:
> This series does some cleanups, fixes for handling two interrupts
> getting mapped twice to same crossbar and provides support for
> hardwired IRQ and crossbar definitions.
> 
> On certain platforms such as DRA7, SPIs 0, 1, 2, 3, 5, 6, 10,
> 131, 132, 133 are direct wired to hardware blocks bypassing
> crossbar. This quirky implementation is *NOT* supposed to be the
> expectation of crossbar hardware usage. This series adds support
> to represent such hard-wired irqs through DT and avoid generic
> allocation/programming of crossbar in the driver.
> 
> This way of supporting hard-wired irqs was a result of
> the below discussions.
> http://www.spinics.net/lists/arm-kernel/msg329946.html
> 
> Based on 3.15 mainline.
> 
> All the patches are available here
>  git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:Sricharanti/sricharan.git crossbar_updates
> 
> The fixes series[1] earlier posted is merged in to this.
> [1] http://www.spinics.net/lists/arm-kernel/msg328273.html
> 
> [V2] Merged the above series and rebased on 3.15 mainline
> 
> Nishanth Menon (16):
>   irqchip: crossbar: dont use '0' to mark reserved interrupts
>   irqchip: crossbar: check for premapped crossbar before allocating
>   irqchip: crossbar: Skip some irqs from getting mapped to crossbar
>   irqchip: crossbar: Initialise the crossbar with a safe value
>   irqchip: crossbar: Change allocation logic by reversing search for
>     free irqs
>   irqchip: crossbar: remove IS_ERR_VALUE check
>   irqchip: crossbar: fix sparse warnings
>   irqchip: crossbar: fix checkpatch warning
>   irqchip: crossbar: fix kerneldoc warning
>   irqchip: crossbar: fix memory leak incase of invalid entry
>   irqchip: crossbar: return proper error value
>   irqchip: crossbar: change the goto naming
>   irqchip: crossbar: introduce ti,max-crossbar-sources to identify
>     valid crossbar mapping
>   irqchip: crossbar: introduce centralized check for crossbar write
>   Documentation: dt: OMAP: crossbar: add description for interrupt
>     consumer
>   irqchip: crossbar allow for quirky hardware with direct hardwiring of
>     GIC
> 
> Rajendra Nayak (1):
>   irqchip: crossbar: DRA7: Fix unused crossbar list
> 
> Sricharan R (2):
>   irqchip: crossbar: set cb pointer to null in case of error
>   irqchip: crossbar: Add kerneldoc for crossbar_domain_unmap callback

Also, I just noticed this when I decided to look at the history of this
driver: Please format the subject lines like so:

  irqchip: crossbar: Set cb pointer ...
                     ^
                     |
                     \-- note the capitalization

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
