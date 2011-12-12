From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Interrupt issue in twl4030_keypad
Date: Mon, 12 Dec 2011 22:55:11 +0200
Message-ID: <CAMP44s1X_KDbzu2CLO0fzM=7rozTQ4K10AtQkc0Ww8uDg8Z-mw@mail.gmail.com>
References: <CAMP44s2xhZaoM4KVT0jC5RpdW7Ezp9YAHMG1pC+30Bbqjno7jg@mail.gmail.com>
	<20111212191241.GC3408@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20111212191241.GC3408@legolas.emea.dhcp.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 12, 2011 at 9:12 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Dec 12, 2011 at 08:30:49PM +0200, Felipe Contreras wrote:
>> The short version is this: either we revert this patch[1], or we apply
>> this patch series[2], as well as its essential fixes[3].
>>
>> The long version is this. There's a synchronization issue with the
>> current keypad driver and twl core; the irq is marked as handled even
>> though the thread that is supposed to handle it hasn't run yet, and
>> since it's clear-on-read, and it hasn't been read, it's detected
>> again, so they keypad driver receives two interrupt callbacks instead
>> of one, and in the second one reads nothing from the i2c register, so
>> a key release is assumed. This makes key-presses as simple as shift+a
>> impossible.
>>
>> In other words, it's totally unreliable. This might not be isolated to
>> the keypard driver, but other "nested" interrupts from twl core that
>> started using request_threaded_irq prematurely (before it was
>> supported by the twl core). But at least I haven't tried those.
>>
>> This patch was applied on 2.6.33, which means all versions before 3.2
>> are affected, including 3.1.
>>
>> What do you think about fixing this on stable kernels?
>
> I believe Samuel has already applied those to the MFD tree.

Yeap, I think Linus' tree is going to be fine (3.2), but I'm trying to
find out what to do with previous kernels: as in, what should be done
for stable trees.

> The funny part is that those patches were pending on linux-omap for over 2
> months I have refreshed them over and over again and asked for help from
> other people to test.

You mean these patches? [1] There's nothing wrong with pushing them
forward, but I'm actually talking about this one [2].

> Everything went smooth on my simple beagle board with no keypad and I
> couldn't see any issues, unfortunately.

That's because you didn't get a single interrupt. You could have added
a BUG() on handle_twl4030_pih() and you still wouldn't have noticed
anything.

> Still, 2 months is a whole lot of time to NAK a patch, but nobody said
> anything so, of course,

It's actually almost 2 years :)

> Samuel assumed it was ok and, like I said above, it worked for my simple GPIO
> usecase with beagleboard.

Well, for 3.2 I think the situation is fine, but that's not what I'm
talking about. About your GPIO tests, are you sure you got the
interrupts through twl4030 irq handling?

Cheers.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/59958
[2] http://article.gmane.org/gmane.linux.kernel/932255

-- 
Felipe Contreras
