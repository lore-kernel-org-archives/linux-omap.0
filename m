From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Tue, 19 Apr 2011 03:23:11 +0200
Message-ID: <BANLkTikSfdUXmME8ao4GYtwgZNuZX9RLZg@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38212 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab1DSBXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 21:23:13 -0400
Received: by wwa36 with SMTP id 36so6372015wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 18:23:12 -0700 (PDT)
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2011/4/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
>
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.

Great initiative!

I'm thinking about how to unify this with the bits I have in kernel/tcm.c.

For TCM memory (cacheless, inside CPU core, controlled by CP15
registers to recap) we can compile plain C into that memory too, which
seems like a lot of these SRAM drivers actually want to do, but fail at
and instead write some assembler and copy it there.

The remainder of the TCM memory is put into an allocation pool
of uneven size, maybe that should reuse this mechanism instead
of rolling its own atleast.

On the odd PB11MPCore the TCM memories are NUMA, so one
on each CPU not reachable from other cores (like Magnus Damm
mentioned for SH-ARM) and I have no idea on how to handle that,
neither for an allocator nor for compiling code directly into it.
Suggestions welcome.

Linus Walleij
