From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] clk: Add functions to save and restore clock/dpll
 context en-masse
Date: Wed, 3 May 2017 19:52:51 +0100
Message-ID: <20170503185251.GR23750@n2100.armlinux.org.uk>
References: <1492492369-19662-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492492369-19662-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: sboyd@codeaurora.org, t-kristo@ti.com, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 18, 2017 at 10:42:49AM +0530, Keerthy wrote:
> From: Russ Dill <Russ.Dill@ti.com>
> 
> The clock/dpll registers are in the WKUP power domain. Under both RTC-only
> suspend and hibernation, these registers are lost. Hence save/restore
> them accordingly.

This looks like a huge hammer, and I think this will cause problems for
some systems, especially where some clocks are on remote devices which
need to be controlled via I2C buses.

The generic part walks all root clocks in the system, and all children
of those clocks.  If we have clocks on an I2C device, then we could
very well end up with a circular dependency - the I2C controller needs
its clocks restored in order for control of the clocks on the I2C device
to be accessible.

So, I think this needs more thought - clocks are not just about core SoC
clocks - and cracking this nut with such a big hammer is likely to cause
regressions all over the place.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
