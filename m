From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Fix smartreflex compatible for omap3 shared
 mpu-iva instance
Date: Fri, 19 Jan 2018 14:19:43 -0600
Message-ID: <20180119201943.yuq5tbwf34dii7q3@rob-hp-laptop>
References: <20180110181415.29197-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180110181415.29197-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 10, 2018 at 10:14:15AM -0800, Tony Lindgren wrote:
> The smartreflex instance for mpu and iva is shared. Let's fix this as I've
> already gotten confused myself few times wondering where the mpu instance
> is. Note that we are still probing the driver using platform data so this
> change is safe to do.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/ti-smartreflex.txt | 2 +-
>  arch/arm/boot/dts/omap3.dtsi                               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
