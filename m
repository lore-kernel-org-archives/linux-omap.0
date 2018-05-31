From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
Date: Thu, 31 May 2018 06:41:09 -0700
Message-ID: <20180531134109.GJ5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <20180531040638.GA26751@rob-hp-laptop>
 <be0fd711-c44b-dbe2-648f-08aa88c7aec4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <be0fd711-c44b-dbe2-648f-08aa88c7aec4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180531 11:27]:
> On Thursday 31 May 2018 09:36 AM, Rob Herring wrote:
> > On Wed, May 30, 2018 at 07:41:32PM +0530, Faiz Abbas wrote:
> >> --- a/arch/arm/boot/dts/dra76x.dtsi
> >> +++ b/arch/arm/boot/dts/dra76x.dtsi
> >> @@ -11,6 +11,25 @@
> >>  / {
> >>  	compatible = "ti,dra762", "ti,dra7";
> >>  
> >> +	ocp {
> >> +
> >> +		target-module@0x42c00000 {
> > 
> > Build your dtb with W=1 and fix warnings you add (drop '0x').
> 
> Sure, Will fix this.
> > 
> > This is a CAN bus controller? If so, then use 'can' for node name.
> 
> Yes but I am using m_can along the lines of dcan in other boards (For
> example, see arch/arm/boot/dts/am33xx.dtsi:1046). Are you saying all CAN
> controllers should only be called can?

The module should be target-module@42c00000 and the child(ren)
can@1a00 or mcan@1a00 if mcan is different from can.

Regards,

Tony
