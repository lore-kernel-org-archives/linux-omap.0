From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 11/18] arm: dts: add omap4430 thermal data
Date: Fri, 27 Sep 2013 08:26:35 -0500
Message-ID: <CAGo_u6p3pp2EBo_fJE_RJOdrc05OHM-QFgCZFBUW+duhPgOYpw@mail.gmail.com>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
	<1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
	<20130927122439.GA8360@kahuna>
	<5245861F.7000109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <5245861F.7000109@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, dt list <devicetree@vger.kernel.org>, wni@nvidia.com, durgadoss.r@intel.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, rui.zhang@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 27, 2013 at 8:20 AM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> On 27-09-2013 08:24, Nishanth Menon wrote:
>> On 23:13-20130926, Eduardo Valentin wrote:
>>> This patch changes the dtsi entry on omap4430 to contain
>>> the thermal data. This data will enable the passive
>>> cooling with CPUfreq cooling device at 100C and the
>>> system will do a thermal shutdown at 125C.
>>>
>>> Cc: "Beno=EEt Cousson" <bcousson@baylibre.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: linux-omap@vger.kernel.org
>>> Cc: devicetree-discuss@lists.ozlabs.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/om=
ap443x.dtsi
>>> index bcf455e..e9c97d6 100644
>>> --- a/arch/arm/boot/dts/omap443x.dtsi
>>> +++ b/arch/arm/boot/dts/omap443x.dtsi
>>> @@ -12,7 +12,7 @@
>>>
>>>  / {
>>>      cpus {
>>> -            cpu@0 {
>>> +            cpu0: cpu@0 {
>>>                      /* OMAP443x variants OPP50-OPPNT */
>>>                      operating-points =3D <
>>>                              /* kHz    uV */
>>> @@ -25,9 +25,15 @@
>>>              };
>>>      };
>>>
>>> -    bandgap {
>>> +    thermal-zones{
>>> +            #include "omap4-cpu-thermal.dtsi"
>>> +    };
>>> +
>>> +    bandgap: bandgap {
>>>              reg =3D <0x4a002260 0x4
>>>                     0x4a00232C 0x4>;
>>>              compatible =3D "ti,omap4430-bandgap";
>>> +
>>> +            #thermal-sensor-cells =3D <0>;
>> 2 cents:
>> we might want to move bandgap under ocp?
>>
>
> Yes, agreed. But I don't think this change is related to this patch o=
r
> to this series.

Correct - this comment is not related to the current patch, hence my 2
cents ;) - will be nice to have it cleaned up though..

Regards,
Nishanth Menon
