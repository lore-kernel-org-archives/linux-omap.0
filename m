From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Sat, 4 Mar 2017 08:26:55 -0800
Message-ID: <20170304162655.GZ20572@atomide.com>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170302013707.GK20572@atomide.com>
 <20170302014910.GM20572@atomide.com>
 <20170303110144.seoxa6xwago7q5ir@earth>
 <20170303162824.GW20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170303162824.GW20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170303 08:31]:
> * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170303 03:03]:
> > On Wed, Mar 01, 2017 at 05:49:11PM -0800, Tony Lindgren wrote:
> > > Some of the command mode LCD patches could be sent out too, and
> > > if the timing patch is OK then we can configure the LCD in the dts
> > > too. Have you had a chance to look at those related to what all I
> > > broke for n950?
> > 
> > I took your patchset and fixed it for N950. The main problem was,
> > that you dropped the fifo size update, which is required for OMAP3
> > (HW bug). Here is a branch based on recent master branch from
> > torvalds. I had a quick test with droid4 and dmesg still looked fine,
> > but I did not have the lm3532 patches in that branch and nothing is
> > visible without display backlight. Can you check if the branch works
> > for you on D4?
> 
> OK good to hear you figured it out. Yeah I tried to cut down the
> changes to minimum to get some idea what's going on and noticed I did
> not need the fifo changes for droid 4. I'll take a look later on today
> or over the weekend.

I tested your branch and those patches work just fine on droid 4.

I did not test the fifo patch as it's missing something compiles
as loadable modules:

ERROR: "dispc_ovl_set_fifo_threshold" [drivers/gpu/drm/omapdrm/omapdrm.ko] undefined!
ERROR: "dispc_ovl_compute_fifo_thresholds" [drivers/gpu/drm/omapdrm/omapdrm.ko] undefined!

Probably just EXPORT_SYMBOL missing?

Anyways, yeah I guess that set is pretty much ready to be sent for
review if you feel like sending it. Or let me know if you want me to
send it.

Regards,

Tony


> > http://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/log/?h=n950-display-tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
