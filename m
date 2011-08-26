From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 4/6] ti816evm: Add support for musb interface
Date: Fri, 26 Aug 2011 17:27:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC00824A@dbde02.ent.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-5-git-send-email-ajay.gupta@ti.com>
 <4E578466.1040405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E578466.1040405-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> 
> On 26-08-2011 15:11, Ajay Kumar Gupta wrote:
> 
> > From: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
> 
> > Adding musb support in ti816 EVM board file.
> 
> > Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Ravi B<ravibabu-l0cyMroinI0@public.gmane.org>
> 
>     As far as I know, full name is required in signoff.

Ok.

> 
> > ---
> >   arch/arm/mach-omap2/board-ti8168evm.c |   15 +++++++++++++++
> >   1 files changed, 15 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-
> omap2/board-ti8168evm.c
> > index e516a04..77200d4 100644
> > --- a/arch/arm/mach-omap2/board-ti8168evm.c
> > +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> > @@ -23,6 +23,20 @@
> >  #include<plat/irqs.h>
> >  #include<plat/board.h>
> >  #include<plat/common.h>
> > +#include<plat/usb.h>
> > +
> > +static struct omap_musb_board_data musb_board_data = {
> > +	.set_phy_power	= ti81xx_musb_phy_power,
> > +	.interface_type	= MUSB_INTERFACE_ULPI,
> > +#ifdef CONFIG_USB_MUSB_OTG
> > +	.mode           = MUSB_OTG,
> > +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> > +	.mode           = MUSB_HOST,
> > +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> > +	.mode           = MUSB_PERIPHERAL,
> > +#endif
> 
>     This #ifdef'ery is not longer necessary afetr this patch:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commit;h=75a14b1434a0ca409bcc8ab9b6b2e680796c487e

Got it, so it should be only.
+	.mode	= MUSB_OTG

Due to the below patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=622859634a663c5e55d0e2a2cdbb55ac058d97b3

The .mode is still being passed to musb->board_mode which is used for below definitions.
#define is_peripheral_enabled(musb)     ((musb)->board_mode != MUSB_HOST)
#define is_host_enabled(musb)           ((musb)->board_mode != MUSB_PERIPHERAL)
#define is_otg_enabled(musb)            ((musb)->board_mode == MUSB_OTG)


Thanks,
Ajay
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
