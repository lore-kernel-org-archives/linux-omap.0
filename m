From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: Correct audio input route & set mic bias
Date: Mon, 13 Jul 2015 23:57:45 -0700
Message-ID: <20150714065745.GE17550@atomide.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-2-git-send-email-arun@gumstix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433441299-18887-2-git-send-email-arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org> [150604 11:10]:
> From: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Audio-in was incorrectly routed to Line In. It should be Mic3L as per
> schematic.
> 
> Using mic-bias voltage at 2.0v (<0x1>) does not work for some reason. There
> is no voltage seen on micbias (R127). Mic-bias voltage of 2.5v (<0x2>) works.
> I see voltage of 2.475v across GND and micbias.
> 
> With these changes, I can record audio with a pair of proliferate TRRS earbuds.
> 
> Signed-off-by: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Can you please repost this with after checking From
and Signed-off-by?

Regards,

Tony

> ---
>  arch/arm/boot/dts/am335x-pepper.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index 0d35ab6..473d8ee 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -74,6 +74,7 @@
>  	audio_codec: tlv320aic3106@1b {
>  		compatible = "ti,tlv320aic3106";
>  		reg = <0x1b>;
> +		ai3x-micbias-vg = <0x2>;
>  	};
>  
>  	accel: lis331dlh@1d {
> @@ -153,7 +154,7 @@
>  	ti,audio-routing =
>  		"Headphone Jack",	"HPLOUT",
>  		"Headphone Jack",	"HPROUT",
> -		"LINE1L",		"Line In";
> +		"MIC3L",		"Mic3L Switch";
>  };
>  
>  &mcasp0 {
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
