From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v3 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Fri, 4 Mar 2016 06:23:45 -0600
Message-ID: <56D97E51.5050602@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-3-git-send-email-fcooper@ti.com>
 <20160301181109.GB13417@atomide.com>
 <alpine.DEB.2.02.1603011858510.14948@utopia.booyaka.com>
 <20160301205043.GA4469@atomide.com> <56D71331.5020702@ti.com>
 <56D8EDF4.9070904@ti.com>
 <alpine.DEB.2.02.1603040553010.3980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1603040553010.3980@utopia.booyaka.com>
Sender: linux-clk-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 03/04/2016 12:25 AM, Paul Walmsley wrote:
> On Thu, 3 Mar 2016, Franklin S Cooper Jr. wrote:
>
>> So I looked into this more and verified that the eCAP and
>> ePWM doesn't have their own unique clock. The PWMSS receives
>> a clock L4PER2_L3_GICLK/2 which is passed through to its
>> sub-devices (ePWM, eCAP and eQEP). The PWMSS is responsible
>> for handling its clock internally while the subdevices have
>> no role in managing this clock. So this explains why we have
>> hwmod entries for PWMSS and why we are planning on removing
>> it from the various subdevices.
> It's not whether they have their own unique clock, but whether the 
> submodules have OCP integration registers, speak the idle/standby 
> protocols, have direct L3/L4 ports, etc.

Sorry from a hwmod perspective your right. I initially
thought my response about the clocks were related to hwmod
but I see why I was off after reading a bit more on hwmod.
>> Since ePWM, eCAP and eQEP are subdevices of PWMSS they
>> shouldn't have their own concept of their "own" clock. The
>> ePWM , eCAP and eQEP clocks are all shared and managed by
>> their parent PWMSS. Once the PWMSS is enabled and has its
>> clock running then ePWM, eCAP and eQEP from their main clock
>> perspective have everything they need.
>>
>> So my plan is to strip all references of clocks (including
>> hwmod entries) for ePWM, eCAP and eQEP. The devm_clk_get
>> calls made in the ePWM and eCAP will simply point to their
>> parent's dev (PWMSS). I did a couple of quick test using
>> this approach and it works. I have more testing to do but if
>> that checks out are you ok with the above approach?
> I don't know if that should be done or not.  I haven't stared at the code 
> yet, but based on your description, it sounds to me that it probably 
> shouldn't be done.  In any case, it's not what I meant...

Your right my response did miss your initial point. But what
I'm proposing sounds like exactly what you were suggesting.
I think we both agree that hwmod entries for ePWM, eCAP and
eQEP should be removed. Not just for dra7 but also for
am335x and am437x as separate patches.

My comment about devm_clk_get was based on the fact that I
don't believe eCAP, ePWM and eQEP should have their own
clock defined even within DT. Instead they can just
reference the clk provided by pwmss (its parent) which in
hardware is the clock that is directly passed to the
sub-devices. The only reason those drivers need a reference
to that clk is to get its rate once during probe.

I plan on doing a bit more testing and I can shoot an
updated v4. I believe it will address all of your comments
and you will hopefully get a better understanding of the
minor change I plan on making.
>
>> Also I'm not sure how simple-bus fits in this picture. The
>> eCAP, eQEP and ePWM are all separate devices. The only thing
>> that they share is a single clock from their parent. So it
>> doesn't seem like the right approach. I'm basing this on the
>> info in this thread
>> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg27979.html
>> that talks about the usage of simple-bus. So if its outdated
>> or I"m misinterpreting it incorrectly please let me know.
> What I meant is that the ECAP*, EQEP*, EHRPWM* devices don't need to be 
> registered through the hwmod code, due to the fact that they don't have 
> the integration mentioned above.  Instead, I think those three subdevices 
> should be listed as child nodes of epwmss* in the DT.
>
> Looking at the DT data from Vignesh, it looks like he's already got 
> ehrpwm1 as a child node of the epwmss1:
>
> +               epwmss1: epwmss@48440000 {
> +                       compatible = "ti,dra7xx-pwmss", "ti,am33xx-pwmss";
> +                       reg = <0x48440000 0x30>;
> +                       ti,hwmods = "epwmss1";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       status = "disabled";
> +                       ranges = <0x48440100  0x48440100  0x80   /* ECAP */
> +                                 0x48440180  0x48440180  0x80   /* EQEP */
> +                                 0x48440200  0x48440200  0x80>; /* EHRPWM */
> +
> +                       ehrpwm1: ehrpwm@48440200 {
> +                               compatible = "ti,dra7xx-ehrpwm",
> +                                            "ti,am33xx-ehrpwm";
> +                               #pwm-cells = <3>;
> +                               reg = <0x48440200 0x80>;
> +                               ti,hwmods = "ehrpwm1";
>
> So, drop the above line, since the subdevices don't have corresponding 
> hwmods any more.

Right
>
> +                               status = "disabled";
> +                       };
>
> Then, here, you'd add nodes similar to ehrpwm1 for ecap1 and eqep1.  I 
> can't remember at the moment if adding "simple-bus" to the epwmss1 string 
> would be sufficient to register the subdevices after the epwmss1 is 
> probed.  If so, maybe that's all you need.
>
> +               };
>
> Then repeat for epwmss0, epwmss2.

As you mentioned pwmss is the parent node in the DT while
ecap and epwm are child nodes. These child nodes must be
probed only after their parent node has been probed and the
parent clock is running. The pwm-tipwmss.c already calls
of_platform_populate(node, NULL, NULL, &pdev->dev); as the
very last step of its probe call. So what you want to happen
is already happening in the driver. So I don't believe
simple-bus is needed.
>
>
> - Paul

