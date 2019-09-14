From: H. Nikolaus Schaller <hns@goldelico.com>
Subject: Re: [PATCH v3 6/8] ARM: dts: omap36xx: using OPP1G needs to control
 the abb_ldo
Date: Sat, 14 Sep 2019 11:30:10 +0200
Message-ID: <F05A8A00-9B2A-4159-BE5B-C93DF139F73E@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
 <59a0f6267c75859c25665548db2e8a9c4229d3b4.1568224033.git.hns@goldelico.com>
 <CAHCN7x+RTSHg7jKys=Jv6Urz0PsHNTM8EnFT1dwAZOtsjxpEAw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7x+RTSHg7jKys=Jv6Urz0PsHNTM8EnFT1dwAZOtsjxpEAw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Teresa Remmet <t.remmet@phytec.de>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


> Am 13.09.2019 um 23:13 schrieb Adam Ford <aford173@gmail.com>:
> 
> On Wed, Sep 11, 2019 at 12:47 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> 
>> See DM3730,DM275 data sheet (SPRS685B) footnote (6) in Table 4-19
>> which says that ABB must be switched to FBB mode when using the
>> OPP1G.
>> 
>> The LOD definition abb_mpu_iva already exists so that we need
>> to add plumbing for vbb-supply = <&abb_mpu_iva>
>> and define two voltage vectors for each OPP so that the abb LDO
>> is also updated by the ti-cpufreq driver.
>> 
>> We also must switch the ti_cpufreq_soc_data to multi_regulator.
>> 
>> Note: reading out the abb reglator voltage to verify that
>> it does do transitions can be done by
>> 
>> cat /sys/devices/platform/68000000.ocp/483072f0.regulator-abb-mpu/regulator/regulator.*/microvolts
>> 
>> Likewise, read the twl4030 provided VDD voltage by
>> 
>> cat /sys/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:regulator-vdd1/regulator/regulator.*/microvolts
>> 
>> Note: to check if the ABB FBB is enabled/disabled, check
>> registers
>> 
>> PRM_LDO_ABB_CTRL 0x483072F4 bit 3:0 1=bypass 5=FBB
>> PRM_LDO_ABB_SETUP 0x483072F0 0x00=bypass 0x11=FBB
>> 
>> e.g.
>> 
>> /dev/mem opened.
>> Memory mapped at address 0xb6fe4000.
>> Value at address 0x483072F4 (0xb6fe42f4): 0x3205
>> /dev/mem opened.
>> Memory mapped at address 0xb6f89000.
>> Value at address 0x483072F4 (0xb6f892f4): 0x3201
>> 
>> Note: omap34xx and am3517 have/need no comparable LDO
>> or mechanism.
>> 
>> Suggested-by: Adam Ford <aford173@gmail.com>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap36xx.dtsi | 21 ++++++++++++++++-----
>> drivers/cpufreq/ti-cpufreq.c    |  2 +-
>> 2 files changed, 17 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
>> index cb5bd0969124..4bb4f534afe2 100644
>> --- a/arch/arm/boot/dts/omap36xx.dtsi
>> +++ b/arch/arm/boot/dts/omap36xx.dtsi
>> @@ -23,6 +23,7 @@
>>                cpu: cpu@0 {
>>                        operating-points-v2 = <&cpu0_opp_table>;
>> 
>> +                       vbb-supply = <&abb_mpu_iva>;
>>                        clock-latency = <300000>; /* From omap-cpufreq driver */
>>                };
>>        };
>> @@ -37,9 +38,11 @@
>>                        /*
>>                         * we currently only select the max voltage from table
>>                         * Table 4-19 of the DM3730 Data sheet (SPRS685B)
>> -                        * Format is: <target min max>
>> +                        * Format is:   cpu0-supply:    <target min max>
>> +                        *              vbb-supply:     <target min max>
>>                         */
>> -                       opp-microvolt = <1012500 1012500 1012500>;
>> +                       opp-microvolt = <1012500 1012500 1012500>,
>> +                                        <1012500 1012500 1012500>;
>>                        /*
>>                         * first value is silicon revision bit mask
>>                         * second one is "speed binned" bit mask
>> @@ -50,25 +53,33 @@
>> 
>>                opp100-600000000 {
>>                        opp-hz = /bits/ 64 <600000000>;
>> -                       opp-microvolt = <1200000 1200000 1200000>;
>> +                       opp-microvolt = <1200000 1200000 1200000>,
>> +                                        <1200000 1200000 1200000>;
>>                        opp-supported-hw = <0xffffffff 3>;
>>                };
>> 
>>                opp130-800000000 {
>>                        opp-hz = /bits/ 64 <800000000>;
>> -                       opp-microvolt = <1325000 1325000 1325000>;
>> +                       opp-microvolt = <1325000 1325000 1325000>,
>> +                                        <1325000 1325000 1325000>;
>>                        opp-supported-hw = <0xffffffff 3>;
>>                };
>> 
>>                opp1g-1000000000 {
>>                        opp-hz = /bits/ 64 <1000000000>;
>> -                       opp-microvolt = <1375000 1375000 1375000>;
>> +                       opp-microvolt = <1375000 1375000 1375000>,
>> +                                        <1375000 1375000 1375000>;
>>                        /* only on am/dm37x with speed-binned bit set */
>>                        opp-supported-hw = <0xffffffff 2>;
>>                        turbo-mode;
> 
> If / when the thermal changes I submitted get approved, would you
> entertain dropping this turbo-mode flag so it's enabled by default?

Yes, that makes sense.

To keep patches clearly grouped into two series (better for bisect or
partial revert or apply in any order), I would suggest that we do

1. add OPP1G logic (with turbo-mode; specified)
2. add thermal throttling
3. remove turbo-mode again as soon as both are merged

A patch for 2b is waiting for 1 and 2a to be confirmed :)

BR,
Nikolaus
