From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Wed, 22 Mar 2017 10:22:35 -0700
Message-ID: <20170322172235.GE10760@atomide.com>
References: <20170317022152.21427-1-tony@atomide.com>
 <20170322021514.ewipilqbfm2cwua6@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322021514.ewipilqbfm2cwua6@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170321 19:17]:
> Hi,
> 
> On Thu, Mar 16, 2017 at 07:21:52PM -0700, Tony Lindgren wrote:
> > The custom CPCAP PMIC used on Motorola phones such as Droid 4 has a
> > USB battery charger. It can optionally also have a companion chip that
> > is used for wireless charging.
> > 
> > The charger on CPCAP also can feed VBUS for the USB host mode. This
> > can be handled by the existing kernel phy_companion interface.
> > 
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> > Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> Driver looks ok and works for me, but values are not scaled
> correctly. The power-supply subsystem exposes values in microamps
> and microvolt. IIO provides values in millivolt/milliamps instead,
> so it should be scaled with 1000.

Oh OK, will repost. There will also be a minor change for using
the processed IIO values instead of the scaled values when I update
the ADC driver.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
