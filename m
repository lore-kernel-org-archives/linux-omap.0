From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 2/4] omap device tree fixes for v3.14 merge window
Date: Tue, 14 Jan 2014 14:30:30 -0800
Message-ID: <877ga26vsp.fsf@linaro.org>
References: <20140109011940.GI31323@atomide.com>
	<20140109012053.GJ31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41831 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaANWad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 17:30:33 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb1so257783pad.14
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 14:30:32 -0800 (PST)
In-Reply-To: <20140109012053.GJ31323@atomide.com> (Tony Lindgren's message of
	"Wed, 8 Jan 2014 17:20:54 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit adfe9361b236154215d4b0fc8b6d79995394b15c:
>
>   ARM: dts: Add basic devices on am3517-evm (2013-12-08 14:15:46 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/dt-signed
>
> for you to fetch changes up to e37e1cb0ee231ffdc9b5ef1da63a0c7e1077c603:
>
>   ARM: dts: OMAP2: fix interrupt number for rng (2014-01-08 10:24:44 -0800)
>
> ----------------------------------------------------------------
> Split omap3 core padconf area into two as some of the registers in
> the padconf area are not accessible and used for other devices.
> Also fix the interrupt number for omap2 RNG, and add basic support
> for sbc-3xxx with cm-t3730.
>
> Note that the minor merge conflicts for omap_hwmod_2xxx_ipblock_data.c
> can be solved by just dropping the legacy hwmod data for interrupts
> for v3.14.
>
> ----------------------------------------------------------------

Applying to next/fixes-non-critical.

Kevin
