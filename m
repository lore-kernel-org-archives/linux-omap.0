From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work withCONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 14:55:04 +0000
Message-ID: <AANLkTin4oiDGqMJqjYO+5pCM4MffiGiTEKW5WxXx9gfg@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
	<AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
	<AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
	<AANLkTi=7MXKUwjyPgDBO9XV-CZw7RNOmWKj0JP_kB9aC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56325 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab0LGOzF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 09:55:05 -0500
Received: by ywl5 with SMTP id 5so6745552ywl.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 06:55:04 -0800 (PST)
In-Reply-To: <AANLkTi=7MXKUwjyPgDBO9XV-CZw7RNOmWKj0JP_kB9aC@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 7, 2010 at 2:53 PM, Dave Martin <dave.martin@linaro.org> wr=
ote:
[...]
> Note that converting to C doesn't mean that code which attempts to
> copy function bodies will work: you still need to handle the fact tha=
t
> if f() is a C function symbol, then the value of the symbol f is
> actually the function's base address + 1. =A0See my changes in sram.c=
,

To clarify, this applies *if* f is a Thumb symbol.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
