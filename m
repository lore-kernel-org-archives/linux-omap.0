From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 19:15:40 +0100
Message-ID: <AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
	<1290091906-32539-2-git-send-email-j-pihet@ti.com>
	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
	<87tyjey6h3.fsf@deeprootsystems.com>
	<4CE55A88.6010300@ti.com>
	<20101118175215.GE9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48532 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730Ab0KRSPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 13:15:42 -0500
Received: by pxi15 with SMTP id 15so842883pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 10:15:42 -0800 (PST)
In-Reply-To: <20101118175215.GE9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

On Thu, Nov 18, 2010 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Nishanth Menon <nm@ti.com> [101118 08:46]:
>>
>> But after wfi in wait_sdrc_ok as part of the code executing in SRAM
>> today omap34xx_cpu_suspend -> we are waiting for DPLL3 lock prior to
>> accessing DDR -> how do we execute that logic in SDRAM?
> I too am a bit concerned how this will all keep working. For light
> testing it may be running OK if it happens to run from cache..

As Vishwa pointed out, when going out of OFF mode the SRAM and the
caches are lost.
That means the low power mode _has to_ rely on SDRAM at wake-up.

About the DPLL lock:
1) wait_sdrc_ok is only called when back from the non-OFF modes,
2) I checked that when running wait_sdrc_ok the CORE is already out of
idle and the DPLL is already locked. Note: l-o code has no support for
the voltages OFF and the external clocks OFF.

What to conclude from 1) and 2)? In my test setup ot looks like
wait_sdrc_ok is of no use, but I agree this a premature conclusion.

> Also, moving the code out of SRAM will limit the options for what we
> may need to do with DDR or L3.
What are the options? All the executable code runs from DDR anyway.

> Retention is something to consider, are there issues with that?
No issue so far. See the points 1) and 2) here above.

>
> Regards,
>
> Tony
>

Jean
