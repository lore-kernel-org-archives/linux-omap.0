From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Sun, 13 Nov 2016 12:44:05 +0100
Message-ID: <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11/12/2016 10:14 PM, Hans de Goede wrote:
> Hi,
>
> On 12-11-16 20:14, Jacek Anaszewski wrote:
>
> <snip>
>
>>>>> Why a dedicated file? Are we going to mirror brightness here
>>>>> wrt r/w (show/store) behavior ? If not userspace now needs
>>>>> 2 open fds which is not really nice. If we are and we are
>>>>> not going to use poll for something else on brightness itself
>>>>> then why not just poll directly on brightness ?
>>>>
>>>> My main concern is that reporting only hw brightness changes
>>>> wouldn't be consistent with general brightness file purpose.
>>>> One could expect that brightness changes made by triggers
>>>> should be also reported.
>>>
>>> Ok, I agree that not notifying poll() while an actual
>>> read() would result in a different value is not really good
>>> semantics.
>>>
>>> I don't like to call it hw_brightness_change though, as
>>> mentioned before I believe that if we were to start with
>>> a clean slate we would make the brightness file's read/write
>>> behavior more a mirror of itself.
>>>
>>> So I would like to propose creating a new read-write
>>> user_brightness file.
>>>
>>> The write behavior would be 100% identical to the brightness
>>> file (in code terms it will call the same store function).
>>>
>>> The the read behavior otoh will be different: it will shows
>>> the last brightness as set by the user, this would show the
>>> read behavior we really want of brightness: show the real
>>> brightness when not blinking / triggers are active and show
>>> the brightness used when on when blinking / triggers are active.
>>>
>>> We could then add poll support on this new user_brightness
>>> file, thus avoiding the problem with the extra cpu-load on
>>> notifications on blinking / triggers.
>>
>> I agree that user_brightness allows to solve the issues you raised
>> about inconsistent write and read brightness' semantics
>> (which is not that painful IMHO).
>>
>> Reporting non-user brightness changes on user_brightness file
>> doesn't sound reasonable though.
>
> The changes I'm interested in are user brightness changes they
> are just not done through sysfs, but through a hardwired hotkey,
> they are however very much done by the user.

Ah, so this file name would be misleading especially taking into account
the context in which "user" is used in kernel, which predominantly
means "userspace", e.g. copy_to_user(), copy_from_user().

>> Also, how would we read the
>> brightness set by the firmware? We'd have to read brightness
>> file, so still two files would have to be opened which is
>> a second drawback of this approach.
>
> No, look carefully at the definition of the read behavior
> I plan to put in the ABI doc:

OK, "user" was what confused me. So in this case changes made
by the firmware even if in a result of user activity
(pressing hardware key) obviously cannot be treated similarly
to the changes made from the userspace context.

Unless you're able to give references to the kernel code which
contradict my judgement.

>
> "Reading this file will return the actual led brightness
> when not blinking and no triggers are active; reading this
> file will return the brightness used when the led is on
> when blinking or triggers are active."

This is unnecessarily entangled. Blinking means timer trigger
is active.

> So for e.g. the backlit keyboard case reading this single
> file will return the actual brightness of the backlight,
> since this does not involve blinking or triggers.
>
> Basically the idea is that the user_brightness file
> will have the semantics which IMHO the brightness file
> itself should have had from the beginning, but which
> we can't change now due to ABI reasons.

And in fact introducing user_brightness file would indeed
fix that shortcoming. However without providing notifications
of hw brightness changes on it.

>> Having no difference in this area between the two approaches
>> I'm still in favour of the read-only file for notifying
>> brightness changes procured by hardware.
>
> That brings back the needing 2 fds problem; and does
> not solve userspace not being able to reliably read
> the led on brightness when blinking or using triggers.
>
> And this also has the issue that one is doing poll() on
> one fd to detect changes on another fd,

It is not necessarily true. We can treat the polling on
hw_brightness_change file as a means to detect brightness
changes procured by hardware and we can read that brightness
by executing read on this same fd. It could return -ENODATA
if no such an event has occurred so far.

> which is completely
> unheard of in any kernel API, so I still vote NACK for the
> entire idea of having a different file purely for notifying
> changes. The way unix defines poll to work means that the
> poll() and read() must be on the same fd, anything else
> does not make sense.

-- 
Best regards,
Jacek Anaszewski
