From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] clk: ti: Add support for dm814x ADPLL
Date: Fri, 11 Dec 2015 16:14:50 +0000
Message-ID: <20151211161450.GH30871@n2100.arm.linux.org.uk>
References: <1449800792-5551-1-git-send-email-tony@atomide.com>
 <20151211135237.GG30871@n2100.arm.linux.org.uk>
 <20151211154854.GK23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151211154854.GK23396@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Philipp Rosenberger <ilu@linutronix.de>, Brian Hutchinson <b.hutchman@gmail.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 11, 2015 at 07:48:54AM -0800, Tony Lindgren wrote:
> There's a problem with MAX_CON_ID 16 hardcoded allocated name length.

Absolutely right...

> In this case I have 13 instances of plls with 3 - 4 outputs each and I'd
> like to use "481c5040.adpll.clkout" style naming starting with the instance
> address. Also "adpll5.clkdcoldo" style naming would work,

Because it's a connection ID, not a clock _name_.  I see that we're still
making all the same mistakes with clocks that were made years ago, and
which lead down the path of amazingly complex drivers having conditional
clock names and the like.

Is there a reason why you can't split this into separate device and input
names, and use clk_get_sys() rather than passing NULL as the device to
clk_get().  This is exactly why we've ended up with clk_get_sys(), to
cater for the cases where there is no struct device to associate with the
connection ID: the idea behind clk_get_sys() is that you pass the device
name explicitly, along with the connection ID.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
