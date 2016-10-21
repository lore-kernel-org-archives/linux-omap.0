From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 5/7] ARM: dts: am335x: Add the charger interrupt
Date: Fri, 21 Oct 2016 16:01:09 -0500
Message-ID: <CAOCHtYhQ6_Ttr6j-JD6tHZNfs+amAs2qqKPYE_9DnuC_0v5ptg@mail.gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com> <20161021140106.21531-6-woogyom.kim@gmail.com>
 <CAOCHtYgBTq0a1FAMQJb5VoLPWBHYkF3rH_Km6U9u6ep=8ApZuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOCHtYgBTq0a1FAMQJb5VoLPWBHYkF3rH_Km6U9u6ep=8ApZuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux kernel <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 21, 2016 at 3:47 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
> On Fri, Oct 21, 2016 at 9:01 AM, Milo Kim <woogyom.kim@gmail.com> wrote:
>> This enables the charger driver gets corresponding IRQ number by using
>> platform_get_irq_byname() helper.
>>
>> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
>> ---
>>  arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
>> index 25303d9..cec9d91 100644
>> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>> @@ -6,6 +6,8 @@
>>   * published by the Free Software Foundation.
>>   */
>>
>> +#include <dt-bindings/mfd/tps65217.h>
>
> ^ this hasn't been posted nor pushed to mainline yet.. ;)

So, with this patchset + Keerthy's [RESEND PATCH v8 0/5] mfd:
tps65218: Clean ups:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1250918.html

and this patch, as systemd is looking for "tps65217_pwr_but"..

https://github.com/systemd/systemd/blob/master/src/login/70-power-switch.rules#L13

Shutdown is working on my BBB/BBG/BBGW/BBBW's...

diff --git a/drivers/input/misc/tps65218-pwrbutton.c
b/drivers/input/misc/tps65218-pwrbutton.c
index cc74a41..f7e5492 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -36,7 +36,7 @@ struct tps6521x_data {
 static const struct tps6521x_data tps65217_data = {
  .reg_status = TPS65217_REG_STATUS,
  .pb_mask = TPS65217_STATUS_PB,
- .name = "tps65217_pwrbutton",
+ .name = "tps65217_pwr_but",
 };

 static const struct tps6521x_data tps65218_data = {
diff --git a/include/dt-bindings/mfd/tps65217.h
b/include/dt-bindings/mfd/tps65217.h
new file mode 100644
index 0000000..26b2ba8
--- /dev/null
+++ b/include/dt-bindings/mfd/tps65217.h
@@ -0,0 +1,9 @@
+#ifndef __DT_BINDINGS_TPS65217_H
+#define __DT_BINDINGS_TPS65217_H
+
+#define TPS65217_IRQ_USB 0
+#define TPS65217_IRQ_AC 1
+#define TPS65217_IRQ_PB 2
+#define TPS65217_NUM_IRQ 3
+
+#endif /* __DT_BINDINGS_TPS65217_H */

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
