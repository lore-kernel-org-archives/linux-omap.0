From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Mon, 1 Jun 2015 22:32:47 +0200
Message-ID: <CAALWOA8swU+wRrg8NnFDoKMEEsfKAE=u7ZiQE3X5BvRKLOjNmg@mail.gmail.com>
References: <201502112128.44852@pali> <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali> <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com> <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
 <CAALWOA82=QmTpCeiceOFQOjqXKdSBjB3Z+jL-mi0vYF=QaL4sA@mail.gmail.com>
 <20150529155030.GO30984@atomide.com> <CAALWOA-X-Jb_2NODrPNnDgaLuYFDuxjPLHYwqRjaPz2PrqhJkA@mail.gmail.com>
 <20150601175806.GZ30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37356 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbbFAUdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 16:33:10 -0400
In-Reply-To: <20150601175806.GZ30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

On 1 June 2015 at 19:58, Tony Lindgren <tony@atomide.com> wrote:
> I think these kernels are missing the configuration for l3-noc
> driver?

Yup. Since I'm pretty sure I have all the necessary info I was hoping
look into that... somewhere in my copious spare time...

> I tried it on omap4 that has l3-noc configured, and it first produces
> "Unhandled fault: external abort on non-linefetch (0x1818) at 0xb6fd7000",

(Though making a patch to fix that annoyingly wrong and useless
message is higher on my list of priorities)

> and the L3 interrupt only after that. So yeah, you're right, we can't
> use the interrupts here. I somehow remembered we'd get only the L3
> interrupt if configured.

The bus error is not influenced by L3 error reporting config afaik,
and it will always win from the irq: even though the irq is almost
certainly asserted first, it can't be taken until the load/store
instruction completes, and then the fault will take precedence.

While implementing L3 error reporting in my forth system I ran into a
tricky scenario though: it turns out that if an irq occurs while the
cpu is waiting for instruction fetch, it does allow the irq to be
taken. The interrupted fetch is abandoned and any bus error it may
have produced is ignored since exception entry/exit is an implicit
instruction sync barrier. On return it is simply refetched...

Hence, the result from attempting to execute code from an invalid address:
  fetching from [invalid]
    irq entry (LR=[invalid])
    L3 error displayed
    irq exit
  fetching from [invalid]
    irq entry (LR=[invalid])
    L3 error displayed
    irq exit
  fetching from [invalid]
    ...
(repeat until watchdog expires)


Anyhow, so we still have the puzzling fact that apparently neither of
us was expecting device memory to use a strongly-ordered mapping,
getting a bus error on a write (outside MPUSS itself) shows that it
does.

I've tried to read arch/arm/mm/mmu.c to find out why, but so far I'm
feeling hopelessly lost there... (the multitude of ARM architecture
versions/flavors supported aren't helping.)
