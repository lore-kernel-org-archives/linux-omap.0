From: Tony Lindgren <tony@atomide.com>
Subject: Clock Regression in next-20150130 caused by cb75a8fcd14e
Date: Fri, 30 Jan 2015 17:04:44 -0800
Message-ID: <20150131010443.GE16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Looks like commit cb75a8fcd14e ("clk: Add rate constraints to clocks")
causes a regression on at least omaps where the serial console either
does not show anything, or just prints garbage.

Reverting cb75a8fcd14e makes things work again on next-20150130.

Any ideas?

Regards,

Tony
