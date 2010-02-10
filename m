From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] dspbridge: Simplify Atoi() method
Date: Wed, 10 Feb 2010 09:59:23 +0200
Message-ID: <5ec8ebd51002092359v740d4e6asb0b6bab0d069c687@mail.gmail.com>
References: <1265192086-15633-1-git-send-email-andy.shevchenko@gmail.com>
	 <4B7213C1.1040300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:58918 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0BJH7Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 02:59:25 -0500
Received: by ewy28 with SMTP id 28so4714786ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 09 Feb 2010 23:59:23 -0800 (PST)
In-Reply-To: <4B7213C1.1040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Feb 10, 2010 at 4:02 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
>> Try to use simple_strtol() kernel native method instead.
> strtol or strtoul?
I don't know for sure, see below.

>> However, there are opened questions:
>> =C2=A0- why type of Atoi() is s32 if the sign is used only to detect=
 base?
This is the question about l vs ul.

>> + =C2=A0 =C2=A0 =C2=A0 } else if (*pch&& =C2=A0(pch[strlen(pch) - 1]=
 | 0x20 =3D=3D 'h')) {
>
> perhaps tolower(x)
Yep, I saw only internal macro in lib/vsprintf.c, but totally forgot
about ctype.h.

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
