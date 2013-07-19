From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v6 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Fri, 19 Jul 2013 18:40:27 +0300
Message-ID: <51E95DEB.7010702@ti.com>
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
 <51E94F97.40002@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51E94F97.40002@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: milo.kim@ti.com, lars@metafoo.de, sameo@linux.intel.com, tony@atomide.com, poeschel@lemonage.de, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, kishon@ti.com, peter.ujfalusi@ti.com, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, jic23@cam.ac.uk, grant.likely@linaro.org, benoit.cousson@linaro.org, gg@slimlogic.co.uk, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org, balajitk@ti.com
List-Id: linux-omap@vger.kernel.org

On 07/19/2013 05:39 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 19-07-2013 13:27, Oleksandr Kozaruk wrote:
>
>> GPADC is the general purpose ADC present on twl6030.
>> The dt data is interrupt used to trigger end of ADC
>> conversion.
>
>> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
>> ---
>>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>
>> diff --git a/arch/arm/boot/dts/twl6030.dtsi
>> b/arch/arm/boot/dts/twl6030.dtsi
>> index 2e3bd31..d7d4c28 100644
>> --- a/arch/arm/boot/dts/twl6030.dtsi
>> +++ b/arch/arm/boot/dts/twl6030.dtsi
>> @@ -103,4 +103,10 @@
>>           compatible = "ti,twl6030-pwmled";
>>           #pwm-cells = <2>;
>>       };
>> +
>> +    adc: gpadc {
>
>     Read my lips: the node should be called just "adc", not "gpadc".
       ^^^^^^^^^^^^ Are you sure?

Why? The name was selected according to the documentation on device 
"General purpose analog-to-digital converter (GPADC)".

PS. Following your logic - "GPIO" need to renamed to "IO" everywhere ;P

>
> WBR, Sergei
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
- grygorii
