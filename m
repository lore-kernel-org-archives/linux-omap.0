From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5
 GHz SoC operation
Date: Mon, 6 Feb 2017 15:24:50 +0100
Message-ID: <20170206152450.3739af18@jawa>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
        <1486135491-14223-2-git-send-email-lukma@denx.de>
        <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Dave,

> On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
> > The "opp_high" property brings support for 1.5 GHz CPU frequency
> > for TI's am57xx line of processors.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/dra7.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> 
> This can't be blindly enabled for all am57xx SoCs, there is a
> forthcoming ti-cpufreq [1] driver that is needed that will decided
> which OPPs can and cannot be enabled for the specific variant in use.

Do you know if there is ongoing work on using Avs0 voltage (encoded in
efuse) to control the per SoC PMIC voltage value when switching to
opp_high (1.5 GHz)?


> 
> Regards,
> Dave
> 
> [1] http://www.spinics.net/lists/devicetree/msg158967.html
> 
> > diff --git a/arch/arm/boot/dts/dra7.dtsi
> > b/arch/arm/boot/dts/dra7.dtsi index a860a56..5e678cd 100644
> > --- a/arch/arm/boot/dts/dra7.dtsi
> > +++ b/arch/arm/boot/dts/dra7.dtsi
> > @@ -108,6 +108,11 @@
> >  			opp-hz = /bits/ 64 <1176000000>;
> >  			opp-microvolt = <1160000 885000 1160000>;
> >  		};
> > +
> > +		opp_high@1500000000 {
> > +			opp-hz = /bits/ 64 <1500000000>;
> > +			opp-microvolt = <1210000 950000 1250000>;
> > +		};
> >  	};
> >
> >  	/*
> >
> 




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
