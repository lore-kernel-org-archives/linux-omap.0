From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Thu, 15 Nov 2012 07:46:04 -0600
Message-ID: <CAF6AEGuJReNtwUZX6HVZCE8GHuyEAyC8bM0GqZuVMV1=DrGJVw@mail.gmail.com>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
	<201211150919.37343.arnd@arndb.de>
	<CAF6AEGv-O_D6nOnEwi5w8NUcv+dQFe7pJBXhUA8xq+tykG4dfg@mail.gmail.com>
	<201211151339.08016.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201211151339.08016.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 15, 2012 at 7:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 November 2012, Rob Clark wrote:
>> On Thu, Nov 15, 2012 at 3:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 13 November 2012, Russell King - ARM Linux wrote:
>> >> You're missing something; that is one of the greatest powers of open
>> >> source.  The many eyes (and minds) effect.  Someone out there probably
>> >> has a solution to whatever problem, the trick is to find that person. :)
>> >>
>> >> I think we have a working solution for this for ARM.  It won't be suitable
>> >> for every arch, where they have 8-bit and 16-bit registers able to be
>> >> allocated by the compiler, but for architectures where the minimum register
>> >> size is 32-bit, what we have below should work.
>> >
>> > I don't mind at all adding the extension to ARM, and I think it's pretty
>> > cool that you guys actually found a working solution.
>> >
>> > The part that worries me is that we are making architecture independent
>> > code depend on a clever hack that may or may not be possible to implement
>> > on a given architecture, and that most architecture maintainers wouldn't
>> > know how to implement correctly even if it's possible.
>>
>> I could always send a 3rd version with a comment smashed on about why
>> that works if you think this is a problem..
>
> Comments are always good, so I'd surely like to see those get added.
> As I said, I don't have any objections to the addition of your patch to
> the ARM code, which sounds useful to have.

ok, I'll send a v3 w/ some additional comments

> I still haven't heard a conclusive argument why we need to use get_user()
> rather than copy_from_user() in the DRM code. Is this about a fast path
> where you want to shave off a few cycles for each call, or does this
> simplify the code structure, or something else?

well, it is mostly because it seemed like a good idea to first try to
solve the root issue, rather than having to fix things up in each
driver when someone from x86-world introduces a 64b get_user()..

There are some other arch's that don't have 64b get_user(), but I
don't think any that have any DRM drivers.  If 64b get_user() is
really not intended to be supported by all archs, it is better to
remove it from x86 and the other arch's that do currently support it,
rather than making it possible to write drivers that are broken on
some archs.

BR,
-R

>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
