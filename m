From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 15:30:57 +0100
Message-ID: <e1c1db1e-2a78-bbe0-e3bc-84be449dbcb6@redhat.com>
References: <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
 <20161115111154.GA5482@amd> <128aae59-b790-42f1-7d66-81391c9330c3@redhat.com>
 <20161115114859.GA7018@amd> <aeccbb02-6e33-390c-d72d-2a580dd67ed8@redhat.com>
 <9e7d5e0f-c4ca-6930-63b9-83dc28517f33@samsung.com>
 <9d42546d-5917-891c-2b18-ccf7f7328624@redhat.com>
 <3bb538bb-3c80-70c7-2c44-46b174c90503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <3bb538bb-3c80-70c7-2c44-46b174c90503@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 15-11-16 15:04, Jacek Anaszewski wrote:
> On 11/15/2016 02:48 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 15-11-16 14:28, Jacek Anaszewski wrote:
>>> On 11/15/2016 01:06 PM, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 15-11-16 12:48, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>>>>> The LED you are talking about _has_ a trigger, implemented in
>>>>>>>>> hardware. That trigger can change LED brightness behind kernel's
>>>>>>>>> (and
>>>>>>>>> userspace's) back. Don't pretend the trigger does not exist, it
>>>>>>>>> does.
>>>>>>>>>
>>>>>>>>> And when you do that, you'll have nice place to report changes to
>>>>>>>>> userspace -- trigger can now export that information, and offer
>>>>>>>>> poll()
>>>>>>>>> interface.
>>>>>>>>
>>>>>>>> Well, that sounds interesting. It is logically justifiable.
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>> I initially proposed exactly this solution, with recently
>>>>>>>> added userspace LED being a trigger listener. It seems a bit
>>>>>>>> awkward though. How would you listen to the trigger events?
>>>>>>>
>>>>>>> Trigger exposes a file in sysfs, with poll() working on that file
>>>>>>
>>>>>> Hmm, a new file would give the advantage of making it easy for
>>>>>> userspace to see if the trigger is poll-able, this is likely
>>>>>> better then my own proposal I just send.
>>>>>
>>>>> Good.
>>>>>
>>>>>>> (and
>>>>>>> probably read exposing the current brightness).
>>>>>>
>>>>>> If we do this, can we please make it mirror brightness, iow
>>>>>> also make it writable, that will make it easier for userspace
>>>>>> to deal with it. We can simply re-use the existing show / store
>>>>>> methods for brightness for this.
>>>>>
>>>>> Actually, echo 0 > brightness disables the trigger, IIRC. I'd avoid
>>>>> that here, you want to be able to turn off the backlight but still
>>>>> keep the trigger (and be notified of future changes).
>>>>
>>>> True, that is easy to do the store method will just need to call
>>>> led_set_brightness_nosleep instead of led_set_brightness, this
>>>> will skip the checks to stop blinking in led_set_brightness and
>>>> otherwise is equivalent.
>>>>
>>>>>> I suggest we call it:
>>>>>>
>>>>>> trigger_brightness
>>>>>>
>>>>>> And only register it when a poll-able trigger is present.
>>>>>
>>>>> I'd call it 'current_brightness', but that's no big deal. Yes, only
>>>>> registering it for poll-able triggers makes sense.
>>>>
>>>> current_brightness works for me. I will take a shot a patch-set
>>>> implementing this.
>>>
>>> Word "current" is not precise here.
>>>
>>> It can be thought of as either last brightness set by the
>>> user or the brightness currently written to the device
>>> (returned by brightness file).
>>>
>>> There is a semantic discrepancy in our requirements -
>>> we want the file representing both permanent brightness
>>> set by the user and brightness set by the hardware.
>>>
>>> The two stand in contradiction to each other since
>>> brightness set by the user can be adjusted by the hardware.
>>>
>>> Reading the file shouldn't update brightness property of
>>> struct led_classdev, so it shouldn't call led_update_brightness()
>>> but it still should allow reading brightness set by the
>>> hardware, as a result of each POLLPRI event. So in fact in
>>> the same time it should report both according to our requirements
>>> which is impossible. Do we need three brightness files ?
>>
>> I don't think so, current_brightness actually is an accurate
>> name, if the brightness was last changed by writing from
>> sysfs, the keyboard backlight will honor that and the current_brightness
>> attribute will show the brightness last set through writing it,
>> which matches the actual current brightness of the keyboard backlight.
>>
>> Likewise if it was changed with the hotkey last then the keyboard
>> backlight brightness will be changed and reading from current_brightness
>> will return the new actual brightness. Basically reading from this
>> file will be no different then reading from the normal "brightness"
>> file the difference will be in that it is poll-able and that
>> writing 0 turns off the LED without stopping blinking.
>
> If so then when software blinking enabled, it will return 0 on low
> blink cycle no matter what current brightness level is.

For software blinking there will not be a current_brightness atrribute,
as we will only add that for LEDs with poll-able triggers.

Also during the low cycle the LED is off, so its brightness at the
moment of reading (iow currently) is 0.

Regards,

Hans
