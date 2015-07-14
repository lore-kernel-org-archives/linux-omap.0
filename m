From: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] arm:DTS Correct audio input route & set mic bias
Date: Tue, 14 Jul 2015 11:38:13 -0700
Message-ID: <CAK8F28=0ttDiyzNKkYog7Pe_qWXGSRXkE_vOZ1QNpQiwbY0Vxw@mail.gmail.com>
References: <1436897844-6908-1-git-send-email-adam.yh.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436897844-6908-1-git-send-email-adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 14, 2015 at 11:17 AM, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Audio-in was incorrectly routed to Line In. It should be Mic3L as per
> schematic.
>
> Using mic-bias voltage at 2.0v (<0x1>) does not work for some reason. There
> is no voltage seen on micbias (R127). Mic-bias voltage of 2.5v (<0x2>) works.
> I see voltage of 2.475v across GND and micbias.
>
> With these changes, I can record audio with a pair of proliferate TRRS earbuds.
>
> Signed-off-by: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-pepper.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index d627dc6..73b4cc3 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -74,6 +74,7 @@
>         audio_codec: tlv320aic3106@1b {
>                 compatible = "ti,tlv320aic3106";
>                 reg = <0x1b>;
> +               ai3x-micbias-vg = <0x2>;
>         };
>
>         accel: lis331dlh@1d {
> @@ -152,7 +153,7 @@
>         ti,audio-routing =
>                 "Headphone Jack",       "HPLOUT",
>                 "Headphone Jack",       "HPROUT",
> -               "LINE1L",               "Line In";
> +               "MIC3L",                "Mic3L Switch";
>  };
>
>  &mcasp0 {
Note, this is getting resent to correct the sign-offs as requested
https://lkml.org/lkml/2015/7/14/56
Acked-by: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
