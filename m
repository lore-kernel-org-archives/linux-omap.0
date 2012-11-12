From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Mon, 12 Nov 2012 13:58:32 -0600
Message-ID: <CAF6AEGu4L+ukxhMBLYK3d2g4CBBXi6o5nN_wXvakZCT8qMfSEA@mail.gmail.com>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
	<20121112192727.GB28341@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121112192727.GB28341@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 12, 2012 at 1:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 09, 2012 at 03:17:33PM -0600, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> A new atomic modeset/pageflip ioctl being developed in DRM requires
>> get_user() to work for 64bit types (in addition to just put_user()).
>
> NAK.
>
> (I did write a better email explaining all the ins and outs of why this
> won't work and why 64-bit get_user isn't possible, but my editor crapped
> out and lost all that well written message; I don't fancy typing it all
> out again.)
>
> Nevertheless,
> int test_ptr(unsigned int **v, unsigned int **p)
> {
>         return get_user(*v, p);
> }
>
> produces a warning, and you can't get away from that if you stick 64-bit
> support into get_user().

Actually, it seems like using 'register typeof(x) __r2 asm("r2");'
does avoid that warning..

I don't know if that was the only argument against 64-bit get_user().
But it will at least be inconvenient that get_user() works for 64bit
on x86 but not arm..

BR,
-R

> Sorry, 64-bit get_user() is a no-no.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
