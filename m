From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 0/0] RFC: ARM: Thumb-2: Symbol manipulation macros for
 function body copying
Date: Wed, 12 Jan 2011 10:00:25 -0600
Message-ID: <AANLkTimB1dcK=F1bFh6bUtBPY0gk+Y+Y0SQqrSRW0YFa@mail.gmail.com>
References: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
	<20110112093209.GA18833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53274 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1ALQA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 11:00:27 -0500
Received: by ewy5 with SMTP id 5so312231ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 08:00:26 -0800 (PST)
In-Reply-To: <20110112093209.GA18833@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi,

On Wed, Jan 12, 2011 at 3:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 11, 2011 at 06:02:30PM -0600, Dave Martin wrote:
>> To make it easier to deal with cases like this, I've had a
>> go at writing some macros to make copying function bodies
>> easier, while being robust for ARM and Thumb-2.
>
> How about instead providing some infrastructure which coes the
> copy too? =A0Something like:
>
> #define copy_fn_to_sram(to, fn, size) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0\
> =A0 =A0 =A0 =A0__typeof__(fn) f; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0unsigned long ptr; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0__asm__("" : "=3Dr" (ptr) : "0" (fn)); =A0 =A0 =A0 =A0=
 =A0 =A0\
> =A0 =A0 =A0 =A0memcpy(to, (void *)(ptr & ~1), size); =A0 =A0 =A0 =A0 =
=A0 \
> =A0 =A0 =A0 =A0ptr =3D (ptr & 1) | (unsigned long)to; =A0 =A0 =A0 =A0=
 =A0 =A0\
> =A0 =A0 =A0 =A0__asm__("" : "=3Dr" (f) : "0" (ptr)); =A0 =A0 =A0 =A0 =
=A0 =A0 \
> =A0 =A0 =A0 =A0f; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> })

omap provides some infrastructure for both allocating SRAM space and
doing the copy, using omap_sram_push() and friends.  So I wasn't sure
what the correct level of abstraction was for the new helpers.
Certainly, providing a sort of "function memcpy" macro like your
copy_fn_to_sram makes sense.  I think this should still be safe from a
type system perspective: providing the "blind" type casts using asm()
appear somewhere in the execution flow C shouldn't make silly
assumptions even if Linux ends up enabling multifile optimisation
sometime in the future.

Would you agree with that assertion?

>
> Used by:
> extern void my_func(int foo);
> extern int my_func_size;

Potentially, we could define, an extra assembler macro to complement
ENDPROC() which records the size of a function automatically.  What do
you think?

>
> void call_my_func(void *to, int arg)
> {
> =A0 =A0 =A0 =A0void (*fn)(int);
>
> =A0 =A0 =A0 =A0fn =3D copy_fn_to_sram(to, my_func, my_func_size);
> =A0 =A0 =A0 =A0fn(arg);
> }
>
> Then if you need to fix the way the copies are done for some
> architectural reason, there's only one place to do it.

The model used in the omap code is to copy some functions into SRAM
ahead of time and stash the pointers away to be called later: for that
model, it's not so useful to have something like call_my_func
directly.  Also, I wasn't sure whether conflating other functionality
such as cache flushing into the new macros would be a good idea -- is
might be cleaner and more maintainable, but might result in less
efficient usage.  Any thoughts?

>
> I'm not sure asm/unified.h is the right place - I don't think this ha=
s
> anything to do with the unified assembler syntax. =A0Please create a =
new
> header for this.

I suspected unified.h might not be right--- thanks for the feedback.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
