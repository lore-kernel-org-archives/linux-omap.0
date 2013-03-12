From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] cpufreq: cpufreq-cpu0: support for clock which are
 not in DT yet.
Date: Tue, 12 Mar 2013 10:33:00 +0530
Message-ID: <513EB704.8030907@ti.com>
References: <1363043130-30270-1-git-send-email-nm@ti.com> <1363043130-30270-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363043130-30270-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 12 March 2013 04:35 AM, Nishanth Menon wrote:
> On certain SoCs like variants of OMAP, the clock conversion to DT
> is not complete. In short, the ability to:
> cpus {
>     cpu@0 {
> 	clocks = <&cpuclk 0>;
>     };
>  };
> is not possible. However, the clock node is registered.
> Allow for clk names to be provided as string so as to be used when needed.
> Example (for OMAP3630):
> cpus {
>     cpu@0 {
> 	clock-name = "cpufreq_ck";
>     };
>  };
> 
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cpufreq@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
Seems a reasonable to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
