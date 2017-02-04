From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5 GHz
 SoC operation
Date: Fri, 3 Feb 2017 18:21:36 -0600
Message-ID: <79e08896-895e-4996-8402-832328b4f7d8@ti.com>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
 <1486135491-14223-2-git-send-email-lukma@denx.de>
 <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com> <20170204002150.707b231d@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170204002150.707b231d@jawa>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lukasz Majewski <lukma@denx.de>, Dave Gerlach <d-gerlach@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/03/2017 05:21 PM, Lukasz Majewski wrote:
> Hi Dave,
>
> Thanks for sharing the knowledge :-)
>
>> On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
>>> The "opp_high" property brings support for 1.5 GHz CPU frequency
>>> for TI's am57xx line of processors.
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>> ---
>>>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>
>> This can't be blindly enabled for all am57xx SoCs,
>
> Yes, I'm fully aware of AVS, which uses fuses and SoC silicon revision
> to assess if frequency can be enabled.
>
> Example from my playground:
>
> - AM5728 works with 1.5 GHz enabled
>
> - AM5718 hangs when I try to enable 1.5 GHz frequency
>
>
>> there is a
>> forthcoming ti-cpufreq [1] driver
>
> I've backported and tested this code on v4.9 vanilla. It works :-)
>
>> that is needed that will decided
>> which OPPs can and cannot be enabled for the specific variant in use.
>
> I do have a question:
>
> Do you know the correct opp-supported-hw value for 1.5 GHz on AM57x8
> SoC?
> In TI's SDK Linux (v4.4): opp-supported-hw = <0xFF 0x04>; but this seems
> to be always enabled (and not taking silicon revision and efuse into
> account).

There is a TISDK 4.9 being built up as well (we typically do let the 
driver soak for a test cycle prior to posting it upstream) but if it 
is of interest.. it should match the version Dave posted upstream..

http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.9.y/arch/arm/boot/dts/dra7.dtsi#line100

> For my use case it would be best to see what data should prevent my
> AM5718 from 1.5 GHz OPP.
>
> In other words I need to be 100% sure that my silicon SoC version
> doesn't support the 1.5 GHz frequency.
>

look at dra7_efuse_xlate which does a speed grade decode of the speeds 
permitted.. a value of 15 or 23 should permit 1.5GHz. those are common 
for DRA7/AM57 SoCs.

If the efuses seem set for 1.5GHz, the chip should be capable of 
1.5GHz, i'd start suspecting regulators, slew rates and the like.

http://www.ti.com/lit/pdf/spruhz7
rev d: page 371 -> 23 (0x17) = X speed designator Refer to device DM 
for supported speed grades for a given device, and the definition for 
supported speed grades.
So, if you go to 
http://www.ti.com/product/AM5718/datasheet/specifications#SWPS043-7245x 
-> you will see the "X" designator in AM5718xxX which does support 23 
and 1.5GHz.


Now, if you did get one of the pre-production samples, it is possible 
to have efuses slightly messed up on very initial samples - at least 
internally, we have had them replaced and none of those samples should 
have exited TI.. but mistakes might happen.. if the efuse value does 
not meet the speed grade in documentation, then, please contact TI FAE 
your company works with and let them know for what to do 
alternatively, you can also file it on e2e.ti.com for further support.

-- 
Regards,
Nishanth Menon
