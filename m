From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] mm/migrate: Mark unmap_and_move() "noinline" to avoid ICE
 in gcc 4.7.3
Date: Thu, 2 Apr 2015 14:12:28 -0700
Message-ID: <CAMAWPa_P5JFQsrL96KPnt0gu=P4O40cGbWkM1j6b6HGy4edErQ@mail.gmail.com>
References: <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
	<20150327002554.GA5527@verge.net.au>
	<20150327100612.GB1562@arm.com>
	<7hbnj99epe.fsf@deeprootsystems.com>
	<CAKv+Gu_ZHZFm-1eXn+r7fkEHOxqSmj+Q+Mmy7k6LK531vSfAjQ@mail.gmail.com>
	<7h8uec95t2.fsf@deeprootsystems.com>
	<alpine.DEB.2.10.1504011130030.14762@ayla.of.borg>
	<551BBEC5.7070801@arm.com>
	<20150401124007.20c440cc43a482f698f461b8@linux-foundation.org>
	<7hwq1v4iq4.fsf@deeprootsystems.com>
	<20150402191230.GA24219@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150402191230.GA24219@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nishanth Menon <nm@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Tyler Baker <tyler.baker@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 2, 2015 at 12:12 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Wed, Apr 01 2015 at 15:57 -0600, Kevin Hilman wrote:
>>
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>
>>> On Wed, 01 Apr 2015 10:47:49 +0100 Marc Zyngier <marc.zyngier@arm.com>
>>> wrote:
>>>
>>>> > -static int unmap_and_move(new_page_t get_new_page, free_page_t
>>>> > put_new_page,
>>>> > -                     unsigned long private, struct page *page, int
>>>> > force,
>>>> > -                     enum migrate_mode mode)
>>>> > +static noinline int unmap_and_move(new_page_t get_new_page,
>>>> > +                                free_page_t put_new_page,
>>>> > +                                unsigned long private, struct page
>>>> > *page,
>>>> > +                                int force, enum migrate_mode mode)
>>>> >  {
>>>> >       int rc = 0;
>>>> >       int *result = NULL;
>>>> >
>>>>
>>>> Ouch. That's really ugly. And on 32bit ARM, we end-up spilling half of
>>>> the parameters on the stack, which is not going to help performance
>>>> either (not that this would be useful on 32bit ARM anyway...).
>>>>
>>>> Any chance you could make this dependent on some compiler detection
>>>> mechanism?
>>>
>>>
>>> With my arm compiler (gcc-4.4.4) the patch makes no difference -
>>> unmap_and_move() isn't being inlined anyway.
>>>
>>> How does this look?
>>>
>>> Kevin, could you please retest?  I might have fat-fingered something...
>>
>>
>> Your patch on top of Geert's still compiles fine for me with gcc-4.7.3.
>> However, I'm not sure how specific we can be on the versions.
>>
>> /me goes to test a few more compilers...   OK...
>>
>> ICE: 4.7.1, 4.7.3, 4.8.3
>> OK: 4.6.3, 4.9.2, 4.9.3
>>
>> The diff below[2] on top of yours compiles fine here and at least covers
>> the compilers I *know* to trigger the ICE.
>
>
> I see ICE on arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.7.4-2ubuntu1) 4.7.4
>

Thanks for checking.  I'm assuming my patch fixes it for your since
that should catch any 4.7.x compiler.

Kevin
