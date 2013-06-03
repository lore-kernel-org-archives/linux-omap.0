From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1] ARM: dts: omap4-panda: Update the twl6040 gpio to
 macro definition
Date: Mon, 3 Jun 2013 16:20:25 +0200
Message-ID: <51ACA629.3060505@ti.com>
References: <1370015122-26792-1-git-send-email-dmurphy@ti.com>
 <51A8CC08.6090305@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51A8CC08.6090305-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Dan,

On 05/31/2013 06:12 PM, Florian Vaussard wrote:
> Hello Dan,
> 
> On 05/31/2013 05:45 PM, Dan Murphy wrote:
>> Update the dt property ti,audpwron-gpio to use the
>> gpio macro definition for GPIO_ACTIVE_HIGH.
>>
>> Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/omap4-panda-common.dtsi |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> index 800fa4e..00cbaa5 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> @@ -190,7 +190,7 @@
>>           /* IRQ# = 119 */
>>           interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /*
>> IRQ_SYS_2N cascaded to gic */
>>           interrupt-parent = <&gic>;
>> -        ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
>> +        ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio
>> line 127 */
>>
>>           vio-supply = <&v1v8>;
>>           v2v1-supply = <&v2v1>;
>>
> 
> I missed it during the conversion, thank you.
> 
> Reviewed-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

I've just applied it with Florian's Reviewed-by.

Thanks,
Benoit
