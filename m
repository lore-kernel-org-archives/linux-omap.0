From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA76-EVM: Set powerhold property for tps65917
Date: Thu, 26 Oct 2017 07:17:08 -0700
Message-ID: <20171026141707.GE21504@atomide.com>
References: <1508834648-28715-1-git-send-email-j-keerthy@ti.com>
 <20171025165219.GO4394@atomide.com>
 <30907da7-a80c-4718-dd9a-17cb22669eb5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <30907da7-a80c-4718-dd9a-17cb22669eb5-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [171025 23:31]:
> 
> 
> On Wednesday 25 October 2017 10:22 PM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [171024 01:46]:
> >> Set powerhold property for tps65917
> >>
> >> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> > 
> > Is this safe to merge separately before the driver changes?
> 
> This needs to wait till [1] is merged. I should have mentioned this.
> 
> I will ping on this as soon as the dependent patch is merged.

OK thanks will untag this patch from my inbox for now then.

Regards,

Tony

> [1] https://marc.info/?l=linux-omap&m=150883331614239&w=2
> 
> Thanks,
> Keerthy
> 
> > 
> > Regards,
> > 
> > Tony
> > 
> >> ---
> >>  arch/arm/boot/dts/dra76-evm.dts | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
> >> index b024a65..f64aab4 100644
> >> --- a/arch/arm/boot/dts/dra76-evm.dts
> >> +++ b/arch/arm/boot/dts/dra76-evm.dts
> >> @@ -148,6 +148,7 @@
> >>  		compatible = "ti,tps65917";
> >>  		reg = <0x58>;
> >>  		ti,system-power-controller;
> >> +		ti,palmas-override-powerhold;
> >>  		interrupt-controller;
> >>  		#interrupt-cells = <2>;
> >>  
> >> -- 
> >> 1.9.1
> >>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
