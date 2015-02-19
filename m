From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 19 Feb 2015 21:25:49 +0100
Message-ID: <CAALWOA_XkYmHx_uLo9MgX7Eec2Yrx1eooe=QE2=8whV=woP-Zw@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com> <201502191920.41284@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47018 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbBSU0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 15:26:10 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so50827637wid.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2015 12:26:09 -0800 (PST)
In-Reply-To: <201502191920.41284@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 18 February 2015 at 22:14, Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> Can you help us with above problem? How to catch external abort
> on non-linefetch in kernel driver and prevent kernel panic?

Actually it's a synchronous bus error that you want to catch, which
however is misreported by linux as "external abort on non-linefetch"
(... but a bus error on a linefetch would produce exactly the same
error).  Also, ARM apparently uses the term "external abort" as
umbrella term for aborts triggered outside the MMU, which includes not
just bus errors but also (uncorrectable) parity/ECC errors.

Anyhow, the core question you mean to ask is: can the "exception"
mechanism current already in place to trap MMU faults in e.g.
put_user() easily be extended to allow drivers to trap synchronous bus
errors?  My impression is that this would in fact be quite easy and I
even outlined a suggested patch, but I'm still a kernel newbie so I
may be way off course.

Although its main use would be for auto-probing, it's maybe worth
mentioning I've met at least one peripheral which also reports bus
errors when writing inappropriate/unsupported *values* to a register.
(Of course when using posted writes you won't get an abort anyhow in
that case, it's only reported via interconnect error logs.)


On 19 February 2015 at 19:20, Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> Anyway, in Nokia Harmattan N9/N950 2.6.32 kernel is this patch

In mainline linux the same fix-up is done at runtime rather than
compile time (in exceptions_init() at the bottom of fault.c). Either
way, in my post of the 11th I also mentioned that it looks wrong to
me. I-cache maintenance fault is really a special case in the fault
decoding logic since it means "although you got here via DAbort and
the relevant address is in DFAR, the exception happened on the
instruction side so you need to fetch the fault status from IFSR
instead."
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
