From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] ARM: dts: omap: Remove "cooling-{min|max}-level"
 for CPU nodes
Date: Mon, 12 Feb 2018 09:18:38 -0800
Message-ID: <20180212171838.GC6364@atomide.com>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <65c21dd1f5299d624ddb0b5e607226d86f745e19.1518166039.git.viresh.kumar@linaro.org>
 <20180212171709.GB6364@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180212171709.GB6364@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, daniel.lezcano@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180212 09:17]:
> * Viresh Kumar <viresh.kumar@linaro.org> [180209 00:59]:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of the kernel currently and the max cooling state of
> > a CPU cooling device is found by referring to the cpufreq table instead.
> > 
> > Remove the unused properties from the CPU nodes.
> 
> It seem this patch needs to wait before we can apply, right?

Oh sorry it's already unused :) Will pick this up for v4.17 thanks.

Tony
