From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Thu, 10 Nov 2016 19:25:30 +0200
Message-ID: <3843374.8iJq7yxRPt@avalon>
References: <20161107215020.31399-1-tony@atomide.com> <20161110150152.GA27724@atomide.com> <2615056.HmWtlhPO5J@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2615056.HmWtlhPO5J@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 10 Nov 2016 19:18:23 Laurent Pinchart wrote:
> On Thursday 10 Nov 2016 08:01:52 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [161110 05:46]:
> >> On Monday 07 Nov 2016 14:50:16 Tony Lindgren wrote:
> >>> Hi all,
> >>> 
> >>> Here are musb fixes for the issues that I've been able to track down.
> >>> Not sure if these will help with the problem Ladis was seeing as I'm
> >>> not able to reproduce that one it seems.
> >>> 
> >>> As many people depend on this driver I'd like to have these merged
> >>> for v4.9-rc cycle after review and testing.
> >>> 
> >>> Please review and test. You need to use v4.9-rc3 or later for testing
> >>> because of the earlier fixes.
> >> 
> >> The series fixes my problems, both with the original and latest version
> >> of
> >> patch 2/4.
> >> 
> >> Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > 
> > OK good to hear and thanks for testing.
> > 
> > I have however seen the following warning once with the original version
> >> of 2/4.
> >> 
> >> [    3.094116] usb 1-1: New USB device found, idVendor=0424,
> >> idProduct=9514
> >> [    3.101257] usb 1-1: New USB device strings: Mfr=0, Product=0,
> >> SerialNumber=0 [    3.110626] ------------[ cut here ]------------
> >> [    3.110717] WARNING: CPU: 0 PID: 4 at
> >> /home/laurent/src/kernel/omap4/linux-2.6/drivers/bus/omap_l3_noc.c:147
> >> l3_interrupt_handler+0x220/0x348 [    3.110717] 44000000.ocp:L3 Custom
> >> Error: MASTER MPU TARGET L4CFG (Read): Data Access in User mode during
> >> Functional access
> > 
> > I've seen similar with interconnect target was not ready in time
> > on ti81xx when booting that got fixed with commit ebf244148092
> > ("ARM: OMAP2+: Use srst_udelay for USB on dm814x"). It is possible
> > that omap4 needs similar fix but hard to say unless we have it
> > reproducable. Anyways, below is an untested patch for omap4 to play
> > with. Maybe repeated reboot or modprobe test would make it
> > reproducable?
> 
> I'll try to give it a go, but right now I'm stuck with a different MUSB
> problem :-) I'm trying to boot my panda board over the SMSC95xx ethernet,
> and have switched gadget support from being compiled in to being compiled
> as a module. I then get
> 
> [    2.766174] musb_bus_suspend 2586: trying to suspend as a_idle while
> active
> 
> printed in a loop at boot time. I've traced musb->is_active being set to 1
> in musb_start() with
> 
> musb->port_mode = MUSB_PORT_MODE_DUAL_ROLE
> musb->xceiv->otg->state = OTG_STATE_A_IDLE
> devctl = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_VBUS
> 
> I can disable gadget support completely which will I believe fix the
> problem, but that's just a workaround. Help would be appreciated.

And on a side note, selecting CONFIG_USB_GADGET=m makes it impossible to build 
CONFIG_USB_NOT_XCEIV=y, making OMAP3 EHCI support only available as a module. 
*sigh* :-)

Felipe, git blame points at you, can this be fixed ?

> > 8< ------------------------------
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c ---
> > a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -2982,6 +2982,7 @@ static struct omap_hwmod_class_sysconfig
> > omap44xx_usb_otg_hs_sysc = { .rev_offs	= 0x0400,
> > 
> >  	.sysc_offs	= 0x0404,
> >  	.syss_offs	= 0x0408,
> > 
> > +	.srst_udelay	= 2,
> > 
> >  	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
> >  	
> >  			   SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
> >  			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
