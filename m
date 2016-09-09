From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 9 Sep 2016 13:08:03 -0700
Message-ID: <20160909200803.4cngkfhgkki4e7o3@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <1946895.vi37Pmm05X@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1946895.vi37Pmm05X@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160909 12:27]:
> Hi Andreas,
> 
> Thank you for the patch.
> 
> On Wednesday 03 Aug 2016 17:38:51 Andreas Kemnade wrote:
> > The code assumes that omap2430_musb_enable() and
> > omap2430_musb_disable() are called in a balanced way.
> > That fact is broken by the fact that musb_init_controller() calls
> > musb_platform_disable() to switch from unknown state to off state
> > on initialisation.
> > 
> > That means that phy_power_off() is called first so that
> > phy->power_count gets -1 and the phy is not enabled on phy_power_on().
> > So when usb gadget is started the phy is not powered on.
> > Depending on the phy used that caused various problems.
> > Besides of causing usb problems, that can also have side effects.
> > 
> > In the case of using the phy_twl4030, that prevents also charging
> > the battery via usb (using twl4030_charger) and so makes further
> > kernel debugging hard.
> > The problem was seen with 4.7 on an openphoenux gta04. It has a DM3730
> > SoC and a TPS65950 companion.  phy->power never became 1
> > and so the usb did get powered on.
> > 
> > The patch prevents phy_power_off() from being called when
> > it is already off.
> > 
> > Signed-off-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> 
> This fixes USB gadget operation on the Panda board.
> 
> Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling for 2430 
> glue layer")
> Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

This patch has a side effect of fixing the issue by breaking PM
runtime, not a good fix as discussed.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
