From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] ARM: dts: Add generic ti, sysc compatible in
 addition to the custom ones
Date: Sat, 16 Dec 2017 12:34:14 -0600
Message-ID: <20171216183414.24ycqj7q2beehiiq@rob-hp-laptop>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171215180900.3243-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 15, 2017 at 10:08:53AM -0800, Tony Lindgren wrote:
> Otherwise we cannot use generic OF_DEV_AUXDATA match without listing
> all the compatibles separately for OF_DEV_AUXDATA. Let's also update the
> binding accordingly.

Your subject has a space in "ti,sysc".

> Let's also fix omap4.dtsi to use "ti,sysc-omap4-sr" compatible as we
> have documented in the binding. This was not noticed earlier as we're
> still probing SmartReflex driver with platform data.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
>  arch/arm/boot/dts/dra7.dtsi                       |  4 ++--
>  arch/arm/boot/dts/omap4.dtsi                      | 20 ++++++++++----------
>  3 files changed, 13 insertions(+), 12 deletions(-)

Otherwise,

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
