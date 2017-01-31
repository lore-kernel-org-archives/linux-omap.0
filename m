From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/12] PM / OPP: Update OPP users to put reference
Date: Tue, 31 Jan 2017 14:17:24 +0530
Message-ID: <20170131084724.GB7458@vireshk-i7>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
 <CGME20170123044228epcas3p35fdbe94a890062e9d66e33a3b5e4d571@epcas3p3.samsung.com>
 <20170131071721epcms1p6a4da8e0add4547573d40bbbb55d37b74@epcms1p6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170131071721epcms1p6a4da8e0add4547573d40bbbb55d37b74@epcms1p6>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edu>
List-Id: linux-omap@vger.kernel.org

On 31-01-17, 07:17, MyungJoo Ham wrote:
> > This patch updates dev_pm_opp_find_freq_*() routines to get a reference
> > to the OPPs returned by them.
> > 
> > Also updates the users of dev_pm_opp_find_freq_*() routines to call
> > dev_pm_opp_put() after they are done using the OPPs.
> > 
> > As it is guaranteed the that OPPs wouldn't get freed while being used,
> > the RCU read side locking present with the users isn't required anymore.
> > Drop it as well.
> > 
> > This patch also updates all users of devfreq_recommended_opp() which was
> > returning an OPP received from the OPP core.
> > 
> > Note that some of the OPP core routines have gained
> > rcu_read_{lock|unlock}() calls, as those still use RCU specific APIs
> > within them.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com> [Devfreq]
> 
> This patch gets a lot of fails during application.
> 
> For devfreq-side, I've got:
> error: drivers/devfreq/devfreq.c: patch does not apply
> error: patch failed: drivers/devfreq/exynos-bus.c:103
> error: drivers/devfreq/exynos-bus.c: patch does not apply
> error: patch failed: drivers/devfreq/governor_passive.c:59
> error: drivers/devfreq/governor_passive.c: patch does not apply
> error: patch failed: drivers/devfreq/rk3399_dmc.c:91
> error: drivers/devfreq/rk3399_dmc.c: patch does not apply
> error: patch failed: drivers/devfreq/tegra-devfreq.c:487
> error: drivers/devfreq/tegra-devfreq.c: patch does not apply
> 
> With the condition that you are going to properly rebase the patch,
> you may add "Reviewed-by" from me.
> (the code itself looks fine.)

This is already applied by Rafael and was based over his tree only.

-- 
viresh
