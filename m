From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH resent v3 3/3] ASoC: omap-abe-twl6040: fix typo in
 bindings documentation
Date: Wed, 26 Oct 2016 10:59:29 +0300
Message-ID: <79d574c7-f3ed-5d54-5807-698115d999bd@ti.com>
References: <cover.1477417090.git.hns@goldelico.com>
 <f2ade237f55685f4fdb2aaa127995f3ccb986bb3.1477417090.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f2ade237f55685f4fdb2aaa127995f3ccb986bb3.1477417090.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/25/16 20:38, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>

Acked-by: Peter Ujfalusi <perter.ujfalusi-l0cyMroinI0@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
> index fd40c85..462b04e8 100644
> --- a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
> +++ b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
> @@ -12,7 +12,7 @@ Required properties:
>  
>  Optional properties:
>  - ti,dmic: phandle for the OMAP dmic node if the machine have it connected
> -- ti,jack_detection: Need to be present if the board capable to detect jack
> +- ti,jack-detection: Need to be present if the board capable to detect jack
>    insertion, removal.
>  
>  Available audio endpoints for the audio-routing table:
> 


-- 
Péter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
