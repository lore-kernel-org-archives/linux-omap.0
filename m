From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Fri, 6 Sep 2013 11:50:29 -0700
Message-ID: <CA+Bv8XYz-xP9Lrv_nX+ZDV3bA=d9s_hK_-rZtMtepSKxHmF4hQ@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
	<52278F84.2080509@elopez.com.ar>
	<CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
	<20130906111408.GI25647@n2100.arm.linux.org.uk>
	<20130906164059.GC3558@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:64546 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab3IFSua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 14:50:30 -0400
Received: by mail-qe0-f46.google.com with SMTP id x7so1897986qeu.5
        for <linux-omap@vger.kernel.org>; Fri, 06 Sep 2013 11:50:29 -0700 (PDT)
In-Reply-To: <20130906164059.GC3558@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "mans@mansr.com" <mans@mansr.com>, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2013 at 9:40 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Sep 06, 2013 at 12:14:08PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Sep 04, 2013 at 02:47:51PM -0700, Russ Dill wrote:
>> > I think this is already taken care of by the way sram.c is using
>> > genalloc. The allocation returned should be aligned to 32 bytes. The
>> > thumb bit shouldn't be an issue as code is copied based on the start
>> > and end makers made by the linker. I may need to add .align statements
>> > in the linker so that the start and end markers for the copied code
>> > are aligned to at least 8 bytes.
>>
>> I think you need to read up on what fncpy does... there's more to it
>> than just merely copying code at an appropriate alignment.
>
> The technique of putting each loadable blob in a specific vmlinux
> section, and then adjusting entry-point symbols by adding/subtracting
> the appropriate offset, probably does work.
>
> This relies on the functions' code alignment requirement being
> honoured by both the vmlinux link map, and the allocator used to find
> SRAM space to copy the functions to.
>
> Searching the entire list of known blobs every time we want to convert
> a symbol seems unnecessary though.  Surely the caller could know the
> blob<->symbol mapping anyway?

It doesn't search the list of known blobs, only loaded blobs. On all
the platforms I'm aware of, only one SRAM section is loaded with code.

> One thing fncpy() doesn't provide is a way to copy groups of functions
> that call each other, if vmlinux needs to know about any symbol other
> than the one at the start.  We might need a better mechanism if that is
> needed.
>
>
> I actually wonder whether fncpy() contains a buglet, whereby
> flush_icache_range() is used instead of coherent_kern_range().
> The SRAM is probably not mapped cached, but at least a DSB would be
> needed before flushing the relevant lines from the I-cache.

It is mapped cached on most platforms.

> However, flush_icache_range() seems to be implemented by a call to
> coherent_kern_range() anyway, so perhaps that's not a problem.
>
> Cheers
> ---Dave
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
