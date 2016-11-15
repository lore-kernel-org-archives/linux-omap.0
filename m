From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 12:21:43 +0100
Message-ID: <128aae59-b790-42f1-7d66-81391c9330c3@redhat.com>
References: <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
 <20161115111154.GA5482@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115111154.GA5482@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 15-11-16 12:11, Pavel Machek wrote:
> On Tue 2016-11-15 11:58:06, Jacek Anaszewski wrote:
>> On 11/15/2016 11:31 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> Hmm, v4 still calls led_notify_brightness_change(led_cdev)
>>>> >from both __led_set_brightness() and __led_set_brightness_blocking().
>>>>
>>>> Ugh, I see I accidentally send a v4 twice, instead of
>>>> calling the version which dropped those called v5 as
>>>> I should have, sorry.
>>>>
>>>> The v4 which I would like to see merged, the one with
>>>> those calls dropped, is here:
>>>>
>>>> https://patchwork.kernel.org/patch/9423093/
>>>
>>> Please, lets fix this properly.
>>>
>>> The LED you are talking about _has_ a trigger, implemented in
>>> hardware. That trigger can change LED brightness behind kernel's (and
>>> userspace's) back. Don't pretend the trigger does not exist, it does.
>>>
>>> And when you do that, you'll have nice place to report changes to
>>> userspace -- trigger can now export that information, and offer poll()
>>> interface.
>>
>> Well, that sounds interesting. It is logically justifiable.
>
> Thanks.
>
>> I initially proposed exactly this solution, with recently
>> added userspace LED being a trigger listener. It seems a bit
>> awkward though. How would you listen to the trigger events?
>
> Trigger exposes a file in sysfs, with poll() working on that file

Hmm, a new file would give the advantage of making it easy for
userspace to see if the trigger is poll-able, this is likely
better then my own proposal I just send.

> (and
> probably read exposing the current brightness).

If we do this, can we please make it mirror brightness, iow
also make it writable, that will make it easier for userspace
to deal with it. We can simply re-use the existing show / store
methods for brightness for this.

I suggest we call it:

trigger_brightness

And only register it when a poll-able trigger is present.


> Key difference is that only triggers where this makes sense (keyboard
> backlight) expose it and carry the overhead. CPU trigger would
> definitely not do this.

Ack only having some triggers pollable is important.

Regards,

Hans
