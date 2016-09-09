From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 9 Sep 2016 14:33:42 -0700
Message-ID: <20160909213341.m2tmrvws5ffomnho@atomide.com>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
 <1946895.vi37Pmm05X@avalon>
 <20160909200803.4cngkfhgkki4e7o3@atomide.com>
 <1538976.gm2HNISj8k@avalon>
 <20160909205103.sqonsprxbb7i6zth@atomide.com>
 <20160909232206.70ee2558@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909232206.70ee2558@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [160909 14:22]:
> On Fri, 9 Sep 2016 13:51:04 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> > Well for the phy-twl4030-usb.c, AFAIK the right fix is to fix the PHY
> > driver as done in "[PATCH v2] phy-twl4030-usb: initialize
> > charging-related stuff via pm_runtime". I suspect something similar
> > is happening here also with the omap4 legacy phy.
> > 
> No, the fix is for making charging work independant of musb.
> Gadget is working because charging is enabled and enables all parts in
> the phy needed for it. And you can charge without musb (only musb_hdrc
> for the mailbox but not the omap2430 glue module).

Oh right.

> We have two independant things:
> 1. phy-twl4030-usb (and perhaps others) do not enable
>   the phy enough to allow charging on pm_runtime_get().
>   That is fixed by my phy-related patches.

OK

> 2. phy_power_off/on() in called in an unbalanced way if
>    it is called behind musb_platform_enable()/disable()
>    as it happens in omap2430.c. Two ways to fix it:
>    a) prevent phy_power_off()/on() to be called in
>       an unbalanced way in omap240.c
>    b) prevent musb_platform_enable()
> 	      musb_platform_disable() to be called in an
> 	      unbalanced way by fixing musb_core.c
> 
> Fixing 1. is enough on gta04 to fix charging and hide 2. enough to
> have gadget working for the most common usecases. (not using
> twl4030-charger would not work yet)
> But in the longer term 2. has to be fixed too.

Sounds like option 2b here is the real fix.

Regards,

Tony
