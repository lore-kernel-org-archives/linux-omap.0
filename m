From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Documentation: dt: Update ti,emif bindings
Date: Fri, 19 May 2017 20:45:54 -0500
Message-ID: <20170520014554.qisnvr27542n5p7f@rob-hp-laptop>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-2-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170519175708.6070-2-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 19, 2017 at 12:57:07PM -0500, Dave Gerlach wrote:
> Update the Texas Instruments EMIF binding document to include the device
> tree bindings for ti,emif-am3352 and ti,emif-am4372 which are used by
> the ti-emif-sram driver to provide low-level PM functionality.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/memory-controllers/ti/emif.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

I acked v1. Please add acks when posting new versions.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
