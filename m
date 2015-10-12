From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Mon, 12 Oct 2015 15:23:01 -0700
Message-ID: <20151012222301.GI23801@atomide.com>
References: <1442323985-29939-1-git-send-email-kishon@ti.com>
 <1442323985-29939-2-git-send-email-kishon@ti.com>
 <20151012212149.GZ23801@atomide.com>
 <561C2A1B.3000201@ti.com>
 <20151012220322.GF23801@atomide.com>
 <561C2E93.3020809@ti.com>
 <20151012221255.GG23801@atomide.com>
 <561C31B7.3060604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561C31B7.3060604-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [151012 15:23]:
> Hi,
> 
> On Tuesday 13 October 2015 03:42 AM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [151012 15:09]:
> >> Hi,
> >>
> >> On Tuesday 13 October 2015 03:33 AM, Tony Lindgren wrote:
> >>> * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [151012 14:50]:
> >>>> Hi Tony,
> >>>>
> >>>> On Tuesday 13 October 2015 02:51 AM, Tony Lindgren wrote:
> >>>>> * Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150915 06:37]:
> >>>>>> Add new device tree node for the control module register space where
> >>>>>> PCIe registers are present.
> >>>>>>
> >>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >>>>>> ---
> >>>>>>  arch/arm/boot/dts/dra7.dtsi |    5 +++++
> >>>>>>  1 file changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> >>>>>> index 5d65db9..0769b5d 100644
> >>>>>> --- a/arch/arm/boot/dts/dra7.dtsi
> >>>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
> >>>>>> @@ -154,6 +154,11 @@
> >>>>>>  					compatible = "syscon";
> >>>>>>  					reg = <0x1c04 0x0020>;
> >>>>>>  				};
> >>>>>> +
> >>>>>> +				scm_conf_pcie: tisyscon@1c24 {
> >>>>>> +					compatible = "syscon";
> >>>>>> +					reg = <0x1c24 0x0024>;
> >>>>>> +				};
> >>>>>>  			};
> >>>>>>  
> >>>>>>  			cm_core_aon: cm_core_aon@5000 {
> >>>>>
> >>>>>
> >>>>> Why don't you just extend the existing scm_conf1 area? This is not all pcie
> >>>>> specific for scm_conf_pcie, at least for PLLEN_CONTROL, RMII_CLK_SETTING
> >>>>> and MUXSEL_32K_CLKIN.
> >>>>
> >>>> scm_conf_pcie has only PCIe registers (it starts at 0x4A003C24).
> >>>> PLLEN_CONTROL and others are at 0x4A003C14 as per
> >>>> DRA75x_DRA74x_SR1.1_NDA_TRM_vW.
> >>>
> >>> Oh sorry I guess I was looking at a wrong address then.
> >>>
> >>>> Since PCIe itself has a bunch of registers for itself, thought of
> >>>> creating a separate dt node. But I can extend scm_conf1 area.
> >>>
> >>> Why not just ioremap them then? Do these need to be shared with
> >>> some other driver?
> >>
> >> yeah, some are used by PCIe controller driver and some are used by PCIe
> >> PHY driver.
> > 
> > OK makes sense to me then.
> 
> Cool.
> 
> Btw the driver modifications has not yet been merged, so don't merge
> these yet. I'll repost these once the driver is merged.

OK thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
