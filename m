From: Mike Turquette <mturquette@linaro.org>
Subject: Re: Clock Regression in next-20150130 caused by cb75a8fcd14e
Date: Sun, 01 Feb 2015 15:26:36 -0800
Message-ID: <20150201232636.421.58980@quantum>
References: <20150131010443.GE16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:42811 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbBAX0k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Feb 2015 18:26:40 -0500
Received: by mail-ie0-f180.google.com with SMTP id rl12so14156397iec.11
        for <linux-omap@vger.kernel.org>; Sun, 01 Feb 2015 15:26:40 -0800 (PST)
In-Reply-To: <20150131010443.GE16250@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Quoting Tony Lindgren (2015-01-30 17:04:44)
> Hi all,
> 
> Looks like commit cb75a8fcd14e ("clk: Add rate constraints to clocks")
> causes a regression on at least omaps where the serial console either
> does not show anything, or just prints garbage.
> 
> Reverting cb75a8fcd14e makes things work again on next-20150130.
> 
> Any ideas?

Stephen posted a patch[0] to fix this. I've squashed that into Tomeu's
commit that you reference above and my Panda board is booting fine once
again.

[0] http://lkml.kernel.org/r/<20150131013158.GA4323@codeaurora.org>

Please let me know if any other issues pop up. There are new WARNs for
OMAP3+ boards introduced by a different patch from Tomeu, but this is
really because the OMAP DPLL and FAPLL code are dereferencing struct clk
pointers when they should not be and is a separate issue from the
constraints patch (with a separate email thread).

Regards,
Mike

> 
> Regards,
> 
> Tony
