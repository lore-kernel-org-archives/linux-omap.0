From: Kevin Hilman <khilman@linaro.org>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Thu, 08 May 2014 15:15:23 -0700
Message-ID: <7hha4zsyro.fsf@paris.lan>
References: <536B7E44.2040303@ti.com> <7hppjos2w2.fsf@paris.lan>
	<CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
	<20140508165558.GB2198@atomide.com>
	<20140508184055.GC2198@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60813 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbaEHWPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 18:15:25 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so3465034pab.11
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2014 15:15:25 -0700 (PDT)
In-Reply-To: <20140508184055.GC2198@atomide.com> (Tony Lindgren's message of
	"Thu, 8 May 2014 11:40:56 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, "Menon, Nishanth" <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Paul Burton <paul.burton@imgtec.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Tony Lindgren <tony@atomide.com> writes:

[...]

> ..but I think I found the cause for recent hangs on panda, just a wild
> guess based on looking at the recent cpuidle patches after v3.14.
>
> Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
> until all coupled CPUs leave idle) makes booting work reliably again
> on panda.
>
> Can you guys confirm, so far no issues here after few boot tests,
> but it might be too early to tell.

Reverting that makes things a bit more stable, but it still eventually
fails in the same way.  For me it took 8 boots for it to eventually
fail.

However, if I build with CONFIG_CPU_IDLE=n, it becomes much more stable
(20+ boots in a row and still going.)

Kevin




