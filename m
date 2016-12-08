From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops on boot
Date: Thu, 08 Dec 2016 21:16:41 +0200
Message-ID: <8760mu8c4m.fsf@linux.intel.com>
References: <20161208032108.21962-1-tony@atomide.com> <87lgvqkb6f.fsf@linux.intel.com> <20161208153734.GF4264@atomide.com> <87a8c6pavm.fsf@linux.intel.com> <20161208182521.GA4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161208182521.GA4920-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Hi,

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> * Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 09:52]:
>> 
>> Hi,
>> 
>> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>> > * Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 01:45]:
>> >> 
>> >> Hi,
>> >> 
>> >> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>> >> > Somehow starting with v4.9-rc7 there have been imprecise
>> >> 
>> >> There's nothing touching dwc3 since v4.9-rc5.
>> >
>> > Right, nothing obvious has changed. I think it's just a slight timing
>> > change in the code that started triggering it.
>> 
>> could be
>> 
>> >> > external aborts on omap5-uevm dwc3 controller. I have not been
>> >> > able to bisect what exactly triggered this as it does not always
>> >> > happen. It seems that something changed with probing that
>> >> > now exposes the issue:
>> >> >
>> >> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> >> 
>> >> hmmm, clock disabled... dwc3-omap shouldn't have pm runtime at all.
>> >
>> > It does for the interconnect target module clkctrl register via PM
>> > runtime. That's the "usb_otg_ss" module.
>> 
>> but that's all hidden in omap_device.c, we don't touch it from driver
>> perspective.
>
> The call to pm_runtime_get_sync() in dwc3_omap_probe() will use it.

right, but there's no runtime suspend until ->remove(). IOW, after
pm_runtime_get_sync(), all necessary clocks should already be
enabled. If they aren't, there's either an erratum or a bug in drivers/clk/ti/

> Is there also some dwc3 internal clock? If we assume the usb_otg_ss
> module is properly enabled it could be some dwc3 internal clock not
> enabled?

no extra clocks.

> We do have a srst_udelay needed for enabling musb controller for some
> SoCs, I'll check if that's the case here.

okay

>> >> > Fix the issue by making sure the dwc3 interrupts are disabled
>> >> > before we call devm_request_threaded_irq().
>> >> 
>> >> that should already be the case. Are you sure that register isn't zero
>> >> in probe?
>> >
>> > Looks like irq0_status = 0 and irqmisc_status = 0x2121. Also just
>> > clearing irqmisc with dwc3_omap_write_irqmisc_clr(omap, 0xffffffff)
>> > stops the issue from happening.
>> >
>> > There is some deferred probing happening but irqmisc is always 0x2121.
>> 
>> some spurious irq status from ROM code, perhaps? Are you not resetting
>> usb_otg_ss hwmod? We shouldn't have any pending interrupts when we get
>> to probe(), if we do have them, then we need an erratum for it.
>
> I have u-boot use it to download the kernel and that is probably using
> the ROM code USB support.

is IRQ status already 0x2121 from u-boot prompt?

>> You could try making usb_otg_ss is reset by hwmod. It would also be good
>> to check other OMAP-ish devices sporting dwc3 (DRA7x, AM437x, AM57x) if
>> they have the same behavior.
>
> It should be reset by default by hwmod.

in which case, IRQ status should be reset to 0.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
