From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function
 body copying
Date: Mon, 17 Jan 2011 16:48:02 +0100
Message-ID: <AANLkTik4Q9f4t_CrNxcov+iSnpNkZ-KeGZJPcKuQvj2G@mail.gmail.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
	<AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
	<AANLkTin6gfN6hpExQ0iof14Hy7_MmaOdgpgS2OgyZOLd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54881 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab1AQPsE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 10:48:04 -0500
Received: by qyk12 with SMTP id 12so5878924qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 07:48:03 -0800 (PST)
In-Reply-To: <AANLkTin6gfN6hpExQ0iof14Hy7_MmaOdgpgS2OgyZOLd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Dave,

On Mon, Jan 17, 2011 at 4:35 PM, Dave Martin <dave.martin@linaro.org> w=
rote:
> Hi,
>
> On Mon, Jan 17, 2011 at 2:02 PM, Jean Pihet <jean.pihet@newoldbits.co=
m> wrote:
>
> [...]
>
>> Note that aligning the source and destination pointers to a multiple
>> of 8 bytes has an impact on the behavio(u)r and so must be carefully
>> thought and tested on OMAP1/2/3 platforms.
>
> Do you have any specific concerns regarding this?
>
> Currently, the only issue I can think of is that the need to allocate
> aligned memory from the SRAM will increase the total amount allocated=
,
> which could be a problem if we end up overflowing the available SRAM.
Agree. It does not look like there are SRAM overflows today. Note that
in that case you will get warned soon enough by the 'Not enough space
in SRAM' message.
One could think about some nasty side-effects bugs like badly written
PIC code, hardcoded addresses... that appear to work with the current
version. In short this needs to be thoroughly tested on OMAP1/2/3
platforms.

> This does not appear to happen in the case I've tested -- I currently
> round up the amount allocated in omap_sram_push to be a multiple of 8
> bytes. =A0This, combined with a couple of ".align 3" directives, is
> enough to get me a booting system on omap3... but I haven't tested
> exhaustively.
That is OK. I have a patch ready for OMAP1/2/3, tested on OMAP3 only.

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
