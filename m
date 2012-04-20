From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] arm: omap: fix trivial warnings for dspbridge
Date: Sat, 21 Apr 2012 02:42:26 +0300
Message-ID: <CAMP44s25TuTrZ3C9SKjO73EtU9MT9EexKFA3p-=M_m2LGvxKbg@mail.gmail.com>
References: <1334959458-2873-1-git-send-email-felipe.contreras@gmail.com>
	<20120420233412.GD24205@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57780 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2DTXm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 19:42:27 -0400
Received: by wgbdr13 with SMTP id dr13so10114249wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 16:42:26 -0700 (PDT)
In-Reply-To: <20120420233412.GD24205@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, linux-arm-kernel@lists.infradead.org

On Sat, Apr 21, 2012 at 2:34 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> --- a/arch/arm/mach-omap2/dsp.c
>> +++ b/arch/arm/mach-omap2/dsp.c
>> @@ -57,8 +57,9 @@ static int __init omap_dsp_init(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (pdata->phys_mempool_base) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdata->phys_mempool=
_size =3D CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("%s: %x bytes @ =
%x\n", __func__,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pdata->phys_mempool_size, pdata->phys_mempool_base);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("%s: %llu bytes =
@ %llu\n", __func__,
>
> No, don't change a unprefixed hex number to a decimal number. =C2=A0K=
eep
> the same formatting, just fix the warning. =C2=A0Changing the base of=
 the
> displayed number when there's no hex prefix to it is just plain idiot=
ic
> and creates confusion. =C2=A0Think: is the number 12345678 output by =
one of
> these a hex number or a decimal number?
>
> Besides, base addresses _should_ be hex numbers. =C2=A0I'd agree that=
 sizes
> should probably be decimal, but as none of these locations you're fix=
ing
> had 0x prefixes, I'd strongly advise to leave them as-is - esp. for a
> patch allegedly just fixing warnings.

Right, I was too fast copying what Documentation/printk-formats.txt
suggested (%llu). So s/%llu/%llx/? I prefer to keep the size also as
hex, as it's usually how it's configured.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
