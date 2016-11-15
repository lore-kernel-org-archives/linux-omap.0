From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 12:17:00 +0100
Message-ID: <2f04d861-d2b9-8f53-6ebf-fe39bf73463a@redhat.com>
References: <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <4c31faef-144d-289c-0e32-83e76aff6178@gmail.com>
 <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
 <CGME20161115103141epcas2p251f2521354a8cd7b9dfcfe55bfa482f0@epcas2p2.samsung.com>
 <20161115103133.GA22860@amd>
 <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e392d5d-eb10-f285-517e-976a55c3e318@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

HI,

On 15-11-16 11:58, Jacek Anaszewski wrote:
> On 11/15/2016 11:31 AM, Pavel Machek wrote:
>> Hi!
>>
>>>> Hmm, v4 still calls led_notify_brightness_change(led_cdev)
>>> >from both __led_set_brightness() and __led_set_brightness_blocking().
>>>
>>> Ugh, I see I accidentally send a v4 twice, instead of
>>> calling the version which dropped those called v5 as
>>> I should have, sorry.
>>>
>>> The v4 which I would like to see merged, the one with
>>> those calls dropped, is here:
>>>
>>> https://patchwork.kernel.org/patch/9423093/
>>
>> Please, lets fix this properly.
>>
>> The LED you are talking about _has_ a trigger, implemented in
>> hardware. That trigger can change LED brightness behind kernel's (and
>> userspace's) back. Don't pretend the trigger does not exist, it does.
>>
>> And when you do that, you'll have nice place to report changes to
>> userspace -- trigger can now export that information, and offer poll()
>> interface.
>
> Well, that sounds interesting. It is logically justifiable.
> I initially proposed exactly this solution, with recently
> added userspace LED being a trigger listener. It seems a bit
> awkward though. How would you listen to the trigger events?

We could make the trigger sysfs attribute poll()-able, but only
for select triggers, e.g.:

Documentation/ABI/testing/sysfs-class-led

What:           /sys/class/leds/<led>/trigger
Date:           March 2006
KernelVersion:  2.6.17
Contact:        Richard Purdie <rpurdie@rpsys.net>
Description:
                 Set the trigger for this LED. A trigger is a kernel based source
                 of led events.
                 You can change triggers in a similar manner to the way an IO
                 scheduler is chosen. Trigger specific parameters can appear in
                 /sys/class/leds/<led> once a given trigger is selected. For
                 their documentation see sysfs-class-led-trigger-*.
+
+		For some triggers userspace my poll() this file, watching for
+		POLL_PRI to detect when the trigger triggers. This is only
+		supported if this is explicitly mentioned as supported in
+		sysfs-class-led-trigger-* for the selected trigger.

The reason for making this only supported for select triggers is to
avoid getting the whole power-consumption issue from triggers which fire
frequently again.

And then we could add a new:

Documentation/ABI/testing/sysfs-class-led-trigger-kbd-backlight-change

File which documents that the new to be added kbd-backlight-change
trigger is poll-able.

We would also need:

--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -47,6 +47,7 @@ struct led_classdev {
  #define LED_DEV_CAP_FLASH      (1 << 18)
  #define LED_HW_PLUGGABLE       (1 << 19)
  #define LED_PANIC_INDICATOR    (1 << 20)
+#define LED_TRIGGER_READ_ONLY   (1 << 21)

         /* set_brightness_work / blink_timer flags, atomic, private. */
         unsigned long           work_flags;

To allow led drivers to indicate that there trigger is hardwired.

Regards,

Hans
