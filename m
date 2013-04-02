From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Tue, 2 Apr 2013 13:15:08 +0300
Message-ID: <515AAFAC.50908@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com> <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com> <20130328212739.13785.44736@quantum> <20130328223513.GA19470@kahuna> <51596725.9060109@ti.com> <20130401181057.8177.19688@quantum> <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com> <20130401213430.8177.21940@quantum> <20130401230009.GA2038@snafu> <20130402000545.8177.65252@quantum> <20130402033545.GA2020@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38293 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab3DBKQ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 06:16:28 -0400
In-Reply-To: <20130402033545.GA2020@snafu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Tero Kristo <t-kristo@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

On 04/02/2013 06:35 AM, Nishanth Menon wrote:
> On 17:05-20130401, Mike Turquette wrote:
>> OK, so we're in agreement on what The Future looks like.  What does that
>> mean for Andrii's patchset?
> Unless anyone has an fundamental issue with the approach of an "Super
> regulator" controlling "sub regulators", I think, in-line with your
> view, we should probably make ABB as an regulator instead of inventing
> our own API and hooking it around clock notifiers.
Hi Nishanth, All
One question here, regarding "Super regulator" - How are you going to 
differentiate
OPP changing and AVS Voltage adjustment requests to the "Super regulator"??
As you know, to select OPP changing direction, ABB type (or VC/VP 
parameters)
properly you need Nominal (and only Nominal) voltage as input.
And in real world, AVS can adjust voltage, as example, for OPP100 even 
low than for OPP50.
OMAP4 example:
     MPU OPP    Vsr                Vnom   ABB
     OPP50      0.862249970436096  1.025  NOM
     OPP100     1.03509700298309   1.2    NOM
     OPPTurbo   1.09257805347443   1.325  NOM
     OPPNitro   1.18703103065491   1.388  FAST
     OPPNitroSB 1.29427194595337   1.398  FAST
So, while adjusting voltage, AVS can hit other OPP voltage and, as 
result, ABB mode may be changed.

I think, your vision would be more clear if you could be able to provide 
Sequence diagram in addition.

And would it be allowed to use DT for such regulator chain definitions
(or board-generic.c should be used instead), just for clarification,
  because I have not to much DT experience:
omap443x.dtsi:
vdd_mpu: regulator-omap-ti1 { << -- Super regulator
          compatible = "ti,omapX-regulator";
          regulator-min-microvolt = <750000>;
          regulator-max-microvolt = <1388000>;
          smps-supply = <&smps_mpu>; [or smps-supply = <&vcc>;]
          abb-supply = <&abb_mpu>;
};

smps_mpu: regulator-omap-smps1 { <--VC/VP regulator
          compatible = "ti,omapX-smps-regulator";
          ti,vc = <&vc>
          ti,vp = <&vp_mpu>
};

twl4030.dtsi
vcc: regulator-vdd1 {
           compatible = "ti,twl4030-vdd1";
           regulator-min-microvolt = <600000>;
           regulator-max-microvolt = <1450000>;
};

Regards,
Grygorii Strashko


