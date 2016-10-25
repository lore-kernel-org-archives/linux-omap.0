From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dts: omap5: baord-common: enable twl6040 headset
 jack detection
Date: Tue, 25 Oct 2016 10:34:11 -0700
Message-ID: <20161025173411.36uop63p2wzv3gij@atomide.com>
References: <cover.1477414105.git.hns@goldelico.com>
 <7771a9fb3b9133fc361c87970444c1a3918891d0.1477414105.git.hns@goldelico.com>
 <105a8b87-69d0-19c7-8337-7d32fd6e997a@ti.com>
 <7F106936-5748-432F-B602-59B890D5396A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7F106936-5748-432F-B602-59B890D5396A-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [161025 10:20]:
> 
> > Am 25.10.2016 um 18:51 schrieb Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>:
> > 
> > On 10/25/2016 07:48 PM, H. Nikolaus Schaller wrote:
> >> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> >> ---
> >> arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> >> index b04adee..91456b4 100644
> >> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> >> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> >> @@ -124,6 +124,7 @@
> >> 		compatible = "ti,abe-twl6040";
> >> 		ti,model = "omap5-uevm";
> >> 
> >> +		ti,jack_detection;
> > 
> > ti,jack-detection
> 
> Hm. Looks as if we have found another bug:
> which one is correct?
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt#n15
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/omap/omap-abe-twl6040.c#n289
> 
> Should I add another patch?

We have parts of omap-abe-twl6040.txt, the driver and omap4-sdp.dts all
using ti,jack-detection. So omap-abe-twl6040.txt is wrong for the use
of ti,jack_detection.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
