From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Three different LED brightnesses (was Re: PM regression with LED
 changes in next-20161109)
Date: Sun, 13 Nov 2016 10:44:47 +0100
Message-ID: <3a3bb3f8-e54a-e7d0-da30-7f90b00c29b3@redhat.com>
References: <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd> <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd> <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd> <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <20161111221224.GB10983@amd>
 <3ca04742-6376-5a88-8d10-5b88fcd8f5e5@redhat.com>
 <20161113091054.GA17790@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20161113091054.GA17790@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 13-11-16 10:10, Pavel Machek wrote:
> On Sat 2016-11-12 09:03:42, Hans de Goede wrote:
>> Hi,
>>
>> On 11-11-16 23:12, Pavel Machek wrote:
>>> Hi!
>>>
>>> Reason #1:
>>>
>>>>>> Hmm. So userland can read the LED state, and it can get _some_ value
>>>>>> back, but it can not know if it is current state or not.
>>
>> That is not correct, the current behavior for eading the brightness
>> atrribute is to always return the current state.
>
> No. (Because some hardware can't get back current state of
> hardware-controlled leds, and because of blinking).
>
>>>> Why a dedicated file? Are we going to mirror brightness here
>>>> wrt r/w (show/store) behavior ? If not userspace now needs
>>>> 2 open fds which is not really nice. If we are and we are
>>>> not going to use poll for something else on brightness itself
>>>> then why not just poll directly on brightness ?
>>>
>>> Reason #1 is above.
>>
>> See my reply above.
>>
>>> Reason #2 is "if userspace sees brightness file, it can not know if
>>> the notifications on change actually work or not".
>>
>> If it needs to know that it can simply check the kernel version.
>
> No. Because in case of hardware blinking we can't provide poll()
> functionality.

We have already decided that we do not want to wakeup poll()
on blinking because it causes to many wakeups, and there is
no use-case for waking poll for blinking (or for triggers).

> Plus, saying "simply check the kernel version" simply means you should
> not be submitting patches to kernel... at all. (Hint... it also does
> not work.)

Lets keep things civil please.

>>> Reason #3 is that you broke Tony's system. Polling does not make sense
>>> when trigger such as "CPU in use" is active.
>>
>> Have you seen v4 of my patch? It fixes this while keeping the
>> polling on the brightness attribute itself, it basically goes
>> back (more or less) to v1 of my patch which did not have this
>> problem. I never wanted notification of trigger / blinking
>> changes because I already feared Tony's problem would happen.
>
> Have you seen v67123 of my latest facebook post? It explains why you
> are completely wrong.

Lets keep things civil please.

>>> Reason #4 is that there are really two brightnesses:
>>>
>>> 1) maximum brightness trigger is going to use
>>>
>>> 2) current brightness
>>>
>>> Currently writing to "brightness" file changes 1), but reading returns
>>> 2) when available.
>>
>> Right and Jacek has already said that we cannot change the
>> reading behavior on the brightness file because of ABI concerns.
>
> Until there's user that actually reads that, ABI can be fixed. Given
> that it basically returns random value,

Jacek has pretty much nacked fixing this because of ABI concerns,
so I see no use in further discussing changing the read behavior
of the existing brightness sysfs attribute.

>>> So, feel free to propose better interface. One that solves #1..#4
>>> above.
>>
>> Proposal 1:
>>
>> v4 of my patch, see the list. It solves all but #4, which
>> is out of scope for my patch, feel free to submit a patch to
>> solve #4 (with a new sysfs attr).
>
> NAK on that. (And it does not solve #1 and #2 at least.)
>
>> Proposal 2:
>>
>> Add a new "user_brightness" file, which shows the last brightness
>> as set by the user, this would show the read behavior we really
>> want of brightness: show the real brightness when not blinking /
>> triggers are active, show the brightness used when on when
>> blinking / triggers are active.
>
> No, that's just adding more mess on the system.
>
> Here's better proposal:
>
> brightness (write): what we do today. (Mess, but too late to change it)
> 	   (read): -Esomething or what we do today (if someone
> 	   	   	       	       	  	   acutally uses it)

As said Jacek has already nacked any changes to read behavior.

>            (poll): -Esomething

Making poll() on sysfs attributes return -Esomething is not possible,
the internal sysfs API does not allow this.

> current_brightness (write): -Esomething, or maybe change brightness
> 		   for triggers that can work with that
>               (read, poll): if the current trigger can get current
> 	             state of led, do it, otherwise -Esomething...
> 		     or maybe file should be simply hidden from sysfs.

So write is -EINVAL and read is the same as what brightness currently does,
so I see no use in introducing this new file.

Also this reintroduces all the issues of v2 of my poll() patch since the
CPU load problem is not actually in waking up userspace, it is in
even checking if there are any userspace waiters. TLDR we simply cannot
have poll behavior where we need to try and wakeup userspace on
every blink / every time a trigger triggers.

> trigger_max_brightness (read,write): change the maximum brightness for
> 		       a trigger.
> 	       (poll): -Esomething

The write behavior here is the same as what brightness currently does
and the read behavior is that of what I suggested for user_brightness,
minus that you've not definied the read behavior for when no trigger /
blinking is active.

In itself I would be fine with this file to work around the read
behavior of trigger_max_brightness, but you've not solved the
polling problem.

We've 2 sorts of brightness really:

1) transient brightness, aka current brightness, when blinking or
triggers are used this will switch many times a second
between off and some on level.

2) non-transient brightness, for non blinking leds this is the
actual brightness, for blinking leds this is the brightness
level used when the led is on.

Now we want to have a sysfs attribute reflecting 2, so that
userspace can poll on that, both for my use-case as well as so
that userspace process a can detect changes made by writing to
the brightness file by process b.

So maybe we need to simply call the new attribute
non_transient_brightness instead of user_brightness?

> If you have hardware changing the brightness behind kernel's back,
> that should be modelled as a trigger. Userspace should know
> there's hardware changing it autonomously ... there should be
> "hardware-keylight-brightness" trigger, probably impossible to change
> (depends on hardware behaviour).
>
> On thinkpad, for example, for many LEDs kernel can select either
> "hardware drives the LED", but then current_brightness is unavailable,
> or "kernel drives the LED", but then hardware does not touch the led
> at all.

Whether or not the hardware changing the brightness behind kernel's
should be modeled as a trigger is really outside of the scope of
this discussion, as it is not related to the issues with the
brightness atrribute / polling on the brightness attribute.

Regards,

Hans
