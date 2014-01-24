From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] power_supply: Add inlmt,iterm, min/max temp props
Date: Fri, 24 Jan 2014 14:01:08 +0100
Message-ID: <20140124130108.GA18464@Nokia-N900>
References: <1390411194-21410-1-git-send-email-jenny.tc@intel.com>
 <1390411194-21410-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390411194-21410-2-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Rupesh Kumar <rupesh.kumar@stericsson.com>, Lars-Peter Clausen <lars@metafoo.de>, Pali Roh?r <pali.rohar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rhyland Klein <rklein@nvidia.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> Add new power supply properties for input current, charge termination
> current, min and max temperature
> 
> POWER_SUPPLY_PROP_TEMP_MIN - minimum operatable temperature
> POWER_SUPPLY_PROP_TEMP_MAX - maximum operatable temperature
> 
> POWER_SUPPLY_PROP_INLMT - input current limit programmed by charger. Indicates
> the input current for a charging source.

This is pretty cryptic. Maybe the prefix should be shortened
so that we get enough space for INPUT_LIMIT?
