From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 21 Dec 2011 10:02:44 +0100
Message-ID: <4EF1A0B4.5080307@linux.intel.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1324426147-16735-1-git-send-email-ccross@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Trinabh Gupta <g.trinabh@gmail.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/21/2011 1:09 AM, Colin Cross wrote:
> On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
> cpus cannot be independently powered down, either due to
> sequencing restrictions (on Tegra 2, cpu 0 must be the last to
> power down), or due to HW bugs (on OMAP4460, a cpu powering up
> will corrupt the gic state unless the other cpu runs a work
> around).  Each cpu has a power state that it can enter without
> coordinating with the other cpu (usually Wait For Interrupt, or
> WFI), and one or more "coupled" power states that affect blocks
> shared between the cpus (L2 cache, interrupt controller, and
> sometimes the whole SoC).  Entering a coupled power state must
> be tightly controlled on both cpus.
> 
> The easiest solution to implementing coupled cpu power states is
> to hotplug all but one cpu whenever possible, usually using a
> cpufreq governor that looks at cpu load to determine when to
> enable the secondary cpus.  This causes problems, as hotplug is an
> expensive operation, so the number of hotplug transitions must be
> minimized, leading to very slow response to loads, often on the
> order of seconds.
> 
> This patch series implements an alternative solution, where each
> cpu will wait in the WFI state until all cpus are ready to enter
> a coupled state, at which point the coupled state function will
> be called on all cpus at approximately the same time.
> 
> Once all cpus are ready to enter idle, they are woken by an smp
> cross call.  At this point, there is a chance that one of the
> cpus will find work to do, and choose not to enter suspend.  A
> final pass is needed to guarantee that all cpus will call the
> power state enter function at the same time.  During this pass,
> each cpu will increment the ready counter, and continue once the
> ready counter matches the number of online coupled cpus.  If any
> cpu exits idle, the other cpus will decrement their counter and
> retry.

this smells fundamentally racey to me; you can get an interrupt one
cycle after you think you're done, but before the last guy enters WFI...

how do you solve that issue ?
