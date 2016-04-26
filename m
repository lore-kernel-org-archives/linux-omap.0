From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3: Fix ISP syscon register offset
Date: Tue, 26 Apr 2016 10:12:47 -0700
Message-ID: <20160426171246.GE5995@atomide.com>
References: <1460787628-17316-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5719A9E3.1000902@gmail.com>
 <20160422131626.GA7534@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160422131626.GA7534@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160422 06:17]:
> Hi,
> 
> On Fri, Apr 22, 2016 at 07:34:43AM +0300, Ivaylo Dimitrov wrote:
> > On 16.04.2016 09:20, Ivaylo Dimitrov wrote:
> > >According to the TRM, SCM CONTROL_CSIRXFE register is on offset 0x6c
> > >
> > >Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >---
> > >  arch/arm/boot/dts/omap34xx.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> > >index 5cdba1f..e446562 100644
> > >--- a/arch/arm/boot/dts/omap34xx.dtsi
> > >+++ b/arch/arm/boot/dts/omap34xx.dtsi
> > >@@ -46,7 +46,7 @@
> > >  			       0x480bd800 0x017c>;
> > >  			interrupts = <24>;
> > >  			iommus = <&mmu_isp>;
> > >-			syscon = <&scm_conf 0xdc>;
> > >+			syscon = <&scm_conf 0x6c>;
> > >  			ti,phy-type = <OMAP3ISP_PHY_TYPE_COMPLEX_IO>;
> > >  			#clock-cells = <1>;
> > >  			ports {
> > >
> 
> You may want to add the hint, that 0xdc (the old, wrong "offset")
> represents the last few bits of the register address. I guess
> somebody didn't notice, that scm_conf does not start at a register
> address ending with 00 (like most other modules).
> 
> Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applying into omap-for-v4.6/fixes-rc5 thanks.

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
