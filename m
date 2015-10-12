From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [REPOST PATCH 1/4] ARM: dts: DRA7: Add dsp1_system syscon node
Date: Mon, 12 Oct 2015 15:55:03 -0700
Message-ID: <20151012225502.GM23801@atomide.com>
References: <1443828205-18706-1-git-send-email-s-anna@ti.com>
 <1443828205-18706-2-git-send-email-s-anna@ti.com>
 <20151012214304.GD23801@atomide.com>
 <561C351B.3060307@ti.com>
 <20151012225001.GK23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151012225001.GK23801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151012 15:57]:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [151012 15:37]:
> > Hi Tony,
> > 
> > On 10/12/2015 04:43 PM, Tony Lindgren wrote:
> > > * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [151002 16:27]:
> > >> The DSP_SYSTEM sub-module is a dedicated system control logic
> > >> module present within a DRA7 DSP processor sub-system. This
> > >> module is responsible for power management, clock generation
> > >> and connection to the device PRCM module.
> > >>
> > >> Add a syscon node for this module for the DSP1 processor
> > >> sub-system. This is added as a syscon node as it is a common
> > >> configuration module that can be used by the different IOMMU
> > >> instances and the corresponding remoteproc device.
> > >>
> > >> The node is added to the common dra7.dtsi file, as the DSP1
> > >> processor sub-system is mostly common across all the variants
> > >> of the DRA7 SoC family.
> > >>
> > >> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> > >> ---
> > >>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
> > >>  1 file changed, 5 insertions(+)
> > >>
> > >> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> > >> index e289c706d27d..62055094e8d5 100644
> > >> --- a/arch/arm/boot/dts/dra7.dtsi
> > >> +++ b/arch/arm/boot/dts/dra7.dtsi
> > >> @@ -292,6 +292,11 @@
> > >>  				#thermal-sensor-cells = <1>;
> > >>  		};
> > >>  
> > >> +		dsp1_system: dsp_system@40d00000 {
> > >> +			compatible = "syscon";
> > >> +			reg = <0x40d00000 0x100>;
> > >> +		};
> > >> +
> > >>  		sdma: dma-controller@4a056000 {
> > >>  			compatible = "ti,omap4430-sdma";
> > >>  			reg = <0x4a056000 0x1000>;
> > > 
> > > Hmm so why would you want to set up a complete device as a syscon
> > > mapping rather than just doing ioremap on it?
> > > 
> > > What drivers will be sharing access to these registers?
> > 
> > Two different instances of the MMU for now, both get probed
> > independently. But there are other registers which a remoteproc driver
> > will mostly be interested in (like DSP_SYS_STAT for knowing the C66x
> > idle/active status).
> 
> OK makes sense to me then.

And applying these into omap-for-v4.4/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
