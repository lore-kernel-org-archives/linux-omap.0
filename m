From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: linux-next 2017-08-08 keyboard failure on Nokia N900
Date: Tue, 8 Aug 2017 15:15:00 -0500
Message-ID: <43d915d2-3260-88b6-095d-4de8240ff29e@ti.com>
References: <20170808101756.GA12922@amd> <20170808103444.GA18247@amd>
 <20170808111243.GA20328@amd> <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
 <alpine.DEB.2.20.1708082203510.2095@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.20.1708082203510.2095@hadrien>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org



On 08/08/2017 03:09 PM, Julia Lawall wrote:
> 
> 
> On Tue, 8 Aug 2017, Grygorii Strashko wrote:
> 
>>
>>
>> On 08/08/2017 06:12 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> I tried today's linux-next. It boots on n900 (up to X), but then my
>>>>> screen locks and I can't get back. Touchscreen worked, so my guess is
>>>>> keyboard does not...? Ssh connection over usb still works.
>>>>
>>>> Confirmed, its the keyboard.
>>>>
>>>> Additionally, battery monitoring fails, because neither
>>>>
>>>> /sys/class/power_supply/{n900-,rx51-}battery/voltage_now
>>>>
>>>> exists.
>>>
>>> And dmesg is helpful in this case:
>>>
>>> [    0.675201] input: twl4030_pwrbutton as
>>> /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:pwrbutton/input/input1
>>> [    0.676635] input: TWL4030 Keypad as
>>> /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:keypad/input/input2
>>> [    0.679138] twl4030_keypad 48070000.i2c:twl@48:keypad: request_irq
>>> failed for irq no=156: -13
>>> [    0.679779] twl4030_keypad: probe of 48070000.i2c:twl@48:keypad
>>> failed with error -13
>>> [    0.682769] twl4030_madc 48070000.i2c:twl@48:madc: could not
>>> request irq
>>> [    0.684051] twl4030_madc: probe of 48070000.i2c:twl@48:madc failed
>>> with error -13
>>> [    0.685852] input: twl4030:vibrator as
>>> /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:audio/twl4030-vibra/input/input3
>>> [    0.768890] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
>>>
>>
>> I've not precisely checked it, but smth is telling me that below
>> patch  can cause this:
>>
>> commit 78daaca78ee57dead0f4aa5ee399f0499e81cd9e
>> Author: Julia Lawall <Julia.Lawall@lip6.fr>
>> Date:   Thu May 4 22:10:50 2017 +0200
>>
>>      mfd: twl4030-irq: Drop unnecessary static
>>
>>      Drop static on a local variable, when the variable is initialized before
>>      any use, on every possible execution path through the function.
>>
>> --- a/drivers/mfd/twl4030-irq.c
>> +++ b/drivers/mfd/twl4030-irq.c
>> @@ -685,7 +685,7 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
>>
>>   int twl4030_init_irq(struct device *dev, int irq_num)
>>   {
>> -       static struct irq_chip  twl4030_irq_chip;
>> +       struct irq_chip twl4030_irq_chip;
>>
>>
>> but if we will look at code - it can be seen that this variable is passed by reference to
>> irq_set_chip_and_handler().
>> Ops. And what will happen when twl4030_init_irq() returns ;)
> 
> The patch is not correct as was already noted when it was submitted:
> 
> https://lkml.org/lkml/2017/7/15/169
> https://lkml.org/lkml/2017/7/15/171
> 
> Do you need a patch reverting this one?

Hm. This one is in linux-next, but shouldn't. Right?

  git log --oneline  -10 linux-next/master
c0b96db Add linux-next specific files for 20170808

git log --oneline  linux-next/master | grep "Drop unnecessary static"
78daaca mfd: twl4030-irq: Drop unnecessary static



-- 
regards,
-grygorii
