From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 11:01:26 +0100
Message-ID: <6d88b2a7-a506-89bf-fc76-af707ed7a00f@samsung.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd> <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd> <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd> <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <4c31faef-144d-289c-0e32-83e76aff6178@gmail.com>
 <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11/14/2016 01:51 PM, Hans de Goede wrote:
> Hi,
>
> On 14-11-16 10:12, Jacek Anaszewski wrote:
>> Hi,
>>
>> On 11/13/2016 02:52 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 13-11-16 12:44, Jacek Anaszewski wrote:
>>>> Hi,
>>>>
>>>> On 11/12/2016 10:14 PM, Hans de Goede wrote:
>>>
>>> <snip>
>>>
>>>>>>> So I would like to propose creating a new read-write
>>>>>>> user_brightness file.
>>>>>>>
>>>>>>> The write behavior would be 100% identical to the brightness
>>>>>>> file (in code terms it will call the same store function).
>>>>>>>
>>>>>>> The the read behavior otoh will be different: it will shows
>>>>>>> the last brightness as set by the user, this would show the
>>>>>>> read behavior we really want of brightness: show the real
>>>>>>> brightness when not blinking / triggers are active and show
>>>>>>> the brightness used when on when blinking / triggers are active.
>>>>>>>
>>>>>>> We could then add poll support on this new user_brightness
>>>>>>> file, thus avoiding the problem with the extra cpu-load on
>>>>>>> notifications on blinking / triggers.
>>>>>>
>>>>>> I agree that user_brightness allows to solve the issues you raised
>>>>>> about inconsistent write and read brightness' semantics
>>>>>> (which is not that painful IMHO).
>>>>>>
>>>>>> Reporting non-user brightness changes on user_brightness file
>>>>>> doesn't sound reasonable though.
>>>>>
>>>>> The changes I'm interested in are user brightness changes they
>>>>> are just not done through sysfs, but through a hardwired hotkey,
>>>>> they are however very much done by the user.
>>>>
>>>> Ah, so this file name would be misleading especially taking into
>>>> account
>>>> the context in which "user" is used in kernel, which predominantly
>>>> means "userspace", e.g. copy_to_user(), copy_from_user().
>>>>
>>>>>> Also, how would we read the
>>>>>> brightness set by the firmware? We'd have to read brightness
>>>>>> file, so still two files would have to be opened which is
>>>>>> a second drawback of this approach.
>>>>>
>>>>> No, look carefully at the definition of the read behavior
>>>>> I plan to put in the ABI doc:
>>>>
>>>> OK, "user" was what confused me. So in this case changes made
>>>> by the firmware even if in a result of user activity
>>>> (pressing hardware key) obviously cannot be treated similarly
>>>> to the changes made from the userspace context.
>>>
>>> In the end both result on the brightness of the device
>>> changing, so any userspace process interested in monitoring
>>> the brightness will want to know about both type of changes.
>>>
>>>> Unless you're able to give references to the kernel code which
>>>> contradict my judgement.
>>>
>>> AFAIK the audio code will signal volume changes done by
>>> hardwired buttons the same way as audio changes done
>>> by userspace calling into the kernel. This also makes
>>> sense because in the end, what is interesting for a
>>> mixer app, is that the volume changed, and what the
>>> new volume is.
>>
>> OK, so it is indeed similar to your LED use case. Nonetheless
>> in case of LED controllers it is also possible that hardware
>> adjusts LED brightness in case of low battery voltage.
>>
>> If a device is able e.g. to generate an interrupt to notify this
>> kind of event, then we would like also to be able to notify the client
>> about that. It wouldn't be user generated brightness change though.
>>
>>>>> "Reading this file will return the actual led brightness
>>>>> when not blinking and no triggers are active; reading this
>>>>> file will return the brightness used when the led is on
>>>>> when blinking or triggers are active."
>>>>
>>>> This is unnecessarily entangled. Blinking means timer trigger
>>>> is active.
>>>
>>> Ok.
>>>
>>>>> So for e.g. the backlit keyboard case reading this single
>>>>> file will return the actual brightness of the backlight,
>>>>> since this does not involve blinking or triggers.
>>>>>
>>>>> Basically the idea is that the user_brightness file
>>>>> will have the semantics which IMHO the brightness file
>>>>> itself should have had from the beginning, but which
>>>>> we can't change now due to ABI reasons.
>>>>
>>>> And in fact introducing user_brightness file would indeed
>>>> fix that shortcoming. However without providing notifications
>>>> of hw brightness changes on it.
>>>
>>> See above, I believe such a file should report any
>>> changes in brightness, except those caused by triggers,
>>> so it would report hw brightness changes.
>>>
>>> Anyways if you're not interested in fixing the
>>> shortcomings of the current read behavior on the
>>> brightness file (I'm fine with that, I can live
>>> with the shortcomings) I suggest that we simply go
>>> with v2 of my poll() patch.
>>
>> v2 entails power consumption related issues.
>>
>> Generally I think that we could add the file you proposed,
>> however it would be good to devise a name which will cover
>> also the cases when brightness is changed by firmware without
>> user interaction.
>>
>>>>>> Having no difference in this area between the two approaches
>>>>>> I'm still in favour of the read-only file for notifying
>>>>>> brightness changes procured by hardware.
>>>>>
>>>>> That brings back the needing 2 fds problem; and does
>>>>> not solve userspace not being able to reliably read
>>>>> the led on brightness when blinking or using triggers.
>>>>>
>>>>> And this also has the issue that one is doing poll() on
>>>>> one fd to detect changes on another fd,
>>>>
>>>> It is not necessarily true. We can treat the polling on
>>>> hw_brightness_change file as a means to detect brightness
>>>> changes procured by hardware and we can read that brightness
>>>> by executing read on this same fd. It could return -ENODATA
>>>> if no such an event has occurred so far.
>>>
>>> That would still require 2 fds as userspace also wants to
>>> be able to set the keyboard backlight, but allowing read()
>>> on the hw_brightness_change file at least fixes the weirdness
>>> where userspace gets woken from poll() without being able to
>>> read. So if you insist on going the hw_brightness_change file
>>> route, then I can live with that (and upower will simply
>>> need to open 2 fds, that is doable).
>>>
>>> But, BUT, I would greatly prefer to just go for v4 of my
>>> patch, which fixes the only real problem we've seen with
>>> my patch as original merged without adding a new, somewhat
>>> convoluted sysfs attribute.
>>
>> Hmm, v4 still calls led_notify_brightness_change(led_cdev)
>> from both __led_set_brightness() and __led_set_brightness_blocking().
>
> Ugh, I see I accidentally send a v4 twice, instead of
> calling the version which dropped those called v5 as
> I should have, sorry.
>
> The v4 which I would like to see merged, the one with
> those calls dropped, is here:
>
> https://patchwork.kernel.org/patch/9423093/

Right I've had an impression that I've already seen something
different than "first" v4.

Regarding the patch - adding led_notify_brightness_change() to
brightness_store() can have similar power consumption related
implications if brightness is set frequently via sysfs. I'm leaning
towards adding a new brightness file similar to user_brightness
discussed in this thread.

It would cover shortcomings and read/write inconsistencies that
brightness file currently has, but without breaking existing users.

I'd not however go for "user_brightness" name due to the possible
brightness adjustments made autonomously by firmware. I'm afraid
that devising a meaningful name for the new file will be hard,
so the simplest would be just brighntess2. Dedicated section
in leds-class.txt should be devoted to it.

-- 
Best regards,
Jacek Anaszewski
