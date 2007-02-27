From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: I2C TWL4030 Keypad
Date: Tue, 27 Feb 2007 09:09:23 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4756F118@dlee13.ent.ti.com>
References: <8bf247760702262220r6737c7ffn5ce6c0365191ffb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8bf247760702262220r6737c7ffn5ce6c0365191ffb9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, "Cantu Castillo, Arturo" <x0052731@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ram,

Let me look into this (from today -seriously :)

The first thing we have to address here is I2c for 2430. What is
available in GIT now works for T2 read and write. But this might not be
sufficient to clear/enable T2 registers for an interrupt.=20

I will update you my findings later. Sorry for the delay.

Regards,
Khasim

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of Ram
>Sent: Tuesday, February 27, 2007 12:20 AM
>To: Cantu Castillo, Arturo
>Cc: linux-omap-open-source@linux.omap.com
>Subject: Re: I2C TWL4030 Keypad
>
>Hi,
>Keypad driver seems to be okay.
>I tried with RTC driver too. I still get the same error.
>
>I feel it is something to do with twl_core driver - the way interrupts
>are handled.
>
>
>i will look into what you have mentioned.
>
>Regards,
>sriram
>
>
>
>
>
>On 2/26/07, Cantu Castillo, Arturo <x0052731@ti.com> wrote:
>> Hi Ram,
>> It might be happening that when the driver is initialized the i2c
>> writing to TWL4030_MODULE_KEYPAD register that is done to enable
>> interrupts is failing (since you are saying that i2c
readings/writings
>> are failing randomly it is likely), you can try to read this register
>> and find out if the interrupts are enable.
>>
>> Also you can check that all the registers that are set in the
>> initialization routine have the proper value, if i2c writings are
>> failing randomly, some of them might not be initialized correctly.
>>
>> Regards,
>> Arturo
>> -----Original Message-----
>> From: linux-omap-open-source-bounces+x0052731=3Dti.com@linux.omap.com
>>
[mailto:linux-omap-open-source-bounces+x0052731=3Dti.com@linux.omap.com]
>> On Behalf Of Ram
>> Sent: Friday, February 16, 2007 5:25 AM
>> To: linux-omap-open-source@linux.omap.com
>> Subject: I2C TWL4030 Keypad
>>
>> Hi,
>>    Im using omap2430 SDP.
>>    Im trying to get TWL4030 Keypad to work on 2.6.19. Im using 2.6.14
>> for
>> omap2430 as a reference.
>>
>>    Im using the following files:
>>         1) i2c-omap.c which exists on 2.6.19
>>         2) twl4030_core.c
>>         3) twl4030_gpio.c (taken from 2.6.14)
>>         4) omap-twl4030keypad.c (taken from 2.6.14)
>>
>>    made  changes  to support generic interrupts in 2.6.19.
>>
>>    Im able to read the value of registers using  twl4030_kpread_u8
>>     TWL4030_MODULE_KEYPAD, REG_KEYP_EDR, REG_LK_PTV_REG,
>> REG_KEY_DEB_REG,
>> REG_LONG_KEY_REG1, REG_KEYP_SIH_CTRL, REG_KEYP_IMR1
>>
>>   However, im not able to recieve interrupts. upon pressing keys in
>> keypad.
>> i dont observe
>>   any change in interrupts count. when i do a cat /proc/interrupts.
>>
>> Im not sure if im missing something.
>>
>>
>>   I also observe randomly (say 3 out of 10 times), my i2c bus times
out
>> and
>> im unable to read or write TWL4030 registers. i get an return value
of
>> -110.
>>
>> i2c_omap i2c_omap.2: timeout waiting for bus ready
>>
>> Please Advice,
>>
>> Regards,
>> sriram
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
