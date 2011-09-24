From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Sat, 24 Sep 2011 00:30:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109240020510.22872@utopia.booyaka.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com> <1316691479-1849-2-git-send-email-keshava_mgowda@ti.com> <1316691479-1849-3-git-send-email-keshava_mgowda@ti.com> <alpine.DEB.2.00.1109221115320.10719@utopia.booyaka.com>
 <CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAP05o4+Zc2z6sBOX_rQeoDQ9PneypcLRCyBbaaB2m+ZjeXZnaw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 23 Sep 2011, Munegowda, Keshava wrote:

> On Thu, Sep 22, 2011 at 11:31 PM, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> But the question arises here , why do we need these ehci and ohci as two 
> different hwmods containing only irq and base address? It is required 
> for future - to implement remote wakeup feature for ehci and ohci ports 
> depending on irq-chain handler patches by Tero. Separate hwmods for ehci 
> and ohci are needed to enable prcm chain-handler to uniquely identify 
> the wakeup source as ehci or ohci and call only the corresponding 
> interrupt handler. We will be using omap_hwmod_mux_init for ehci and 
> ohci hwmods to enable I/O wakeup capability for respective IO-pads. 
> Depending on the particular wakeup source(ehci/ohci), the corresponding 
> ehci or ohci irq handler will be called.
> 
> If ehci and ohci are combined with usbhs hwmod as a single hwmod , then 
> for every wakeup (either ehci or ohci port wakeup) only the first 
> interrupt handler will be called (please look at the function 
> omap_hwmod_mux_handle_irq of
> 
> /arch/arm/mach-omap2/mux.c file ; in tero's latest patch:
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg53139.html)
> , so in this
> case, if ehci interrupt is the first interrupt , then even for ohci wakeup
> , only ehci interrupt will get called; which will break the functionality.

Any reason why this couldn't be handled either by:

1. adding an IRQ number field to struct omap_hwmod_mux_info, and changing
_omap_hwmod_mux_handle_irq() to raise that IRQ number?

or 

2. using shared interrupts?


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
