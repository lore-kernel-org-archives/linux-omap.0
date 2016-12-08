From: Tony Lindgren <tony@atomide.com>
Subject: Re: Cpufreq regression in next-20161207
Date: Wed, 7 Dec 2016 22:04:48 -0800
Message-ID: <20161208060447.GE4264@atomide.com>
References: <20161208045640.GB4264@atomide.com>
 <20161208050739.GE24152@vireshk-i7>
 <20161208055220.GD4264@atomide.com>
 <20161208055738.GB31711@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161208055738.GB31711@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Viresh Kumar <viresh.kumar@linaro.org> [161207 21:58]:
> On 07-12-16, 21:52, Tony Lindgren wrote:
> > Hmm good question. Maybe we don't have the regulators configured for
> > pandaboard?
> 
> Hmm, and who would be the right person to confirm that? And its not only about
> pandaboard but the whole OMAP4 family (which is using cpufreq-dt driver).

Nishanth and Dave in Cc should be able to confirm. Most likely it's some
missing .config option for the regulators in multi_v7_defconfig compared
to omap2plus_defconfig though.

Regards,

Tony
