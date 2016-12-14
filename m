From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Tue, 13 Dec 2016 16:43:34 -0800
Message-ID: <20161214004334.GU4920@atomide.com>
References: <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
 <148156710975.37646.2957511113527634913@resonance>
 <20161213004914.GM5423@codeaurora.org>
 <20161213013133.GR4920@atomide.com>
 <148160402543.37646.6019420188689675769@resonance>
 <4b016883-e7c9-94d8-d964-3c8dfee6ee13@ti.com>
 <20161213153724.GT4920@atomide.com>
 <148166654419.37646.7680435609801736363@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <148166654419.37646.7680435609801736363@resonance>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette@baylibre.com> [161213 14:02]:
> Quoting Tony Lindgren (2016-12-13 07:37:24)
> > For the clkctrl clocks, here's what I'd like to see. The driver should be
> > just a regular device driver along the lines we did with the ADPLL as in
> > Documentation/devicetree/bindings/clock/ti/adpll.txt.
> > 
> > For the binding, something like the following should work as a minimal
> > example, this follows what we have in the hardware:
> > 
> > &prm {
> >         ...
> > 
> >         /* See "CD_WKUP Clock Domain" in 4430 TRM page 393 */
> >         wkup_cm: clock@1800 {
> >                 compatible = "ti,clkctrl";
> >                 reg = <0x1800 0x100>;
> >                 #clock-cells = <1>;
> >                 clocks = <&wkup_l4_iclk2 &wkup_32k_fclk
> >                           &32k_fclk &gp1_fclk>;
> >                 clock-output-names =
> >                         "sysctrl_padconf_wkup",
> >                         "badgap",
> >                         "sysctrl_general_wkup",
> >                         "gpio1",
> >                         "keyboard",
> >                         "sar_ram",
> >                         "32ktimer",
> >                         "gptimer1";
> 
> Is there a technical reason to use clock-output-names? If you share a
> header between the clock provider driver and DT with the phandle offsets
> then we should be able to avoid this property altogether. Stephen and I
> are trying to phase this one out as much as possible.

Oh OK no reason for names, defines for the offsets will work just fine.

Regards,

Tony
