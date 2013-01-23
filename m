From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 1/2] clk: divider: prepare for minimum divider
Date: Wed, 23 Jan 2013 13:40:53 -0800
Message-ID: <20130123214053.9205.49804@quantum>
References: <6dc1c48cac5b2646a55da3079afb72f88e40c3bc.1358937138.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:52811 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3AWVk6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 16:40:58 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so4942113pbb.10
        for <linux-omap@vger.kernel.org>; Wed, 23 Jan 2013 13:40:58 -0800 (PST)
In-Reply-To: <6dc1c48cac5b2646a55da3079afb72f88e40c3bc.1358937138.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>

Quoting Afzal Mohammed (2013-01-23 03:38:52)
> Some of clocks can have a limit on minimum divider value that can be
> programmed, prepare for such a support.
> 
> Add a new field min_div for the basic divider clock and a new dynamic
> clock divider registration function where minimum divider value can
> be specified. Keep behaviour of existing divider clock registration
> functions, static initialization helpers as was earlier.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Hi Afzal,

I'd like to understand this a bit better.  At first the need for a
minimum divider makes a lot of sense, but I want to make sure it gets
designed correctly.

My first question is whether the minimum divider you plan to use is an
actual constraint of the hardware (e.g. the clock controller ip only
lets program two bits which divide by 4, 5, 6 or 7, where 4 is the
minimum divider) or if this is a functional constraint (e.g. the clock
hardware can divide by a lower value, but you never want that since it
results in non-functional video/audio/whatever).  If this is more of a
functional constraint then perhaps a new api like clk_set_min_rate makes
more sense.

Secondly, have you looked into using the rate-table option provided by
the basic divider clock?  Can you explain how this is not a good fit for
your needs?  Perhaps there are too many divisor values so the table
would be large?

Thanks,
Mike
