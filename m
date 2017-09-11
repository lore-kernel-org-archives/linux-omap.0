From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/17] ARM: dts: Add missing properties for omap4 control
 modules
Date: Mon, 11 Sep 2017 16:08:58 -0500
Message-ID: <20170911210858.dktyljqayibatgbf@rob-hp-laptop>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170830151953.30856-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 30, 2017 at 08:19:39AM -0700, Tony Lindgren wrote:
> On omap4, we are missing several ti,hwmods properties and IO
> ranges for system control modules. These are needed by the SoC
> interconnect code.
> 
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
> 
> In order to add these, we need to move omap4_pmx_wkup to be a
> child of omap4_padconf_wkup.
> 
> On omap4 there are separate modules for control module and
> control module pads. For control module core, we have this
> already configured except for the missing ti,hwmods and reg
> entries.
> 
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/omap/ctrl.txt          |  2 ++
>  arch/arm/boot/dts/omap4.dtsi                       | 39 ++++++++++++++++------
>  2 files changed, 31 insertions(+), 10 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
