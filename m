From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5
 GHz SoC operation
Date: Sat, 4 Feb 2017 06:30:30 +0100
Message-ID: <20170204063030.3ba736f9@jawa>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
        <1486135491-14223-2-git-send-email-lukma@denx.de>
        <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
        <20170204002150.707b231d@jawa>
        <79e08896-895e-4996-8402-832328b4f7d8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79e08896-895e-4996-8402-832328b4f7d8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

> On 02/03/2017 05:21 PM, Lukasz Majewski wrote:
> > Hi Dave,
> >
> > Thanks for sharing the knowledge :-)
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
> >> This can't be blindly enabled for all am57xx SoCs,
> >
> > Yes, I'm fully aware of AVS, which uses fuses and SoC silicon
> > revision to assess if frequency can be enabled.
> >
> > Example from my playground:
> >
> > - AM5728 works with 1.5 GHz enabled
> >
> > - AM5718 hangs when I try to enable 1.5 GHz frequency
> >
> >
> >> there is a
> >> forthcoming ti-cpufreq [1] driver
> >
> > I've backported and tested this code on v4.9 vanilla. It works :-)
> >
> >> that is needed that will decided
> >> which OPPs can and cannot be enabled for the specific variant in
> >> use.
> >
> > I do have a question:
> >
> > Do you know the correct opp-supported-hw value for 1.5 GHz on AM57x8
> > SoC?
> > In TI's SDK Linux (v4.4): opp-supported-hw = <0xFF 0x04>; but this
> > seems to be always enabled (and not taking silicon revision and
> > efuse into account).
> 
> There is a TISDK 4.9 being built up as well (we typically do let the 
> driver soak for a test cycle prior to posting it upstream) but if it 
> is of interest.. it should match the version Dave posted upstream..
> 
> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.9.y/arch/arm/boot/dts/dra7.dtsi#line100

This opp_table0 DTS node definition is different than the one sent to ML
by Dave (e.g. opp-microvolt has different definition).

> 
> > For my use case it would be best to see what data should prevent my
> > AM5718 from 1.5 GHz OPP.
> >
> > In other words I need to be 100% sure that my silicon SoC version
> > doesn't support the 1.5 GHz frequency.
> >
> 
> look at dra7_efuse_xlate which does a speed grade decode of the
> speeds permitted.. a value of 15 or 23 should permit 1.5GHz. those
> are common for DRA7/AM57 SoCs.

Ok, I've checked this and both SoCs have value 23, so they should
support 1.5 GHz operation. Hence, the AM5718 should not hang.

> 
> If the efuses seem set for 1.5GHz, the chip should be capable of 
> 1.5GHz, i'd start suspecting regulators, slew rates and the like.

Then I do need to examine them.

> 
> http://www.ti.com/lit/pdf/spruhz7
> rev d: page 371 -> 23 (0x17) = X speed designator Refer to device DM 
> for supported speed grades for a given device, and the definition for 
> supported speed grades.
> So, if you go to 
> http://www.ti.com/product/AM5718/datasheet/specifications#SWPS043-7245x 
> -> you will see the "X" designator in AM5718xxX which does support 23 
> and 1.5GHz.

Yes, correct.

> 
> 
> Now, if you did get one of the pre-production samples,

Is there any prod_id (or any other register value), which indicates the
production sample?

> it is possible 
> to have efuses slightly messed up on very initial samples - at least 
> internally, we have had them replaced and none of those samples
> should have exited TI.. but mistakes might happen.. if the efuse
> value does not meet the speed grade in documentation, then, please
> contact TI FAE your company works with and let them know for what to
> do alternatively, you can also file it on e2e.ti.com for further
> support.
> 

Thanks for support.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
