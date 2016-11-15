From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PM regression with LED changes in next-20161109
Date: Tue, 15 Nov 2016 11:09:24 +0100
Message-ID: <92b05254-fbb9-c5ed-b0b9-94a1bea872b1@redhat.com>
References: <20161109192301.GS26979@atomide.com>
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
 <6d88b2a7-a506-89bf-fc76-af707ed7a00f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <6d88b2a7-a506-89bf-fc76-af707ed7a00f@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 15-11-16 11:01, Jacek Anaszewski wrote:
> Hi,
>
> On 11/14/2016 01:51 PM, Hans de Goede wrote:

<snip>

>> Ugh, I see I accidentally send a v4 twice, instead of
>> calling the version which dropped those called v5 as
>> I should have, sorry.
>>
>> The v4 which I would like to see merged, the one with
>> those calls dropped, is here:
>>
>> https://patchwork.kernel.org/patch/9423093/
>
> Right I've had an impression that I've already seen something
> different than "first" v4.
>
> Regarding the patch - adding led_notify_brightness_change() to
> brightness_store() can have similar power consumption related
> implications if brightness is set frequently via sysfs.

That means that userspace is waking up frequently to write the
sysfs file, so in that case userspace is already draining
a lot of energy, so I don't think that is something we need to
worry about.

> I'm leaning
> towards adding a new brightness file similar to user_brightness
> discussed in this thread.
>
> It would cover shortcomings and read/write inconsistencies that
> brightness file currently has, but without breaking existing users.
>
> I'd not however go for "user_brightness" name due to the possible
> brightness adjustments made autonomously by firmware. I'm afraid
> that devising a meaningful name for the new file will be hard,
> so the simplest would be just brighntess2. Dedicated section
> in leds-class.txt should be devoted to it.

Ok, let me quote myself from another part of this thread:

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

non_transient_brightness certainly seems like a better name
then brightness2 ?

Regards,

Hans
