From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Thu, 28 May 2015 14:43:30 +0300
Message-ID: <CANOLnOMYBFAr_t_tOs8ifo=ngtCrpyogtf_7hBDc4rmbC_-BQQ@mail.gmail.com>
References: <20150527215545.GA30984@atomide.com>
	<7h7frtmzoh.fsf@deeprootsystems.com>
	<20150527225553.GC30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:33688 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbbE1Lnb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 07:43:31 -0400
Received: by yhpn97 with SMTP id n97so9637595yhp.0
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2015 04:43:30 -0700 (PDT)
In-Reply-To: <20150527225553.GC30984@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@kernel.org>, Arnd Bergmann <arnd@arndb.de>, tyler.baker@linaro.org, Stephen Boyd <sboyd@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dave Martin <dave.martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 28, 2015 at 1:55 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> 8 <----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 27 May 2015 15:33:57 -0700
> Subject: [PATCH] ARM: OMAP3: Fix booting with thumb2 kernel
>
> We get a NULL pointer dereference on omap3 for thumb2 compiled kernel=
s:
>
> Internal error: Oops: 80000005 [#1] SMP THUMB2
> ...
> [<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
> (omap3_enter_idle_bm+0xc5/0x178)
> [<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
> (cpuidle_enter_state+0x77/0x27c)
> [<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
> (cpu_startup_entry+0x155/0x23c)
> [<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
> (start_kernel+0x32f/0x338)
> [<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)
>
> The power management related assembly on moaps needs to interact with

moaps -> omaps


Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
