From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Sat, 12 Nov 2016 20:14:41 +0100
Message-ID: <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 11/12/2016 11:33 AM, Hans de Goede wrote:
> Hi,
>
> On 12-11-16 11:24, Jacek Anaszewski wrote:
>> Hi,
>>
>> On 11/11/2016 08:28 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11-11-16 18:03, Jacek Anaszewski wrote:
>>>> On 11/11/2016 01:01 PM, Pavel Machek wrote:
>>>>> On Thu 2016-11-10 22:34:07, Jacek Anaszewski wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 11/10/2016 09:29 PM, Pavel Machek wrote:
>>>>>>> On Thu 2016-11-10 10:55:37, Tony Lindgren wrote:
>>>>>>>> * Pavel Machek <pavel@ucw.cz> [161110 09:29]:
>>>>>>>>> Hi!
>>>>>>>>>
>>>>>>>>>>>>> Looks like commit 883d32ce3385 ("leds: core: Add support for
>>>>>>>>>>>>> poll()ing
>>>>>>>>>>>>> the sysfs brightness attr for changes.") breaks runtime PM
>>>>>>>>>>>>> for me.
>>>>>>>>>>>>>
>>>>>>>>>>>>> On my omap dm3730 based test system, idle power consumption
>>>>>>>>>>>>> is over 70
>>>>>>>>>>>>> times higher now with this patch! It goes from about 6mW for
>>>>>>>>>>>>> the core
>>>>>>>>>>>>> system to over 440mW during idle meaning there's some busy
>>>>>>>>>>>>> timer now
>>>>>>>>>>>>> active.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reverting this patch fixes the issue. Any ideas?
>>>>>>>>>
>>>>>>>>> Are you using any LED that toggles with high frequency? Like
>>>>>>>>> perhaps
>>>>>>>>> LED that is lit when CPU is active?
>>>>>>>>
>>>>>>>> Yeah one of them seems to have cpu0 as the default trigger.
>>>>>>>
>>>>>>> Aha. Its quite obvious we don't want to notify sysfs each time that
>>>>>>> one is toggled, right?
>>>>>>>
>>>>>>> IMO brightness should display max brightness for the trigger, as
>>>>>>> Hans
>>>>>>> suggested, anything else is madness for trigger such as cpu
>>>>>>> activity.
>>>>>>
>>>>>> Are you suggesting that we should revert changes introduced
>>>>>> by below patch?
>>>>>>
>>>>>> commit 29d76dfa29fe22583aefddccda0bc56aa81035dc
>>>>>> Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>>>>>> Date:   Tue Mar 18 09:47:48 2008 +0000
>>>>>>
>>>>>>     leds: Add support to leds with readable status
>>>>>>
>>>>>>     Some led hardware allows drivers to query the led state, and
>>>>>> this patch
>>>>>>     adds a hook to let the led class take advantage of that
>>>>>> information when
>>>>>>     available.
>>>>>>
>>>>>>     Without this functionality, when access to the led hardware is
>>>>>> not
>>>>>>     exclusive (i.e. firmware or hardware might change its state
>>>>>> behind the
>>>>>>     kernel's back), reality goes out of sync with the led class'
>>>>>> idea of
>>>>>> what
>>>>>>     the led is doing, which is annoying at best.
>>>>>
>>>>> Hmm. So userland can read the LED state, and it can get _some_ value
>>>>> back, but it can not know if it is current state or not.
>>>>>
>>>>> I don't think that's a good interface. I see it is from 2008... is
>>>>> someone using it? Maybe it is too late for revert.
>>>>
>>>> I can imagine it being used in flash LED use case. E.g. one
>>>> could use oneshot trigger to trigger flash strobe, and then
>>>> he could periodically read brightness file to check, for whatever
>>>> reason, whether the flash is strobing.
>>>>
>>>>> But I'd certainly not extend it with poll.
>>>>
>>>> We could add a dedicated file e.g. hw_brightness_change for that
>>>> (maybe someone will have a better candidate for the file name).
>>>
>>> Why a dedicated file? Are we going to mirror brightness here
>>> wrt r/w (show/store) behavior ? If not userspace now needs
>>> 2 open fds which is not really nice. If we are and we are
>>> not going to use poll for something else on brightness itself
>>> then why not just poll directly on brightness ?
>>
>> My main concern is that reporting only hw brightness changes
>> wouldn't be consistent with general brightness file purpose.
>> One could expect that brightness changes made by triggers
>> should be also reported.
>
> Ok, I agree that not notifying poll() while an actual
> read() would result in a different value is not really good
> semantics.
>
> I don't like to call it hw_brightness_change though, as
> mentioned before I believe that if we were to start with
> a clean slate we would make the brightness file's read/write
> behavior more a mirror of itself.
>
> So I would like to propose creating a new read-write
> user_brightness file.
>
> The write behavior would be 100% identical to the brightness
> file (in code terms it will call the same store function).
>
> The the read behavior otoh will be different: it will shows
> the last brightness as set by the user, this would show the
> read behavior we really want of brightness: show the real
> brightness when not blinking / triggers are active and show
> the brightness used when on when blinking / triggers are active.
>
> We could then add poll support on this new user_brightness
> file, thus avoiding the problem with the extra cpu-load on
> notifications on blinking / triggers.

I agree that user_brightness allows to solve the issues you raised
about inconsistent write and read brightness' semantics
(which is not that painful IMHO).

Reporting non-user brightness changes on user_brightness file
doesn't sound reasonable though. Also, how would we read the
brightness set by the firmware? We'd have to read brightness
file, so still two files would have to be opened which is
a second drawback of this approach.

Having no difference in this area between the two approaches
I'm still in favour of the read-only file for notifying
brightness changes procured by hardware.

>> I'd make it only readable, so it wouldn't mirror brightness
>> file behavior.
>
> Then userspace which wants to be able to read + write + poll
> the brightness again needs to open 2 fds, as suggested
> above for the new user_brightness file it will be easy
> to just make it mimic the brightness file write behavior
> and then userspace only needs to open one fd.
>
> Regards,
>
> Hans
>
>
>
>
>>
>> Its purpose would be clear: notify hw brightness changes
>> and provide the brightness value that was set by the hardware
>> last time. It implies that this value could be different from
>> the one the brightness file reports. E.g. hw could have changed
>> brightness, which could be later updated through brightness
>> file, but hw_brightness_change would still report brightness level
>> that was set by the hardware last time. It could be useful
>> e.g. in case of showing the difference between the desired
>> value and the currently allowed configuration (e.g. if the
>> firmware automatically adjusted the value set by the user).
>>
>

-- 
Best regards,
Jacek Anaszewski
