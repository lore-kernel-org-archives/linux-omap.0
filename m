From: Adam Ford <aford173@gmail.com>
Subject: Re: [Letux-kernel] [RFC PATCH 0/3] Enable 1GHz support on omap36xx
Date: Mon, 9 Sep 2019 09:26:25 -0500
Message-ID: <CAHCN7xJsPa0i+Z+qpCkWcdAh9+udmGT0RPNchdDsfB=8ptd3Nw@mail.gmail.com>
References: <20190801012823.28730-1-neolynx@gmail.com> <CAHCN7x+nD0J6KZYtfH+0ApQTPO5byO2obMkUwc9Uf4WubyRbTw@mail.gmail.com>
 <C04F49BA-1229-4E96-9FCF-4FC662D1DB11@goldelico.com> <CAHCN7x+Ye6sB_YqO0sAX1OJDw64B-qGS3pL545v3Xk5z914cwQ@mail.gmail.com>
 <0C1EF64E-B33C-4BFA-A7D3-471DD1B9EE86@goldelico.com> <515048DE-138D-4400-8168-F2B7D61F1005@goldelico.com>
 <CAHCN7xLPCX9rZ0+7KVBiA_bgZ6tg6VeCXqD-UXu+6iwpFMPVrA@mail.gmail.com>
 <7B3D1D77-3E8C-444F-90B9-6DF2641178B8@goldelico.com> <CAHCN7xLW58ggx3CpVL=HdCVHWo6D-MCTB91A_9rtSRoZQ+xJuQ@mail.gmail.com>
 <FA2920FE-B76A-4D44-A264-862A1CCBF7FC@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FA2920FE-B76A-4D44-A264-862A1CCBF7FC@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 7, 2019 at 2:38 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Adam,
>
> > Am 02.09.2019 um 23:10 schrieb Adam Ford <aford173@gmail.com>:
> >
> > On Mon, Sep 2, 2019 at 10:46 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>
> >>
> >>
> >> But my tests show that decoding works now. So you already might give it a try.
> >
> > I am traveling all this week, but I have an omap3530, DM3730
> > (omap3630), and an AM3517 that I use for testing.
>
> now as the omap3430 and omap3630 opp-v2 tables are installed,
> we could add am35x7 as well.
>
> What needs to be done:
>
> 1. add OPP-v2 table to am3517.dtsi
>
> for example copy skeleton from omap36xx.dtsi
>
> and define reasonable clock speeds. I would think about
> 150 MHz, 300 MHz, 600MHz.

This might be more of a question for TI, but  can we match the 3430
list of frequencies?

Something like:
    125000  1200000
    250000  1200000
    500000  1200000
    550000  1200000
    600000  1200000


>
> Debatable is if we need a clock-latency definition.
>
> 2. change all voltages to 1.2V
>
>                         opp-microvolt = <1200000 1200000 1200000>;
>
> There is no point to specify 3 voltages <target min max> here since we
> will never need a min and a max value.
>
>                         opp-microvolt = <1200000>;
>
> should also be ok (AFAIK, parser handles single-value records).
>
> 3. AFAIK there is no speed binned eFuse...
>
> But the ti-cpufreq driver always wants to read some eFuse register.
>
> So please check if you can read 0x4800244C and 0x4830A204
> like on omap36xx and if they produce stable values (and not
> random noise).

For the AM3517,

0x4800244C = 0000 0cc0
0x4830A204 = 1b86 802f

The AM3517 shows these are valid addresses and I read them multiple
times and they yielded the same results even after power cycling.


>
> If yes, we simply assume that am3517 is similar enough to omap3630,
> ignore that there is no eFuse, but read the register anyways and
> then ignore the bit if it is 0 or 1.
>
> This means that all OPPs can get
>
>                         opp-supported-hw = <0xffffffff 0xffffffff>;
>
> There could also be a default handler if this property is missing,
> but I have not researched this.
>
Like this?

opp1-125000000 {
     opp-hz = /bits/ 64 <125000000>;
     opp-microvolt = <1200000>;
     opp-supported-hw = <0xffffffff 0xffffffff>;
};

opp2-250000000 {
     opp-hz = /bits/ 64 <250000000>;
     opp-microvolt = <1200000>;
    opp-supported-hw = <0xffffffff 0xffffffff>;
     opp-suspend;
};

opp3-500000000 {
     opp-hz = /bits/ 64 <500000000>;
     opp-microvolt = <1200000>;
     opp-supported-hw = <0xffffffff 0xffffffff>;
};

opp4-550000000 {
     opp-hz = /bits/ 64 <550000000>;
     opp-microvolt = <1200000>;
     opp-supported-hw = <0xffffffff 0xffffffff>;
};

opp5-600000000 {
     opp-hz = /bits/ 64 <600000000>;
     opp-microvolt = <1200000>;
     opp-supported-hw = <0xffffffff 0xffffffff>;
};

What does opp-suspend do?  I noticed it in the 34xx.dtsi

> 4. add compatible to ti-cpufreq
> and share the register offsets, bit masks etc. with omap3630:
>
>         { .compatible = "ti,am33xx", .data = &am3x_soc_data, },
>         { .compatible = "ti,am3517", .data = &omap36xx_soc_data, },
>         { .compatible = "ti,am43", .data = &am4x_soc_data, },
>         { .compatible = "ti,dra7", .data = &dra7_soc_data },
>         { .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
>         { .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
>
> 5. configure for CONFIG_ARM_TI_CPUFREQ=y
>
> This should IMHO suffice.

If you're OK with what I am proposing, I'll run some tests and submit
a patch.  I won't promise to fully understand what's happening.  :-)

>
> Since I can't test anything I can't define working OPP points
> and therefore I can't provide patches myself. Hope you can make
> it work this way.
>
> BR,
> Nikolaus
