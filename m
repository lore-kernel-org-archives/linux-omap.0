From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Tue, 18 Jan 2011 13:05:49 +0100
Message-ID: <AANLkTikPm8_vxjF7P84q7kHq+XSvLyF+jToFt=COs8Mj@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
	<20110114173400.GB22505@n2100.arm.linux.org.uk>
	<AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
	<AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43503 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1ARMFt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 07:05:49 -0500
Received: by qyk12 with SMTP id 12so6921534qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 04:05:49 -0800 (PST)
In-Reply-To: <AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Dave, Russell,

On Mon, Jan 17, 2011 at 4:46 PM, Dave Martin <dave.martin@linaro.org> w=
rote:
> On Mon, Jan 17, 2011 at 2:01 PM, Jean Pihet <jean.pihet@newoldbits.co=
m> wrote:
>> On Fri, Jan 14, 2011 at 6:34 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Fri, Jan 14, 2011 at 05:13:01PM +0100, Jean Pihet wrote:
>>>> Is the name 'omap_sram_push' wrong then?
>>>> What about the following?
>>>> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned l=
ong size)
>>>>
>>>> =A0 =A0 =A0 =A0omap_sram_ceil -=3D size;
>>>> =A0 =A0 =A0 =A0omap_sram_ceil =3D ROUND_DOWN(omap_sram_ceil, sizeo=
f(void *));
>>>> =A0- =A0 =A0 memcpy((void *)omap_sram_ceil, start, size);
>>>> =A0- =A0 =A0 flush_icache_range((unsigned long)omap_sram_ceil,
>>>> =A0- =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(omap_sram_ceil + size=
));
>>>>
>>>> =A0- =A0 =A0 return (void *)omap_sram_ceil;
>>>> =A0+ =A0 =A0return fncpy((void *)omap_sram_ceil, start, size);
>>>
>>> It's more correct, but still missing out on the type safety which w=
e've
>>> tried to provide with fncpy.
>> IIUC the type of the function is propagated from the 2nd argument
>> (funcp) to the return value, which is fine here. The (void)* is here
>> only to avoid a warning thrown by memcpy.
>
> I think Russell's argument was that the compiler will not notice if
> you mismatch the return type and the function to be copied, because
> the casts to/from void * make the compiler blind to the real types
> involved. =A0So:
>
> int f(int);
> size_t size_of_f;
>
> void *buffer;
> int (*_copied_f1)(int);
> char *(*_copied_f2)(char *);
>
> _copied_f1 =3D fncpy(buffer, f, size_of_f); /* OK */
> _copied_f2 =3D fncpy(buffer, f, size_of_f); /* compile error */
> _copied_f1 =3D omap_sram_push(f, size_of_f); /* OK */
> _copied_f2 =3D opam_sram_push(f, size_of_f); /* type mismatch, but
> compilation succeeds */
>
>
> One way to work around this is would be to make omap_sram_push() a ma=
cro:
>
> #define omap_sram_push(funcp, size) \
> =A0 =A0(typeof(funcp))_do_omap_sram_push((void *)(funcp), size)
>
> ... where the definition of _do_omap_sram_push() is the same is the
> existing definition of omap_sram_push(). =A0Providing
> _do_omap_sram_push() is not called directly, this should now be
> type-safe.
>
Ok I reworked the patch from your suggestions. Indeed a few functions
types mismatch have been spotted and corrected using the fncpy API.

New patch sent as '[PATCH v2] OMAP: use fncpy to copy the PM code
functions to SRAM'.
>
> Cheers
> ---Dave
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
