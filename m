From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Tue, 1 Sep 2015 07:17:21 -0700
Message-ID: <20150901141720.GD4215@atomide.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
 <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55DC3D58.4030409@ti.com>
 <20150825135044.GJ27431@sirena.org.uk>
 <55E42FF7.9010706@ti.com>
 <20150831145249.GO12027@sirena.org.uk>
 <55E5727E.1040103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E5727E.1040103@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linar>, Arnd Bergmann <arnd@arndb.de>, Grygorii Strashko <grygorii.strashko@ti.com>, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I think the fix is rather easy here.. See below.

* Kishon Vijay Abraham I <kishon@ti.com> [150901 02:43]:
> 
> Before commit d919501feffa8715147582c3ffce96fad0c7016f ARM: dts: dra7:
> add minimal l4 bus layout with control module support, the dt was like
> 
> ocp {
> 	dra7_ctrl_general: tisyscon@4a002e00 {
> 		compatible = "syscon";
> 		reg = <0x4a002e00 0x7c>;
> 	};
> 
> 	pbias_regulator: pbias_regulator {
> 		compatible = "ti,pbias-omap";
> 		reg = <0 0x4>;
> 		syscon = <&dra7_ctrl_general>;
> 	};
> };

Yes the reg = <0 0x4> above is wrong, it's not an offset from the
ocp but from the syscon base.
 
> But after commit d919501fef, the dt became like this (after a couple of
> fixes)
> 
> ocp {
> 	l4_cfg: l4@4a000000 {
> 		compatible = "ti,dra7-l4-cfg", "simple-bus";
> 		ranges = <0 0x4a000000 0x22c000>;
> 
> 		scm: scm@2000 {
> 			compatible = "ti,dra7-scm-core", "simple-bus";
> 			reg = <0x2000 0x2000>;
> 			ranges = <0 0x2000 0x2000>;
> 
> 			scm_conf: scm_conf@0 {
> 				compatible = "syscon", "simple-bus";
> 				reg = <0x0 0x1400>;
> 				ranges = <0 0x0 0x1400>;
> 
> 				pbias_regulator: pbias_regulator {
> 					compatible = "ti,pbias-omap";
> 					reg = <0xe00 0x4>;
> 					syscon = <&scm_conf>;
>                                 };
> 			};
> 		};
> 	};
> };

And here we properly describe the hardware interconnect layout and
of_ioremap and friends do the right thing. And reg = <0xxe00 0x4>
is correct offset from the scm_conf base.

Why don't you just make reg unused for pbias_regulator since
we already use regmap for this driver?

Then in the pbias driver just define the register offset from
the syscon base? You may need to set it based on the compatible
value, but it's not like it's going to change for SoC.

If we eventually add some API to calculate reg base offset
from the syscon base it's easy to update the driver to use
that.

Cheers,

Tony
