From: mark gross <markgross@thegnar.org>
Subject: Re: [RFC/PATCH v3 00/13] PM QoS: add a per-device
 latency constraints class
Date: Thu, 28 Jul 2011 06:14:54 -0700
Message-ID: <20110728131454.GA2579@gvim.org>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 28, 2011 at 10:30:07AM +0200, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> This patch set is in an RFC state, for review and comments.
> 
> High level implementation:
> 
> 1. Add a new PM QoS class for device wake-up constraints (PM_QOS_DEV_LATENCY).
> . Define a pm_qos_constraints struct for the storage of the constraints list
> and associated values (target_value, default_value, type ...).
> . Update the pm_qos_object struct with the information related to a PM QoS
> class: ptr to constraints list, notifer ptr, name ...
> . Each PM QoS class statically declare objects for pm_qos_object and
> pm_qos_constraints. The only exception is the devices constraints, cf. below.
> . The device constraints class is statically declaring a pm_qos_object. The
> pm_qos_constraints are per-device and so are embedded into the device struct.
> 
> The new class is available from kernel drivers and shall be made available
> to user space through a per-device sysfs entry. User space API to come as a 
> subsequent patch.
> 
> 2. Added a notification of device insertion/removal from the device PM framework
> to PM QoS.
> This allows to init/de-init the per-device constraints list upon device insertion
> and removal.
> RFC state for comments and review, lightly tested
> 
> 3. Make the pm_qos_add_request API more generic by using a
> struct pm_qos_parameters parameter. This allows easy extension in the future.
> 
> 4. Upon a change of the aggregated constraint value in the PM_QOS_DEV_LATENCY class
> a notification chain mechanism is used to take action on the system.
> This is the proposed way to have PM QoS and the platform dependant code to
> interact with each other, cf. 5 below.
> The notification mechanism now passes the constraint request struct ptr in
> order for the notifier callback to have access to the full set of constraint
> data, e.g. the struct device ptr.
> 
> 5. cpuidle interaction with the OMAP3 cpuidle handler
> Since cpuidle is a CPU centric framework it decides the MPU next power state
> based on the MPU exit_latency and target_residency figures.
>     
> The rest of the power domains get their next power state programmed from
> the PM_QOS_DEV_LATENCY class of the PM QoS framework, via the device
> wake-up latency constraints callback to the OMAP_PM_CONSTRAINTS framework.
> 
> Note: the exit_latency and target_residency figures of the MPU include the MPU
> itself and the peripherals needed for the MPU to execute instructions (e.g.
> main memory, caches, IRQ controller, MMU etc).
> Some of those peripherals can belong to other power domains than the MPU
> subsystem and so the corresponding latencies must be included in those figures.
> 
> 6. Update the pm_qos_add_request callers to the generic API
> 
> 7. Misc fixes to improve code readability:
> . rename of the PM QoS implementation file from pm_qos_params.[ch] to pm_qos.[ch]
I picked the name for the file as pm_qos_params over pm_qos because I
wanted to make it implicitly clear that this was not an full QOS
implementation.  True QOS carries expectations similar to real time and
as the infrastructure is closer to "good intentioned" than even "best
effort" and offers no notification when the QOS request is not able to
be met and really doesn't implement a true QOS at all, (it just provides
the parameter interface for part of one its missing the notification
interface when the service level is not met and I think a few other
things.) So I wanted to have it named a bit different from just pm_qos.

This said I'm not supper attached to the naming of the modules.  If
folks want to change it I wouldn't complain (too much anyway;).

--mark
PS I'll look at the rest of the patches tomorrow, this time for real as
I'm about to have more free time to focus on non-work stuff :)
FWIW this write up sounds interesting.


> . rename of fields names (request, list, constraints, class),
> . simplification of the in-kernel PM QoS API implementation. The main logic part
> is now implemented in the update_target function.
> 
> Questions:
> 1. per-device user-space API: since sysfs does not provide open/close
> callbacks it is not possible to support multiple and simultaneous users of
> the per-device sysfs entry. A user-space constraints aggregation application is
> needed in case of multiple constraints for a device. Is this the way to go?
> 
> On-going developments, patches in preparation:
> 1. add a user-space API for the devices constratins PM QoS, using a sysfs entry
>    per device
> 2. write Documentation for the new PM QoS class, once the RFC is agreed on
> 3. validate the constraints framework on OMAP4 HW (done on OMAP3)
> 4. refine the power domains wake-up latency and the cpuidle figures
> 
> Based on the master branch of the linux-omap git tree (3.0.0-rc7). Compile
> tested using OMAP and x86 generic defconfigs.
> Lightly tested on OMAP3 Beagleboard (ES2.x).
> 
> 
> Changelog:
> 
> v3:
> . Complete PM QoS re-design after the comments on MLs
> . Patch set split up for improved readability and easier maintenance
> 
> v2:
> . Rework after comments on the mailing lists
> . Added a notification of device insertion/removal from the device PM framework
> . Validated on OMAP3 HW
> 
> v1:
> . Initial implementation
> 
> 
> Jean Pihet (12):
>   PM: QoS: rename pm_qos_params files to pm_qos
>   PM: add a per-device wake-up latency constraints plist
>   PM: QoS: extend the in-kernel API with per-device latency constraints
>   PM: QoS: implement the per-device latency constraints
>   PM: QoS: support the dynamic insertion and removal of devices
>   OMAP PM: create a PM layer plugin for per-device constraints
>   OMAP PM: early init of the pwrdms states
>   OMAP2+: powerdomain: control power domains next state
>   OMAP3: powerdomain data: add wake-up latency figures
>   OMAP2+: omap_hwmod: manage the wake-up latency constraints
>   OMAP: PM CONSTRAINTS: implement the devices wake-up latency
>     constraints
>   OMAP2+: cpuidle only influences the MPU state
> 
> Vishwanath BS (1):
>   OMAP4: powerdomain data: add wake-up latency figures
> 
>  arch/arm/mach-msm/clock.c                    |    2 +-
>  arch/arm/mach-omap2/cpuidle34xx.c            |   42 +--
>  arch/arm/mach-omap2/omap_hwmod.c             |   26 ++-
>  arch/arm/mach-omap2/pm.h                     |   17 +-
>  arch/arm/mach-omap2/pm34xx.c                 |    2 +-
>  arch/arm/mach-omap2/pm44xx.c                 |    2 +-
>  arch/arm/mach-omap2/powerdomain.c            |  190 +++++++++
>  arch/arm/mach-omap2/powerdomain.h            |   33 ++-
>  arch/arm/mach-omap2/powerdomains3xxx_data.c  |   77 ++++
>  arch/arm/mach-omap2/powerdomains44xx_data.c  |   84 ++++
>  arch/arm/plat-omap/Kconfig                   |    7 +
>  arch/arm/plat-omap/Makefile                  |    1 +
>  arch/arm/plat-omap/i2c.c                     |   20 -
>  arch/arm/plat-omap/include/plat/omap-pm.h    |  128 ------
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
>  arch/arm/plat-omap/omap-pm-constraints.c     |  344 ++++++++++++++++
>  arch/arm/plat-omap/omap-pm-noop.c            |   89 ----
>  drivers/acpi/processor_idle.c                |    2 +-
>  drivers/base/power/main.c                    |    4 +
>  drivers/cpuidle/cpuidle.c                    |    2 +-
>  drivers/cpuidle/governors/ladder.c           |    2 +-
>  drivers/cpuidle/governors/menu.c             |    2 +-
>  drivers/i2c/busses/i2c-omap.c                |   35 +-
>  drivers/media/video/via-camera.c             |    9 +-
>  drivers/net/e1000e/netdev.c                  |   11 +-
>  drivers/net/wireless/ipw2x00/ipw2100.c       |   10 +-
>  drivers/staging/msm/lcdc.c                   |    2 +-
>  drivers/staging/msm/tvenc.c                  |    2 +-
>  include/linux/netdevice.h                    |    4 +-
>  include/linux/pm.h                           |    4 +
>  include/linux/pm_qos.h                       |   68 ++++
>  include/linux/pm_qos_params.h                |   38 --
>  include/sound/pcm.h                          |    4 +-
>  kernel/Makefile                              |    2 +-
>  kernel/pm_qos.c                              |  557 ++++++++++++++++++++++++++
>  kernel/pm_qos_params.c                       |  481 ----------------------
>  net/mac80211/main.c                          |    2 +-
>  net/mac80211/mlme.c                          |    2 +-
>  net/mac80211/scan.c                          |    2 +-
>  sound/core/pcm_native.c                      |   10 +-
>  40 files changed, 1487 insertions(+), 834 deletions(-)
>  create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c
>  create mode 100644 include/linux/pm_qos.h
>  delete mode 100644 include/linux/pm_qos_params.h
>  create mode 100644 kernel/pm_qos.c
>  delete mode 100644 kernel/pm_qos_params.c
> 
> -- 
> 1.7.2.5
> 
