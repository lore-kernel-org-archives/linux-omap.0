From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 13:06:14 +0100
Message-ID: <aeccbb02-6e33-390c-d72d-2a580dd67ed8@redhat.com>
References: <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
 <20161115111154.GA5482@amd> <128aae59-b790-42f1-7d66-81391c9330c3@redhat.com>
 <20161115114859.GA7018@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115114859.GA7018@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 15-11-16 12:48, Pavel Machek wrote:
> Hi!
>
>>>>> The LED you are talking about _has_ a trigger, implemented in
>>>>> hardware. That trigger can change LED brightness behind kernel's (and
>>>>> userspace's) back. Don't pretend the trigger does not exist, it does.
>>>>>
>>>>> And when you do that, you'll have nice place to report changes to
>>>>> userspace -- trigger can now export that information, and offer poll()
>>>>> interface.
>>>>
>>>> Well, that sounds interesting. It is logically justifiable.
>>>
>>> Thanks.
>>>
>>>> I initially proposed exactly this solution, with recently
>>>> added userspace LED being a trigger listener. It seems a bit
>>>> awkward though. How would you listen to the trigger events?
>>>
>>> Trigger exposes a file in sysfs, with poll() working on that file
>>
>> Hmm, a new file would give the advantage of making it easy for
>> userspace to see if the trigger is poll-able, this is likely
>> better then my own proposal I just send.
>
> Good.
>
>>> (and
>>> probably read exposing the current brightness).
>>
>> If we do this, can we please make it mirror brightness, iow
>> also make it writable, that will make it easier for userspace
>> to deal with it. We can simply re-use the existing show / store
>> methods for brightness for this.
>
> Actually, echo 0 > brightness disables the trigger, IIRC. I'd avoid
> that here, you want to be able to turn off the backlight but still
> keep the trigger (and be notified of future changes).

True, that is easy to do the store method will just need to call
led_set_brightness_nosleep instead of led_set_brightness, this
will skip the checks to stop blinking in led_set_brightness and
otherwise is equivalent.

>> I suggest we call it:
>>
>> trigger_brightness
>>
>> And only register it when a poll-able trigger is present.
>
> I'd call it 'current_brightness', but that's no big deal. Yes, only
> registering it for poll-able triggers makes sense.

current_brightness works for me. I will take a shot a patch-set
implementing this.

Regards,

Hans



>
>>> Key difference is that only triggers where this makes sense (keyboard
>>> backlight) expose it and carry the overhead. CPU trigger would
>>> definitely not do this.
>>
>> Ack only having some triggers pollable is important.
>
> Thanks,
> 									Pavel
>
