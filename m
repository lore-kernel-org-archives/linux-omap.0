From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI
 platforms
Date: Thu, 19 May 2016 10:17:44 +0530
Message-ID: <20160519044744.GE32001@vireshk-i7>
References: <cover.1463606963.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

On 18-05-16, 18:36, Dave Gerlach wrote:
> Hi,
> This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
> and am57xx based platforms along with some support patches so that we
> can enable more OPPs for the CPU on these platforms.
> 
> These patches rely on the ti-cpufreq series sent here [1] and provide
> opp-supported-hw data for each OPP so that only the appropriate OPPs
> for a specific piece of silicon get enabled.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
