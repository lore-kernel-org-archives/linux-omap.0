From: Nishanth Menon <nm@ti.com>
Subject: Re: reset handling in am335x hwmod data
Date: Tue, 2 Jul 2013 08:57:04 -0500
Message-ID: <51D2DC30.9010503@ti.com>
References: <20130517135022.GH14133@arwen.pp.htv.fi> <877gixsfdz.fsf@linaro.org> <87vc6hlbnz.fsf@dell.be.48ers.dk> <20130517181922.GA4439@kahuna> <79CD15C6BA57404B839C016229A409A83EC8E827@DBDE04.ent.ti.com> <79CD15C6BA57404B839C016229A409A83EC8E84F@DBDE04.ent.ti.com> <20130520150617.GA22835@kahuna> <79CD15C6BA57404B839C016229A409A83EC8EF60@DBDE04.ent.ti.com> <20130520180344.GA7653@kahuna> <79CD15C6BA57404B839C016229A409A83EC8EFEC@DBDE04.ent.ti.com> <20130628105408.GM11297@arwen.pp.htv.fi> <79CD15C6BA57404B839C016229A409A83ECCC461@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39541 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3GBN50 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 09:57:26 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECCC461@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On 07/01/2013 11:37 PM, Hiremath, Vaibhav wrote:
>
>> -----Original Message-----
>> From: Balbi, Felipe
>> Sent: Friday, June 28, 2013 4:24 PM
>> To: Hiremath, Vaibhav
>> Cc: Menon, Nishanth; Peter Korsgaard; Kevin Hilman; Balbi, Felipe; P=
aul
>> Walmsley; linux-omap@vger.kernel.org; Tony Lindgren; Sebastian Andrz=
ej
>> Siewior
>> Subject: Re: reset handling in am335x hwmod data
>>
>> Hi,
>>
>> On Mon, May 20, 2013 at 08:20:29PM +0200, Hiremath, Vaibhav wrote:
>>>
>>>> -----Original Message-----
>>>> From: Menon, Nishanth
>>>> Sent: Monday, May 20, 2013 11:34 PM
>>>> To: Hiremath, Vaibhav
>>>> Cc: Peter Korsgaard; Kevin Hilman; Balbi, Felipe; Paul Walmsley;
>> linux-
>>>> omap@vger.kernel.org; Tony Lindgren
>>>> Subject: Re: reset handling in am335x hwmod data
>>>>
>>>> On 12:47-20130520, Hiremath, Vaibhav wrote:
>>>> [...]
>>>>>>>>>
>>>>>>>>> On 20:10-20130517, Peter Korsgaard wrote:
>>>>>>>>>>>>>>> "Kevin" =3D=3D Kevin Hilman <khilman@linaro.org>
>> writes:
>>>>>>>>>>
>>>>>>>>>>   >> In this case, we cannot reset that bank, otherwise
>>>> Starter
>>>>>> Kit
>>>>>>>>> will
>>>>>>>>>>   >> never boot in mainline. Bad PCB design, I know, but
>>>> it's
>>>>>> not
>>>>>>>>> something
>>>>>>>>>>   >> we can change now :-)
>>>>>>>>>>
>>>>>>>>>>   Kevin> FWIW, we've seen this before (GPIO connected to
>>>> PMIC
>>>>>> reset
>>>>>>>> is
>>>>>>>>> a
>>>>>>>>>>   Kevin> fun one), and this is why we have
>>>>>>>>> omap_hwmod_no_setup_reset().
>>>>>>>>>>
>>>>>>>>>> Yes, but there's no dts bindings for this, and from a
>> quick
>>>>>> test
>>>>>>>> the
>>>>>>>>>> reset handling happens before the device tree is
>> probed.
>>>>>>>>> I have the same issue with TPS62361 on Palmas -> GPIO
>>>> controls
>>>>>> the
>>>>>>>>> voltage register supplying MPU, without any driver
>> setting
>>>> things
>>>>>> up,
>>>>>>>>> GPIO gets reset and obviously voltage value switches to
>> an
>>>>>> voltage
>>>>>>>>> where
>>>>>>>>> device does not function.
>>>>>>>>>
>>>>>>>>> Solution I am working on to solve this is [1]: snippet is
>>>> part of
>>>>>> a
>>>>>>>>> patch that I am working on atm.
>>>>>>>>>
>>>>>>>>> This is the right way to do it IMHO. Will allow the
>> driver to
>>>>>> exist
>>>>>>>>> when
>>>>>>>>> HWMOD will be eventually replaced by some other
>> framework.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [1]: http://pastebin.com/XPmAB1Zb
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Both seems to be different to me. What we need is to
>>>>>>>> Avoid reset of whole GPIO bank during kernel boot.
>>>>>> Yes - that is what the above does - as long as the GPIO is
>>>> requested
>>>>>> and
>>>>>> set to the right level by the relevant driver, it is not
>> "unused"
>>>> and
>>>>>> hence not reset at late_init.
>>>>>>
>>>>>
>>>>> May be I am missing something here,
>>>>>
>>>>> Isn't _setup_reset() function asserts ocp_reset? And it is
>>>> core_initcall.
>>>> Hmm.. You are right, I missed that :(
>>>>>
>>>>>> I am a little unclear as to why this needs to have anything to
>> do
>>>> with
>>>>>> the precise under-lying mechanism (hwmod or something else).
>> May be
>>>>>> "both seem to be different to me" needs a little further
>>>> elaboration?
>>>>>>
>>>>>
>>>>> GPIO is connected to the DDR VTT control pin, and we have
>> observed
>>>> that
>>>>> Due to GPIO bank reset as part of hwmod init during bootup.
>>>>>
>>>>>> Is this because there is no need for an EMIF driver to handle
>> DDR?
>>>> and
>>>>>> reset of the GPIO will occur as EMIF is configured at
>> bootloader
>>>> and
>>>>>> there is no need to do that in kernel, correspondingly there is
>> no
>>>>>> "driver" to hold the gpio?
>>>>>>>>
>>>>>>>> Ideally, it would have been much better if drivers starts
>>>> handling
>>>>>>>> Idle, ocp reset and standby on their own (killing
>> dependency on
>>>>>> hwmod
>>>>>>>> init layer).
>>>>>>>>
>>>>>>>> But looking at current state,
>>>>>>>> I agree we need to use DT property here, so how about
>>>>>>>> Adding DT property  to GPIO node itself. But we have to
>> parse
>>>>>> I believe you mean at OMAP specific  DT property for hwmod?
>>>>>> something like ti,hwmod-no-init-reset?
>>>>>
>>>>> That=E2=80=99s the idea.
>>>>>
>>>>>>>> It early during hwmod init stage. We should read all DT
>> nodes
>>>>>>>> Inside function __setup() function, that way can get rid of
>>>>>>>> HWMOD_INIT_NO_RESET flag completely. Also, this will handle
>>>>>>>> Both ocp_reset and domain reset.
>>>>>>>>
>>>>>>>
>>>>>>> Forgot to mention,
>>>>>>>
>>>>>>> Since this is kernel boot failure issue, I think,
>>>>>>> By the time we reach to conclusion, another approach is to
>>>>>>> set "HWMOD_INIT_NO_RESET" flag For GPIO0 bank.
>>>>>> a) if the GPIO gets moved over to some other GPIO bank on
>> another
>>>>>> platform,
>>>>>> this wont work
>>>>>
>>>>> Yes that=E2=80=99s true, but such schematic interface is not reco=
mmended.
>>>>> And we have not seen any known side-effect of not resetting GPIO0
>>>> bank.
>>>> unless you mark the GPIO as taken, another driver could in-
>> adverantly
>>>> take over the GPIO and set it to a wrong level (we had a similar
>> story
>>>> with LED gpio between Panda Vs Panda-ES).
>>>>
>>>>>
>>>>>> b) for platforms that dont use gpio to hold DDR power, maybe
>> this
>>>> is
>>>>>> not
>>>>>> even relevant and the GPIO bank can safely be reset?
>>>>>>>
>>>>>
>>>>> As I mentioned, there is no known side-effect of not resetting
>> GPIO
>>>> bank 0.
>>>> It should depend on the platform.
>>>>
>>>> There are other uses for hwmod-no-reset -> Eg. boot logo displayed
>> by
>>>> bootloader - if there is a reset of DSS block and re-configuration=
,
>>>> we'd
>>>> notice a blank-out, which is not desirable either. There could be =
a
>> few
>>>> other usage based on no-reset.
>>>>
>>>> In all cases, you'd prefer to make this:
>>>> a) platform dependent (board dts)
>>>> b) reserve GPIO as well so that no other driver'd take it - if the=
y
>>>> attempt ther'd at least be some form of warning.
>>>>
>>> Completely agree with you on both the points, and my point and all =
my
>> comments
>>> Were more related to option 'a' above.
>>
>> so, what happened here ? Will we not have AM335x-SK working in mainl=
ine
>> just because of the GPIO block being reset ?
>>
>
> Nishant started implementing on this, not sure what state it is in.

Nope. I am not working on this.

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
