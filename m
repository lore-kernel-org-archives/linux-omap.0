From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 17 Jun 2010 19:39:24 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E91B88E@dbde02.ent.ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <4C1A0499.9020802@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044E91B843@dbde02.ent.ti.com>
 <4C1A2220.7070502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C1A2220.7070502-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >>     AFAIR, it was intentionally removed from the function top and
> declared
> >> in the multiple plcase instead by the former Felipe's patch [1] to fix
> >> exactly the same issue, if I don't mistake. So, it hasn't worked out?
> 
> > Yes, it was removed by Felipe's below patch but it introduced
> > compilation warning issue as reported.
> 
> > ---------------
> > commit aa4714560b4ea359bb7830188ebd06bce71bcdea
> > usb: musb: core: declare mbase only where it's used
> 
> > ... and avoid a compilation if we disable host side
> > of musb.
> > --------------
> 
> >>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> >> [...]
> >>> diff --git a/drivers/usb/musb/musb_core.c
> b/drivers/usb/musb/musb_core.c
> >>> index f0ff893..7cc8398 100644
> >>> --- a/drivers/usb/musb/musb_core.c
> >>> +++ b/drivers/usb/musb/musb_core.c
> >>> @@ -455,6 +455,9 @@ static irqreturn_t musb_stage0_irq(struct musb
> *musb, u8 int_usb,
> >>>  				u8 devctl, u8 power)
> >>>  {
> >>>  	irqreturn_t handled = IRQ_NONE;
> >>> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> >>> +	void __iomem	*mbase = musb->mregs;
> >>> +#endif
> 
> >>     I'd rather see it declared multiple times...
> 
> > I was thinking it's better to have it at one place and avoid multiple
> > #ifdefs.
> 
>     You'd only need one #ifdef: in the placae where the warning was
> reported. And you can open a block under #ifdef CONFIG_USB_MUSB_OTG to
> declare it in. Other declarations are already covered by #ifdef's,
> aren't they?

Here is the version-2 of this patch.

--------------- cut here -------------------
Fixes below compilation warning when host only configuration is
selected.
drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index a8b0440..cfae447 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -704,7 +704,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (int_usb & MUSB_INTR_CONNECT) {
 		struct usb_hcd *hcd = musb_to_hcd(musb);
+#ifdef CONFIG_USB_MUSB_OTG
 		void __iomem *mbase = musb->mregs;
+#endif
 
 		handled = IRQ_HANDLED;
 		musb->is_active = 1;
-- 
1.6.2.4
--------------------------------------------


Thanks,
Ajay
> 
> > -Ajay
> >>> @@ -703,7 +700,6 @@ static irqreturn_t musb_stage0_irq(struct musb
> >> *musb, u8 int_usb,
> >>>  	if (int_usb & MUSB_INTR_CONNECT) {
> >>>  		struct usb_hcd *hcd = musb_to_hcd(musb);
> >>> -		void __iomem *mbase = musb->mregs;
> 
> >>     We could also move this into the #ifdef CONFIG_USB_MUSB_OTG block.
> 
>     Yeah, the block where 'mbase' is actually used.
> 
>     BTW, your patch didn't cover the declaration in #if 0'ed out SOF
> handler.
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
