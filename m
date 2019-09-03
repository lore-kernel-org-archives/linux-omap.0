From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
Date: Tue, 3 Sep 2019 11:58:08 +0530
Message-ID: <20190903062808.p6jkgwylyqxcjs4z@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com>
 <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
 <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com>
 <20190903061403.k3d333f54gj2kuxi@vireshk-i7>
 <6B7B0EDB-8A60-48A0-AFAB-8A266358300C@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6B7B0EDB-8A60-48A0-AFAB-8A266358300C@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 03-09-19, 08:23, H. Nikolaus Schaller wrote:
> 
> > Am 03.09.2019 um 08:14 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> > 
> > On 03-09-19, 08:01, H. Nikolaus Schaller wrote:
> >> 
> >>> Am 03.09.2019 um 04:36 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> >>> 
> >>> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> >>>> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
> >>>> 1GHz capability is automatically detected.
> >>>> 
> >>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >>>> ---
> >>>> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
> >>>> 1 file changed, 7 deletions(-)
> >>>> 
> >>>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >>>> index 5441e9ffdbb4..e98b0c615f19 100644
> >>>> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >>>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >>>> @@ -11,13 +11,6 @@
> >>>> 	cpus {
> >>>> 		cpu@0 {
> >>>> 			cpu0-supply = <&vcc>;
> >>>> -			operating-points = <
> >>>> -				/* kHz    uV */
> >>>> -				300000  1012500
> >>>> -				600000  1200000
> >>>> -				800000  1325000
> >>>> -				1000000	1375000
> >>>> -			>;
> >>>> 		};
> >>>> 	};
> >>> 
> >>> This should be merged with 2/5 ?
> >> 
> >> Well, it bloats 2/5.
> > 
> > It is logically the right place to do this as that's where we are
> > adding opp-v2.
> 
> Well, sometimes the philosophy of patches is to add something new
> first and remove the old in a second separate patch if the system
> can live with both. This makes it easier to digest single patches
> (because they are smaller) and might also better pinpoint an issue
> by bisect.

Right, but you already removed some of the opp-v1 stuff in patch 2/5.
Why leave this one out ?

> > 
> >> What I hope (I can't test) is that this opp-v1 table
> >> is ignored if an opp-v2 table exists. So that it can be
> >> removed by a separate follow-up patch.
> > 
> > It should work as that's what we are doing in OPP core, but I still
> > feel this better get merged with 2/5.
> 
> Ok, I see. Noted for RFCv2.
> 
> There will also be a big batch of changes for the compatible record
> (omap3530->omap35xx, add omap34xx where needed) of ca. 10 board definition
> DTS files. Should this then also become part of the new 2/5?

Compatible thing should be separate patch anyway, I was just talking
about replacing opp-v1 with v2.

-- 
viresh
