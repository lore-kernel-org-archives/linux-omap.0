From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Mon, 12 Nov 2012 17:33:41 -0600
Message-ID: <CAF6AEGtLKjJ=BfBnOq+oE6cgneF5YqsbYqNnCPrz4sTFRzdibg@mail.gmail.com>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
	<20121112192727.GB28341@n2100.arm.linux.org.uk>
	<CAF6AEGu4L+ukxhMBLYK3d2g4CBBXi6o5nN_wXvakZCT8qMfSEA@mail.gmail.com>
	<20121112230819.GC28341@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121112230819.GC28341@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 12, 2012 at 5:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 12, 2012 at 01:58:32PM -0600, Rob Clark wrote:
>> On Mon, Nov 12, 2012 at 1:27 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Nov 09, 2012 at 03:17:33PM -0600, Rob Clark wrote:
>> >> From: Rob Clark <rob@ti.com>
>> >>
>> >> A new atomic modeset/pageflip ioctl being developed in DRM requires
>> >> get_user() to work for 64bit types (in addition to just put_user()).
>> >
>> > NAK.
>> >
>> > (I did write a better email explaining all the ins and outs of why this
>> > won't work and why 64-bit get_user isn't possible, but my editor crapped
>> > out and lost all that well written message; I don't fancy typing it all
>> > out again.)
>> >
>> > Nevertheless,
>> > int test_ptr(unsigned int **v, unsigned int **p)
>> > {
>> >         return get_user(*v, p);
>> > }
>> >
>> > produces a warning, and you can't get away from that if you stick 64-bit
>> > support into get_user().
>>
>> Actually, it seems like using 'register typeof(x) __r2 asm("r2");'
>> does avoid that warning..
>
> That seems to pass the checks I've done on it so far, and seems rather
> obvious (there's been a number of people looking at this, none of whom
> have come up with that solution).  Provided the final cast is kept
> (which is there to ensure proper typechecking), it seems like it might
> be a solution.

I'm sort of thinking maybe we want to change 'switch (sizeof(*(__p)))'
with 'switch (sizeof(typeof(x)))' in case someone ignores the compiler
warning when they try something like:

   uint32_t x;
   uint64_t *p = ...;
   get_user(x, p);

that was my one concern about 'register typeof(x) __r2 ...', but I
think just changing the switch condition is enough.  But maybe good to
have some eyes on in case there is something else I'm not thinking of.

BR,
-R

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
