From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Tue, 15 Feb 2011 08:15:20 -0800
Message-ID: <87ei79uvdz.fsf@ti.com>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
	<87pqqy6tdj.fsf@ti.com> <20110214131750.GA2869@arm.com>
	<alpine.LFD.2.00.1102140950580.14920@xanadu.home>
	<20110214153726.GA20144@arm.com> <87zkpyxl64.fsf@ti.com>
	<AANLkTinz1055v7x0y2W_AYkbj+9h7z_cGtF4xn4=pkQ7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35712 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392Ab1BOQPZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 11:15:25 -0500
Received: by mail-qw0-f52.google.com with SMTP id 4so249454qwi.11
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 08:15:24 -0800 (PST)
In-Reply-To: <AANLkTinz1055v7x0y2W_AYkbj+9h7z_cGtF4xn4=pkQ7@mail.gmail.com>
	(Dave Martin's message of "Tue, 15 Feb 2011 10:45:16 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org

Dave Martin <dave.martin@linaro.org> writes:

> On Mon, Feb 14, 2011 at 11:15 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>> Hi Dave,
>>
>> Dave Martin <dave.martin@linaro.org> writes:
>>
>>> On Mon, Feb 14, 2011 at 10:00:23AM -0500, Nicolas Pitre wrote:
>>>> On Mon, 14 Feb 2011, Dave Martin wrote:
>>>>
>>>> > @@ -289,8 +297,20 @@ clean_l2:
>>>> > =C2=A0 =C2=A0 * =C2=A0- should be faster and will change with ke=
rnel
>>>> > =C2=A0 =C2=A0 * =C2=A0- 'might' have to copy address, load and j=
ump to it
>>>> > =C2=A0 =C2=A0 */
>>>> > +#ifdef CONFIG_THUMB2_KERNEL
>>>> > + =C2=A0/* kernel is non-interworking : must do this from Thumb =
*/
>>>> > + =C2=A0adr =C2=A0 =C2=A0 r1, . + 1
>>>> > + =C2=A0bx =C2=A0 =C2=A0 =C2=A0r1
>>>> > + =C2=A0.thumb
>>>> > +#endif
>>>> > =C2=A0 =C2=A0ldr =C2=A0 =C2=A0 r1, kernel_flush
>>>>
>>>> Didn't you mean this instead:
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0/* kernel is non-interworking : must do this f=
rom Thumb */
>>>> =C2=A0 =C2=A0 =C2=A0adr =C2=A0 =C2=A0 r1, 1f + 1
>>>> =C2=A0 =C2=A0 =C2=A0bx =C2=A0 =C2=A0 =C2=A0r1
>>>> =C2=A0 =C2=A0 =C2=A0.thumb
>>>> 1: =C2=A0 ldr =C2=A0 =C2=A0 r1, kernel_flush
>>>> =C2=A0 =C2=A0 =C2=A0...
>>>
>>> Note that this is intended as an experimental hack, not a real patc=
h
>>> (apologies if I didn't make that clear...)
>>>
>>> Well, actually I meant "add r1, pc, #1" ... which means I was too
>>> busy trying to be clever... oops!
>>>
>>> That is of course exactly equivalent to your code...
>>>
>>>>
>>>> ?
>>>>
>>>> > =C2=A0 =C2=A0blx =C2=A0 =C2=A0 r1
>>>> > +#ifdef CONFIG_THUMB2_KERNEL
>>>> > + =C2=A0.align
>>>> > + =C2=A0bx =C2=A0 =C2=A0 =C2=A0pc
>>>> > + =C2=A0nop
>>>> > + =C2=A0.arm
>>>>
>>>> Also here, the .align has the potential to introduce a zero halfwo=
rd in
>>>> the instruction stream before the bx. =C2=A0What about:
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0adr =C2=A0 =C2=A0 r3, 1f
>>>> =C2=A0 =C2=A0 =C2=A0bx =C2=A0 =C2=A0 =C2=A0r3
>>>> =C2=A0 =C2=A0 =C2=A0.align
>>>> =C2=A0 =C2=A0 =C2=A0.arm
>>>> 1: =C2=A0 ...
>>>
>>> .align inserts a 16-bit nop when misaligned in Thumb in a text sect=
ion,
>>> and a word-aligned bx pc is a specific architecturally allowed way
>>> to do an inline switch to ARM. =C2=A0The linker uses this trick for=
 PLT
>>> veneers etc.
>>>
>>> A nicer fix for doing this sort of call from low-level code which
>>> might be ARM is to convert arch/arm/mm/*-v7.S to use "bx lr" to ret=
urn.
>>>
>>> Generally, we can do this for all arches >=3D v5, without any
>>> incompatibility. =C2=A0However, since the need for it will be rare =
and it
>>> will generate patch noise for not much real benefit,
>>> I haven't proposed this.
>>>
>>> Updated patch below.
>>
>> I tested the updated patch on top of your "dirty" branch I tested wi=
th
>> last week, and now see off-mode working just fine.
>
> Thanks for testing-- that's great news.
>
> I will have a think about whether the patch can be tidied up to rever=
t
> most of the code back to Thumb, though that isn't essential.  If I've
> understood what's going on correctly, I think only the restore entry
> points, SMC call sites and the entry to omap3_sram_configure_core_dpl=
l
> could need to be ARM; the rest shouldn't really make any difference..=
=2E

Yes, that sounds right.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
