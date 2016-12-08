From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Cpufreq regression in next-20161207
Date: Thu, 8 Dec 2016 10:37:39 +0530
Message-ID: <20161208050739.GE24152@vireshk-i7>
References: <20161208045640.GB4264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208045640.GB4264@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 07-12-16, 20:56, Tony Lindgren wrote:
> Hi,
> 
> Looks like commit ef3caabee969 ("PM / OPP: Don't assume platform doesn't
> have regulators") caused a regression in Linux next-20161207 for at least
> omap4 pandaboard. We now hit kernel BUG at drivers/cpufreq/cpufreq.c:1235.
> 
> Any ideas?

I saw similar regression for Tegra and the offending commit is now
dropped from pm/linux-next. So linux-next should be fine after
fetching it today.

But just for my understanding, who is doing voltage scaling for OMAP4
then? The cpufreq-dt driver will only frequency scaling, as it fails
to find a regulator for the CPUs.

-- 
viresh
