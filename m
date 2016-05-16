From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Mon, 16 May 2016 08:19:01 -0700
Message-ID: <20160516151901.GJ5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
 <20160513211739.GE5995@atomide.com>
 <20160513212252.GA1659@uda0271908>
 <20160513213900.GF5995@atomide.com>
 <20160513220232.GA2478@uda0271908>
 <20160513222517.GG5995@atomide.com>
 <20160515044212.GB20689@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160515044212.GB20689@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160514 21:44]:
> Hi,
> 
> On Fri, May 13, 2016 at 03:25:17PM -0700, Tony Lindgren wrote:
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 15:04]:
> > > 
> > > But what would be in musb_default_set_mode()? Currently only am35x,
> > > da8xx, dsps, and omap2430 glues implement _set_mode(), but they don't
> > > have any in common. Only omap2430 sets session bit in _set_mode(), no
> > > one else does so.
> > 
> > Well how about the following if no glue specific configuration of the
> > ID pin is possible?
> 
> ID pin configuration is required, either in sw or hw, for the controller
> otg state transition.
> 
> In my understanding, if ID pin is grounded, setting session bit make the
> controller transition to host mode; or if ID pin is float, setting
> session bit triggers srp request.

OK so let's rip out this code then. It does not seem to be needed for
enumerating devices at all, updated patch below.

> I think I don't understand what you are trying to solve by adding
> default set_mode() in core.

Naturally no need for this if we don't need this code at all :)

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 13 May 2016 07:59:35 -0700
Subject: [PATCH] usb: musb: Don't set d+ high before enable for 2430 glue
 layer

At least 2430 glue layer pulls d+ high on start up even if there are
no gadgets configured. This is bad at least for anything using a separate
battery charger chip as it can confuse the charger detection.

Let's fix the issue by removing the bogus glue layer code tinkering
with the SESSION bit. As pointed out Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> and
Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, the SESSION
bit just starts host mode if ID pin is grounded, and starts the
srp is ID pin is floating. So without the ID pin changing, it's
unable to force musb mode to anything. And just for starting a
host mode, things work fine without this code.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -122,16 +122,6 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 		musb_readb(musb->mregs, MUSB_DEVCTL));
 }
 
-static int omap2430_musb_set_mode(struct musb *musb, u8 musb_mode)
-{
-	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-
-	devctl |= MUSB_DEVCTL_SESSION;
-	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
-
-	return 0;
-}
