From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Thu, 10 Nov 2016 22:29:34 +0200
Message-ID: <13695022.UUbBUaRpJY@avalon>
References: <20161107215020.31399-1-tony@atomide.com> <2615056.HmWtlhPO5J@avalon> <20161110175033.GD27724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161110175033.GD27724-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 10 Nov 2016 10:50:33 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161110 10:18]:
> > I'll try to give it a go, but right now I'm stuck with a different MUSB
> > problem :-) I'm trying to boot my panda board over the SMSC95xx ethernet,
> > and have switched gadget support from being compiled in to being compiled
> > as a module. I then get
> > 
> > [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle while
> > active
> > 
> > printed in a loop at boot time. I've traced musb->is_active being set to 1
> > in musb_start() with
> > 
> > musb->port_mode = MUSB_PORT_MODE_DUAL_ROLE
> > musb->xceiv->otg->state = OTG_STATE_A_IDLE
> > devctl = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_VBUS
> > 
> > I can disable gadget support completely which will I believe fix the
> > problem, but that's just a workaround. Help would be appreciated.
> 
> Do you have the ID pin grounded

I've measured it on the board and I don't. Booting with the USB cable 
unplugged and the board powered through the power jack gives the same result.

> or how do you get to the A_IDLE state?

Don't ask me :-)

> I'm pretty much only testing with loadable modules as in
> omap2plus_defconfig, I don't think I've seen this issue..
> 
> Maybe check the changes in your .config against just plain
> omap2plus_defconfig? Are you trying to force host only mode?

I started anew from omap2plus_defconfig and applied the following changes to 
enable NFS root.

-CONFIG_USB_NET_DRIVERS=m
-CONFIG_USB_USBNET=m
-CONFIG_USB_NET_SMSC95XX=m
-CONFIG_USB=m
-CONFIG_USB_EHCI_HCD=m
-CONFIG_USB_EHCI_HCD_OMAP=m
-CONFIG_NOP_USB_XCEIV=m
-CONFIG_USB_GADGET=m
-CONFIG_OMAP_USB2=m
+CONFIG_USB_NET_DRIVERS=y
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_SMSC95XX=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_OMAP=y
+CONFIG_NOP_USB_XCEIV=y
+# CONFIG_USB_GADGET is not set
+CONFIG_OMAP_USB2=y

I had to disable CONFIG_USB_GADGET is compiling it as a module prevents 
selecting CONFIG_NOP_USB_XCEIV=y, which is a dependency for 
CONFIG_USB_EHCI_HCD_OMAP=m.

The new configuration resulted in a few changes, among which the most notable 
is

-# CONFIG_USB_MUSB_HOST is not set
-# CONFIG_USB_MUSB_GADGET is not set
-CONFIG_USB_MUSB_DUAL_ROLE=y
+CONFIG_USB_MUSB_HOST=y

I then get the same error as originally reported.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
