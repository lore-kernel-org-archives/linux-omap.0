From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 1/1 v2] ARM: Thumb-2: Symbol manipulation macros for
 function body copying
Date: Fri, 14 Jan 2011 11:59:54 -0600
Message-ID: <AANLkTinZsBqAYeXfV5o3asL5Vd5EhCo-+nvw3sb21KLj@mail.gmail.com>
References: <1294951905-23748-1-git-send-email-dave.martin@linaro.org>
	<1294951905-23748-2-git-send-email-dave.martin@linaro.org>
	<20110113235524.GB28040@n2100.arm.linux.org.uk>
	<AANLkTi=QRDt62wgnHW6ya+956BS9x7pQj2voTiF+H0vs@mail.gmail.com>
	<AANLkTikiR+XN4Jb9GSEdUUiOciLvxqXB+NA3DEWhNCga@mail.gmail.com>
	<20110114174339.GC22505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39228 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802Ab1ANR74 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 12:59:56 -0500
Received: by eye27 with SMTP id 27so1570281eye.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 09:59:55 -0800 (PST)
In-Reply-To: <20110114174339.GC22505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 11:43 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 11:15:19AM -0600, Dave Martin wrote:
>> There's another problem which I hadn't spotted before:
>>
>> In the Thumb case, we risk violating the alignment constraints of th=
e
>> code which gets copied (actually, this is also true of the ARM case,
>> but less likely to bite). =A0This matters because the code may conta=
in
>> literals and other data words -- quite likely given the requirement
>> for self-containedness.
>
> There's a solution to this - require that the thumb function is
> preceded by a .align 3 (which according to the GAS documentation I
> have means for ARM, it aligns the PC to 1 << 3 not 3 bytes.)
>
> Also require 8-byte alignment from the allocation function, and make
> fncpy() bug if the destination isn't 8-byte aligned. =A0Same for the
> source function argument (but ignoring bit 0 of course.)
>
> We don't then have to mess with rounding allocation sizes up, nor wor=
ry
> about aligning the destination according to the source or any other
> games like that.
>
> The down-side is wastage of maybe 7 bytes a function, but that's
> probably going to happen anyway.
>

OK, that sounds like a practical compromise.

I'll roll this in and repost the patch.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
