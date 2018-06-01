From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
Date: Fri, 1 Jun 2018 07:26:13 -0700
Message-ID: <20180601142613.GU5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
 <20180531040350.GA25132@rob-hp-laptop>
 <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
 <678ef467-a235-91db-8bae-f249ad98eac8@ti.com>
 <d7532c7a-d2ae-5cbf-cfd0-c347b975ed6b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7532c7a-d2ae-5cbf-cfd0-c347b975ed6b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180601 06:49]:
> Hi,
> 
> On Thursday 31 May 2018 06:59 PM, Tero Kristo wrote:
> > On 31/05/18 13:14, Faiz Abbas wrote:
> >> Hi,
> >>
> >> On Thursday 31 May 2018 09:33 AM, Rob Herring wrote:
> >>> On Wed, May 30, 2018 at 07:41:30PM +0530, Faiz Abbas wrote:
> >>>> Add clkctrl data for the m_can clocks and register it within the
> >> ...
> >>>>   diff --git a/include/dt-bindings/clock/dra7.h
> >>>> b/include/dt-bindings/clock/dra7.h
> >>>> index 5e1061b15aed..d7549c57cac3 100644
> >>>> --- a/include/dt-bindings/clock/dra7.h
> >>>> +++ b/include/dt-bindings/clock/dra7.h
> >>>> @@ -168,5 +168,6 @@
> >>>>   #define DRA7_COUNTER_32K_CLKCTRL    DRA7_CLKCTRL_INDEX(0x50)
> >>>>   #define DRA7_UART10_CLKCTRL    DRA7_CLKCTRL_INDEX(0x80)
> >>>>   #define DRA7_DCAN1_CLKCTRL    DRA7_CLKCTRL_INDEX(0x88)
> >>>> +#define DRA7_ADC_CLKCTRL    DRA7_CLKCTRL_INDEX(0xa0)
> >>>
> >>> ADC and mcan are the same thing?
> >>>
> >>
> >> The register to control MCAN clocks is called ADC_CLKCTRL, Yes.
> > 
> > Is there any reason for this or is that just a documentation bug?
> > 
> 
> Looks like they meant to have an ADC in dra74 or dra72 but decided
> against it and then many years later used the same registers for MCAN
> instead. You can see ADC_CLKCTRL exists in dra72 TRM but is explicitly
> disabled.
> 
> http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf pg:1524

How about make add also something like to dra7.h:

#define DRA7_MCAN_CLKCTRL DRA7_ADC_CLKCTRL

And you can add a comment to the dts file to avoid people
getting confused with this constantly.

Regards,

Tony
