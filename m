From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Wed, 13 May 2009 18:31:35 +0300
Message-ID: <94a0d4530905130831s447492b9ibd79eae271cd21dd@mail.gmail.com>
References: <94a0d4530905130413t5bddfee4le797c5083df79226@mail.gmail.com>
	 <20090513.143241.189725295.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905130550s657d9312g664efe6c418b2b61@mail.gmail.com>
	 <20090513.171849.260112797.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:13873 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719AbZEMPbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 11:31:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so246584fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 08:31:35 -0700 (PDT)
In-Reply-To: <20090513.171849.260112797.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, nm@ti.com, linux-omap@vger.kernel.org

On Wed, May 13, 2009 at 5:18 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
> Date: Wed, 13 May 2009 14:50:26 +0200
>
> [...]
>
>> >> >> If we are not going to have a read-only/write-only flag then I'm
>> >> >> against adding the alignment check. It will only force user-space to
>> >> >> do memory copies unnecessarily. That would kill performance
>> >> >> drastically. NAK!
>> >> >
>> >> > At least, better than allowing user to crash kernel.
>> >>
>> >> The kernel would crash even with that check because it's the software
>> >> running in the *DSP* side that is causing the corruption.
>> >>
>> >> It sounds you are still not convinced by that so I'll write a test
>> >> application to make sure my assumption is correct.
>> >
>> > You misunderstood.
>> >
>> > There are 2 patterns when kernel crashes from ARM cache flush and DSP
>> > cache flush(*1).
>>
>> Let's suppose that's true, if you enforce ARM cache flushes to be
>> aligned (pattern 1) the DSP cache flushes (pattern 2) can still
>> corrupt the memory. Therefore even with your check the potential for
>> memory corruption is still there.
>>
>> But it doesn't seem it's true; I modified my dsp-dummy test to detect
>
> We are not talking about the specific application program/case, but
> the general risk that kernel can be crashed by userland with incorrect
> parameters in dspbridge.

The purpose of the test application is to quickly test different
scenarios... tell me which scenario will trigger the corruption you
are talking about, and I'll modify the test app to reproduce it.

>> memory corruption by constantly modifying the data before and after
>> the buffer sent to the DSP. Map, Flush and Invalidate are unaligned in
>> the ARM side, and not surprisingly there's memory corruption. *But* if
>> I modify the DSP socket node to don't flush/invalidate the first/last
>> 128 bytes of the buffer then there's no memory corruption.
>>
>> So that's proof Flush/Invalidate on ARM side don't cause memory
>> corruption.
>
> No, the above doesn't prove that ARM side doesn't cause memory
> corruption(pattern 1).
>
> Currently dspbridge doesn't have any parameter checking/validation
> from "bridge_ioctl()" to "v7_dma_*_range()". *Any* value/address can
> be passed to "v7_dma_*_range()" from userland. It means that any data
> which resides on cache can be , for exmaple, invalidated by userland
> spontaneously. That is why I mentioned the necessity of "VMA" checking
> to prevent this.

If user-space manually invalidates some random memory areas
spontaneously what's the worst that could happen? Bad performance?

The problem with corruption is not the cache invalidation, it's the
contents of the main memory.

> For pattern 2, if a buffer is aligned on DSP cache size, then just
> adding VMA checking can prevent userland from corrupting other
> process/kernel address space. Also same kind of VMA checking for DSP
> mmaping can prevent other cases too. So I think that, at least, we can
> protect kernel address from crash with having VMA and alignment
> checking. I'll work on that if we can agree on this.

pattern 2 is triggered by the software running on the DSP. Why are you
talking about VMA stuff that happens in the linux kernel on *ARM*
side?

>> Do you want to see the code?
>
> Yes, I want!! it would be quite helpful to test something easily;)

Ok, I pushed a branch:
http://github.com/felipec/dsp-dummy/tree/corruption-test

Now, I ran a few more tests and it turns out 'pattern 2' is not enough
to trigger the corruption, but neither is 'pattern 1'. The corruption
happens only when both happen at the same time.

So, the DSP writes on a wrong memory area, then flushes the cache, so
it goes the main memory, but the ARM side already updated the memory
on it's cache and it's different from the main memory. Then ARM side
invalidates it's cache and *bang* the corruption happens.

Now is ARM cache invalidation the problem? No, it's the DSP cache
flush. Even if there isn't a manual ARM cache invalidation the cache
will receive the main memory update at some point, wouldn't it? Maybe
a cache miss.

-- 
Felipe Contreras
