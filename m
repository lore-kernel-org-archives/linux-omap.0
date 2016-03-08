From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: omap-thermal: Add notify function to
 thermal_zone_device_ops
Date: Tue, 8 Mar 2016 12:48:14 -0800
Message-ID: <20160308204812.GA6800@localhost.localdomain>
References: <1455599145-5656-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455599145-5656-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: nm@ti.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 16, 2016 at 10:35:45AM +0530, Keerthy wrote:
> notify function is used to notify when some temperature thresholds
> are crossed. In case we get notified for a critical trip point then
> schedule an emergency shutdown function to backup orderly_poweroff
> failures.
> 
> orderly_poweroff is triggered when a graceful shutdown
> of system is desired. This may be used in many critical states of the
> kernel such as when subsystems detects conditions such as critical
> temperature conditions. However, in certain conditions in system
> boot up sequences like those in the middle of driver probes being
> initiated, userspace will be unable to power off the system in a clean
> manner and leaves the system in a critical state. In cases like these,
> the /sbin/poweroff will return success (having forked off to attempt
> powering off the system. However, the system overall will fail to
> completely poweroff (since other modules will be probed) and the system
> is still functional with no userspace (since that would have shut itself
> off).
> 
> However, there is no clean way of detecting such failure of userspace
> powering off the system. In such scenarios, it is necessary for a backup
> workqueue to be able to force a shutdown of the system when orderly
> shutdown is not successful after a configurable time period.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> The previous discussion:
> 
> https://lkml.org/lkml/2016/1/28/989
> 
> Making use of the notify ops to schedule a backup thermal shutdown.

Yeah, this was a bit of a stretching. If we cannot fix orderly power
off, I would say, better fixing it for all thermal drivers (previous
version of this). This patch:
1. Abuse a notify function to be used as a power off functions
2. Fix an issue only for a single driver.

I will check your initial version.

