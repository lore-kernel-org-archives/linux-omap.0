From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Mon, 14 Dec 2009 18:33:24 +0200
Message-ID: <20091214163324.GB31829@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260797982-28880-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Dec 14, 2009 at 02:39:41PM +0100, ext Ajay Kumar Gupta wrote:
>+void musb_restore_context(struct musb *musb)
>+{
>+       int i;
>+       void __iomem *musb_base = musb->mregs;
>+       void __iomem *ep_target_regs;
>+
>+       musb_platform_restore_context(&musb_context);
>+
>+       if (is_host_enabled(musb)) {
>+               musb_writew(musb_base, MUSB_FRAME, musb_context.frame);
>+               musb_writeb(musb_base, MUSB_TESTMODE, musb_context.testmode);
>+       }
>+       musb_writeb(musb_base, MUSB_POWER, musb_context.power);
>+       musb_writew(musb_base, MUSB_INTRTXE, musb_context.intrtxe);
>+       musb_writew(musb_base, MUSB_INTRRXE, musb_context.intrrxe);
>+       musb_writeb(musb_base, MUSB_INTRUSBE, musb_context.intrusbe);
>+       musb_writeb(musb_base, MUSB_DEVCTL, musb_context.devctl);
>+
>+       for (i = 0; i < MUSB_C_NUM_EPS; ++i) {
>+               musb_writeb(musb_base, MUSB_INDEX, i);
>+               musb_writew(musb_base, 0x10 + MUSB_TXMAXP,
>+                       musb_context.index_regs[i].txmaxp);
>+               musb_writew(musb_base, 0x10 + MUSB_TXCSR,
>+                       musb_context.index_regs[i].txcsr);
>+               musb_writew(musb_base, 0x10 + MUSB_RXMAXP,
>+                       musb_context.index_regs[i].rxmaxp);
>+               musb_writew(musb_base, 0x10 + MUSB_RXCSR,
>+                       musb_context.index_regs[i].rxcsr);
>+
>+               if (musb->dyn_fifo) {

if (musb->config->dyn_fifo)

>@@ -2179,15 +2322,23 @@ static int musb_suspend(struct device *dev)
>        spin_lock_irqsave(&musb->lock, flags);
>
>        if (is_peripheral_active(musb)) {
>-               /* FIXME force disconnect unless we know USB will wake
>-                * the system up quickly enough to respond ...
>+               /* System is entering into suspend where gadget would not be
>+                * able to respond to host and thus it will be in an unknown
>+                * state for host. Re-enumeration of gadget is required after
>+                * a resume. So we force a disconnect.
>                 */
>+               reg = musb_readb(musb->mregs, MUSB_POWER);
>+               reg &= ~MUSB_POWER_SOFTCONN;
>+               musb_writeb(musb->mregs, MUSB_POWER, reg);
>+

I think we should only allow suspend if cable isn't connected. What 
would happend if you have mounted fs (using mass storage), user is 
transferring files and you force a disconnect ?

>diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>index 83beeac..15a3f27 100644
>--- a/drivers/usb/musb/omap2430.c
>+++ b/drivers/usb/musb/omap2430.c
>@@ -255,6 +255,22 @@ int __init musb_platform_init(struct musb *musb)
>        return 0;
> }
>
>+#ifdef CONFIG_PM
>+void musb_platform_save_context(struct musb_context_registers
>+               *musb_context)
>+{
>+       musb_context->otg_sysconfig = omap_readl(OTG_SYSCONFIG);
>+       musb_context->otg_forcestandby = omap_readl(OTG_FORCESTDBY);
>+}
>+
>+void musb_platform_restore_context(struct musb_context_registers
>+               *musb_context)

waaay too many exported functions already. Let's add some structure to 
pass functions pointers. I'll cook a patch adding suspend(), resume(), 
init() and friends and send tomorrow.

Then your patch would add save_context() and restore_context().

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
