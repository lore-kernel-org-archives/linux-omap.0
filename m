From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Clock Regression in next-20150130 caused by cb75a8fcd14e
Date: Fri, 30 Jan 2015 21:31:05 -0800
Message-ID: <20150131053105.GA20944@roeck-us.net>
References: <20150131010443.GE16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150131010443.GE16250@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 30, 2015 at 05:04:44PM -0800, Tony Lindgren wrote:
> Hi all,
> 
> Looks like commit cb75a8fcd14e ("clk: Add rate constraints to clocks")
> causes a regression on at least omaps where the serial console either
> does not show anything, or just prints garbage.
> 
> Reverting cb75a8fcd14e makes things work again on next-20150130.
> 
> Any ideas?
> 
The patch seems to have some problems.
Also see http://www.spinics.net/lists/kernel/msg1916843.html.

Guenter
