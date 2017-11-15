From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/5] DT: misc: w2sg0004: add bindings documentation
 (GPS module with serdev UART)
Date: Wed, 15 Nov 2017 14:08:08 -0600
Message-ID: <20171115200808.2nkldpoybhv5x6a5@rob-hp-laptop>
References: <cover.1510520397.git.hns@goldelico.com>
 <069ce12d5609c4e968f2a468e6c58a57f59f3ffb.1510520397.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <069ce12d5609c4e968f2a468e6c58a57f59f3ffb.1510520397.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 12, 2017 at 09:59:55PM +0100, H. Nikolaus Schaller wrote:
> add bindings documentation for Wi2Wi W2SG00x4 GPS module

Add ... module.

> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    | 24 ++++++++++++++++++++++

The path doesn't have to match the kernel. Use bindings/gps/...

>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> new file mode 100644
> index 000000000000..ccec9361a1a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> @@ -0,0 +1,24 @@
> +Wi2Wi GPS module connected through UART
> +
> +Should be a subnode of the SoC UART it is connected to (serdev).

Could be connected to any kind of UART and serdev is a Linuxism.

With those fixed,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
