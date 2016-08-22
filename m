From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] Implement PM runtime for musb-core based on session
 bit
Date: Mon, 22 Aug 2016 07:25:02 -0700
Message-ID: <20160822142501.ofc53h4mq64ufvad@atomide.com>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
 <20160822072838.28928691@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160822072838.28928691@aktux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160821 22:29]:
> Hi,
> 
> On Thu, 18 Aug 2016 15:46:46 -0700
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > Hi all,
> > 
> > Here's a series of patches to simplify musb PM runtime support
> > further.
> > 
> > I finally figured out that we can get rid of most of the glue layer
> > specific workarounds by following the devctl session bit in musb core.
> > 
> > The series also adds PM runtime support to the musb dsps glue layer
> > for the PIO mode.
> > 
> > I've tested basic plugging of cables in peripheral and host mode
> > on omap3 and am335x using omap2plus_defconfig. Please test if you
> > can.
> > 
> Testing on GTA04 hardware (dm3730 + twl4030 as usb-phy), device mode,
> charging: it does not make things worse than it is without it. Same
> problems,

OK good to hear and thanks for testing.

> phy->power_count goes down to -1, so no gadget, no charging.
> Fixing that (I have some nearly-ready things in my queue) causes
> device mode and charging to work (as it does without
> this patch-series).

OK. I'll try to test that phy patch you sent today.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
