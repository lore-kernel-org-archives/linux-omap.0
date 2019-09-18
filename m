From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Wed, 18 Sep 2019 14:54:18 +0530
Message-ID: <20190918092418.que4c5jpcn2dcavx@vireshk-mac-ubuntu>
References: <20190912183037.18449-1-aford173@gmail.com>
 <51bb8890-bfd7-c241-1ce5-151df3a90513@linaro.org>
 <CAHCN7xKjwkJHysSkNymF=sw6KuS=FqbapuRFZODuj6E_hmRG1A@mail.gmail.com>
 <2ef812a4-2f2d-b2e2-9fa4-080775e24bc8@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2ef812a4-2f2d-b2e2-9fa4-080775e24bc8@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Adam Ford <aford173@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Andr=E9?= Roth <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

On 13-09-19, 00:33, Daniel Lezcano wrote:
> 
> Hi Adam,
> 
> On 12/09/2019 23:19, Adam Ford wrote:
> > On Thu, Sep 12, 2019 at 4:12 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 12/09/2019 20:30, Adam Ford wrote:
> >>> The thermal sensor in the omap3 family isn't accurate, but it's
> >>> better than nothing.  The various OPP's enabled for the omap3630
> >>> support up to OPP1G, however the datasheet for the DM3730 states
> >>> that OPP130 and OPP1G are not available above TJ of 90C.
> >>>
> >>> This patch configures the thermal throttling to limit the
> >>> operating points of the omap3630 to Only OPP50 and OPP100 if
> >>> the thermal sensor reads a value above 90C.
> 
> Oh, that's a very interesting use case.
> 
> AFAICT the thermal framework is not designed to deal with this
> situation. I agree this setup may work (even if I'm not convinced about
> the stability of the whole).
> 
> May be Viresh can help for the cpufreq side?

Sorry but I am not able to understand what's not supported by thermal framework
here and what can I do to help :)

-- 
viresh
