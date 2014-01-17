From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 17 Jan 2014 09:46:14 -0800
Message-ID: <87r486mrh5.fsf@linaro.org>
References: <20140110161352.GG6665@saruman.home>
	<20140110185110.GM31323@atomide.com> <52D53084.1070105@ti.com>
	<20140114203613.GA604@saruman.home>
	<20140115020421.GA24195@saruman.home>
	<20140115031632.4167.2698@quantum> <20140115035011.4167.96678@quantum>
	<20140115171323.GA22739@atomide.com>
	<20140115192340.4167.87685@quantum>
	<20140115193547.GF7993@atomide.com>
	<20140116213954.4167.37071@quantum>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56161 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbaAQRqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 12:46:16 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so4377820pbb.37
        for <linux-omap@vger.kernel.org>; Fri, 17 Jan 2014 09:46:16 -0800 (PST)
In-Reply-To: <20140116213954.4167.37071@quantum> (Mike Turquette's message of
	"Thu, 16 Jan 2014 13:39:54 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, balbi@ti.com, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

Mike Turquette <mturquette@linaro.org> writes:

[...]

> I took Tony's advice and fast-forwarded clk-next to -rc7 and applied
> Tero's series. This includes the AM3517 bits now. I've pushed this
> branch to clk-next-omap (force update) on my Linaro mirror. Can you do a
> final sanity test before I merge this into clk-next?

I merged clk-next-omap into next-20140117 and build/boot tested
omap2plus_defconfig, multi_v7_defconfig and
multi_v7_defconfig+CONFIG_LPAE=y and all passed a basic boot test for
omap5uevm.

I'll add OMAP5 to the automated boot testing starting with the next
linux-next.

Kevin
