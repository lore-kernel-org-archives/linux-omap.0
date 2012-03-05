From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 0/9] Consolidate cpuidle functionality
Date: Mon, 05 Mar 2012 13:33:20 -0800
Message-ID: <87y5reivhb.fsf@ti.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org> (Robert
	Lee's message of "Wed, 29 Feb 2012 18:42:49 -0600")
Sender: linux-sh-owner@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: rjw@sisk.pl, len.brown@intel.com, nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, kgene.kim@samsung.com, mturquette@linaro.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, patches@linaro.org, nsekhar@ti.com, jean.pihet@newoldbits.com, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, lethal@linux-sh.org, amit.kachhap@linaro.org
List-Id: linux-omap@vger.kernel.org

Robert Lee <rob.lee@linaro.org> writes:

> This patch series moves various functionality duplicated in platform 
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into 
> cpuidle_call_idle will have already called local_irq_disable().

Reviewed-by: Kevin Hilman <khilman@ti.com>

