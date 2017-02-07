From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5
 GHz SoC operation
Date: Tue, 7 Feb 2017 05:27:30 +0100
Message-ID: <20170207052730.2192615e@jawa>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
        <1486135491-14223-2-git-send-email-lukma@denx.de>
        <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
        <20170206152450.3739af18@jawa>
        <58989547.9030002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58989547.9030002@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Dave,

> Hi,
> On 02/06/2017 08:24 AM, Lukasz Majewski wrote:
> > Hi Dave,
> > 
> >> On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
> >>> The "opp_high" property brings support for 1.5 GHz CPU frequency
> >>> for TI's am57xx line of processors.
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>> ---
> >>>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>
> >> This can't be blindly enabled for all am57xx SoCs, there is a
> >> forthcoming ti-cpufreq [1] driver that is needed that will decided
> >> which OPPs can and cannot be enabled for the specific variant in
> >> use.
> > 
> > Do you know if there is ongoing work on using Avs0 voltage (encoded
> > in efuse) to control the per SoC PMIC voltage value when switching
> > to opp_high (1.5 GHz)?
> 
> Yes, Viresh Kumar introduced multi-regulator support in the OPP core
> recently [1] which I wrote a test driver for here [2] which hooks
> into the OPP framework to do both ABB regulator scaling and also
> programs the AVS0 voltages.

Thanks for sharing this info.

> The current implementation I have cleaned
> up will depend on the ti-cpufreq driver so once that is merged I will
> send the AVS0 and ABB support driver upstream as well. 

The ti-cpufreq.c seems to be solid and working, so I hope that it will
be merged sooner than latter.

> If you are
> curious you can look at current internal implementation here [3].

I will try it.

> 
> Regards,
> Dave
> 
> [1] http://www.spinics.net/lists/devicetree/msg153212.html
> [2] https://www.spinics.net/lists/kernel/msg2384336.html
> [3]
> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.9.y/drivers/base/power/opp/ti-opp-supply.c
> 
> 
> > 
> > 
> >>
> >> Regards,
> >> Dave
> >>
> >> [1] http://www.spinics.net/lists/devicetree/msg158967.html
> >>
> >>> diff --git a/arch/arm/boot/dts/dra7.dtsi
> >>> b/arch/arm/boot/dts/dra7.dtsi index a860a56..5e678cd 100644
> >>> --- a/arch/arm/boot/dts/dra7.dtsi
> >>> +++ b/arch/arm/boot/dts/dra7.dtsi
> >>> @@ -108,6 +108,11 @@
> >>>  			opp-hz = /bits/ 64 <1176000000>;
> >>>  			opp-microvolt = <1160000 885000 1160000>;
> >>>  		};
> >>> +
> >>> +		opp_high@1500000000 {
> >>> +			opp-hz = /bits/ 64 <1500000000>;
> >>> +			opp-microvolt = <1210000 950000 1250000>;
> >>> +		};
> >>>  	};
> >>>
> >>>  	/*
> >>>
> >>
> > 
> > 
> > 
> > 
> > Best regards,
> > 
> > Lukasz Majewski
> > 
> > --
> > 
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:
> > wd@denx.de
> > 
> 




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
