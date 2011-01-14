From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 1/1 v2] ARM: Thumb-2: Symbol manipulation macros for
 function body copying
Date: Fri, 14 Jan 2011 11:15:19 -0600
Message-ID: <AANLkTikiR+XN4Jb9GSEdUUiOciLvxqXB+NA3DEWhNCga@mail.gmail.com>
References: <1294951905-23748-1-git-send-email-dave.martin@linaro.org>
	<1294951905-23748-2-git-send-email-dave.martin@linaro.org>
	<20110113235524.GB28040@n2100.arm.linux.org.uk>
	<AANLkTi=QRDt62wgnHW6ya+956BS9x7pQj2voTiF+H0vs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55796 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784Ab1ANRPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 12:15:21 -0500
Received: by eye27 with SMTP id 27so1530663eye.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 09:15:19 -0800 (PST)
In-Reply-To: <AANLkTi=QRDt62wgnHW6ya+956BS9x7pQj2voTiF+H0vs@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi again,

There's another problem which I hadn't spotted before:

In the Thumb case, we risk violating the alignment constraints of the
code which gets copied (actually, this is also true of the ARM case,
but less likely to bite).  This matters because the code may contain
literals and other data words -- quite likely given the requirement
for self-containedness.

In the simplest case, we could just require the caller to ensure that
there are is at least size+2 bytes of space at dest_buf: then we can
actually copy the function to dest_buf+2 if this is needed to preserve
word alignment.  But this does make the API harder to use.  For
Thumb-2, at least word alignment is always needed, even if the start
address of the function is only halfword-aligned, because of the way
literals are addressed.

There could also be a need for alignment greater than word alignment
in some cases; for example, where ldrd/strd or some hardware operation
needs an aligned buffer.  This would be rarer though; perhaps we could
get away without it.

We could provide a helper to determine how much space to request from
the allocator:

dest_size =3D fncpy_size(function, size_of_function, alignment);
dest_buf =3D allocate(dest_size);
fncpy(dest_buf, &function, size_of_function, alignment);

If we don't know what alignment guarantee is provided by the allocator
itself, we might have to define this conservatively, e.g.:

size_t fncpy_size(function, size_of_function, alignment)
{
    return size_of_function + alignment - 1;
}

=2E..to guarantee the possibility of rounding the copied function
address up far enough to achieve the required alignment without
overrunning the buffer.  Of course, we can probably get simpler that
that...

Any thoughts?

Cheers
---Dave

On Fri, Jan 14, 2011 at 9:42 AM, Dave Martin <dave.martin@linaro.org> w=
rote:
> On Thu, Jan 13, 2011 at 5:55 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Jan 13, 2011 at 02:51:45PM -0600, Dave Martin wrote:
>>> +/* Cast function pointer to integer: */
>>> +#define __funcp_to_uint(funcp) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\
>>
>> uint is confusing here - it suggests casting a pointer to an unsigne=
d int,
>> rather than a uintptr_t. =A0Please use uintptr here.
>>
>>> +/*
>>> + * FSYM_REBASE: Determine the correct function pointer for funcp,
>>> + * after the function has been copied to dest_buf:
>>> + */
>>> +#define FSYM_REBASE(funcp, dest_buf) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 __uint_to_funcp((uintptr_t)(dest_buf) | FSYM_TYPE(funcp),=
 funcp)
>>> +
>>> +/*
>>> + * FSYM_BASE: Determine the base address in memory of the function=
 funcp
>>> + * FSYM_TYPE: Determine the instruction set type (ARM/Thumb) of fu=
ncp
>>> + * (both defined below)
>>> + */
>>> +
>>> +#ifdef CONFIG_THUMB2_KERNEL
>>> +#define FSYM_BASE(funcp) ((void *)(__funcp_to_uint(funcp) & ~(uint=
ptr_t)1))
>>> +#define FSYM_TYPE(funcp) (__funcp_to_uint(funcp) & 1)
>>> +#else /* !CONFIG_THUMB2_KERNEL */
>>> +#define FSYM_BASE(funcp) ((void *)__funcp_to_uint(funcp))
>>> +#define FSYM_TYPE(funcp) 0
>>> +#endif /* !CONFIG_THUMB2_KERNEL */
>>
>> I'd really like to see these gone - otherwise they'll end up being u=
sed
>> in code inappropriately. =A0I like things to be kept as simple as po=
ssible
>> with as few opportunities for people to needlessly hook into interna=
l
>> implementation details.
>>
>> If you expose implementation details, people will use them, and then=
 if
>> you need to change the implementation, you've got a lot of code to d=
eal
>> with.
>
> I guess I agree with that now ... with fncpy() implemented, there's
> little legitimate use for the other macros, including the casting
> macros.
>
> I'll fold it all into fncpy() and see how that looks.
>
>>
>> I don't think we need to make this conditional on THUMB2 either - we=
're
>> probably not wasting much by always clearing and copying the LSB. =A0=
And
>> this isn't particularly performance code.
>>
>
> Agreed. =A0I originally tried to avoid impacting the ARM case, but th=
at
> adds complexity for little benefit.
>
> Cheers
> ---Dave
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
