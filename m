From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide
 powerhold property
Date: Wed, 23 Nov 2016 08:08:41 -0800
Message-ID: <20161123160841.GG4082@atomide.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
 <20161115000849.GD4082@atomide.com>
 <6ac3b28e-4891-83bc-a2f7-c903541acc18@ti.com>
 <20161123083327.GM10134@dell.home>
 <3a05871c-0512-8a84-4ac3-889c661c8638@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3a05871c-0512-8a84-4ac3-889c661c8638-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [161123 00:33]:
> On Wednesday 23 November 2016 02:03 PM, Lee Jones wrote:
> > On Wed, 23 Nov 2016, Keerthy wrote:
> > > On Tuesday 15 November 2016 05:38 AM, Tony Lindgren wrote:
> > > > * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [161109 21:10]:
> > > > > The PMICs have POWERHOLD set by default which prevents PMIC shutdown
> > > > > even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
> > > > > So to enable pmic power off this property lets one over ride the default
> > > > > value and enable pmic power off.
> > > > 
> > > > This should not cause merge conflicts so probably best to merge along
> > > > with the driver changes:
> > > > 
> > > > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > > 
> > > > If you guys want me to pick up this separately let me know.
> > > 
> > > Hi Lee Jones,
> > > 
> > > Are you planning to pull DT and Documentation patches as well?
> > 
> > No need.  They can be safely applied to their own subsystems.
> 
> Okay. Thanks for the response.
> 
> Tony,
> 
> Hope you can pull the DT patches.

Applying both into omap-for-v4.10/dt thanks. Please send dts changes
seprately next time if there are no dependencies. This leaves out
the second guessing who should apply what.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
