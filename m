From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
Date: Wed, 12 Nov 2014 13:23:41 -0800
Message-ID: <20141112212340.GL26481@atomide.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <20141110233630.GD31454@atomide.com>
 <CAAfyv34sPAa94dYM1QoHKEX+MN8NMnzE91HLhXW6MG1Yr=o8mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv34sPAa94dYM1QoHKEX+MN8NMnzE91HLhXW6MG1Yr=o8mQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [141112 13:04]:
> Hi Tony,
> 
> On Tue, Nov 11, 2014 at 12:36 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Marek Belisko <marek@goldelico.com> [141103 14:01]:
> >> gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypass and acbias).
> >> Add single pinmux entry and enable it.
> >>
> >> Signed-off-by: Marek Belisko <marek@goldelico.com>
> >> ---
> >>  arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> index e4d05f0..a456d37 100644
> >> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> >> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> @@ -118,6 +118,17 @@
> >>                       };
> >>               };
> >>       };
> >> +
> >> +     /* pinmux for devconf1 */
> >> +     control_devconf1: pinmux@480022d8 {
> >> +             compatible = "pinctrl-single";
> >> +             reg = <0x480022d8 4>;   /* single register */
> >> +             #address-cells = <1>;
> >> +             #size-cells = <0>;
> >> +             pinctrl-single,bit-per-mux;
> >> +             pinctrl-single,register-width = <32>;
> >> +             pinctrl-single,function-mask = <0xfc0bd5>;
> >> +     };
> >>  };
> >>
> >
> > The pinctrl-single entry should be in omap3.dtsi as the mux register is there
> > for all the omap3 devices, can you please update the patch for that?
> Ok I'll do. Just one question. I checked TRM for omap3430 and omap3630 and
> reserved bits in devconf1 are different. So keep function-mask for
> omap3430 in omap3.dtsi
> and redefine in omap36xx.dtsi (not sure if this will work in this
> way)? Or exist other way how to deal with that? Thanks.

Oh OK. Yes if they are different you should have the common entry in
omap3.dtsi and the SoC specific fields in omap34xx.dtsi and
omap36xx.dtsi. And please leave out the bit for configuring the
MPUFORCEWRNP.

Regards,

Tony
