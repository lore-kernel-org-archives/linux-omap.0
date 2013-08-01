From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
Date: Thu, 1 Aug 2013 10:13:56 -0500
Message-ID: <CAGo_u6oSUMN0LRCg+6MGpWQQKQ7qBPGkgZuffadH5wHmw-H-Cw@mail.gmail.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
	<1374564028-11352-4-git-send-email-t-kristo@ti.com>
	<51F7E883.7000000@ti.com>
	<51F8DCF8.2040309@ti.com>
	<51FA69E8.8000000@ti.com>
	<51FA79E0.2070605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:56332 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3HAPN6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 11:13:58 -0400
Received: by mail-we0-f169.google.com with SMTP id n5so1843075wev.28
        for <linux-omap@vger.kernel.org>; Thu, 01 Aug 2013 08:13:56 -0700 (PDT)
In-Reply-To: <51FA79E0.2070605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Thu, Aug 1, 2013 at 10:08 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> We should move the functions to this file instead and empty out
>> mach-omap2 gradually, omap_dpll.h should be exported and used by
>> mach-omap2, rather than the other way around.
>
>
> Yeah, the clock stuff should evolve and move here. I just need to start from
> somewhere.

yep, this step is good and as part of this step, moving the used
functions from mach-omap2 to dpll.c is indeed the right step for us to
do proper cleanup.

it is a question of what we bring into drivers/clk and ensuring what
we bring in is clean as well.

Regards,
Nishanth Menon
