From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/15] arm: dts: omap: Add missing cooling device
 properties for CPUs
Date: Mon, 2 Jul 2018 23:44:18 -0700
Message-ID: <20180703064418.GE112168@atomide.com>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <7aa1c7c6d1e76b551ed74512af797db28be8925f.1527244201.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7aa1c7c6d1e76b551ed74512af797db28be8925f.1527244201.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Viresh Kumar <viresh.kumar@linaro.org> [180525 03:35]:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Fix other missing properties (clocks, supply, clock latency) as well to
> make it all work.

Applying this too into omap-for-v4.19/dt thanks.

Tony
