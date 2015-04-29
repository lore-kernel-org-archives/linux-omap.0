From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/4] remoteproc: Introduce wkup_m3_rproc driver
Date: Wed, 29 Apr 2015 11:05:23 -0500
Message-ID: <55410143.1080209@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427917039-43206-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 04/01/2015 02:37 PM, Dave Gerlach wrote:
> Hi,
> This patch series is version three of the series to add a
> wkup_m3_rproc driver for TI AM335x SoCs. This family of SoCs
> contains an ARM Cortex M3 coprocessor that is responsible for
> low-level power tasks that cannot be handled by the main ARM
> Cortex A8 so firmware running from the CM3 can be used instead.
> This driver handles loading of the firmware and reset of the CM3
> once it is booted.
> 
> The previous version of this series can be found here [1].
> I have pushed a branch based on v4.0-rc5 containing the entire
> am335x suspend series here for a higher level view of the entire
> series of patch sets here [2]. This series depends on "remoteproc:
> add IOMMU hardware capability flag" which is currently queued
> here [3].
> 
> Based on comments on the DT node included in the "ARM: OMAP2+:
> wkup_m3_rproc support patches" series (v3 of that will immediately
> follow this series) the DT node moved under a different parent
> node so some changes to the driver were necessary to calculate proper
> device addresses for firmware loading.
> 
> This series also now includes a patch to introduce an
> rproc_get_by_phandle API to the remoteproc core so that users of
> this wkup_m3_rproc driver are able to get a handle to the rproc
> and boot it as the rproc must be booted directly by the user.
> An example user, wkup_m3_ipc, can be seen in previously mentioned
> branch at [2].
> 
> v2 -> v3:
> -Modify wkup_m3_rproc driver to properly handle device address
>  based on new DT location in l4_wkup node.
> -In binding doc, change ti,am3352-wkup-m3 from am3353-wkup_m3 to match
>  other am3352 compats
> -General cleanup of address representation in wkup_m3_rproc driver
> -Includes rproc_get_by_phandle patch now
> 
> The driver expects to load firmware am335x-pm-firmware.elf from
> /lib/firmware which is found here [4].
> 
> Regards,
> Dave
> 
> [1] http://www.spinics.net/lists/linux-omap/msg116364.html
> [2] https://github.com/dgerlach/linux-pm/tree/pm-v4.0-rc5-am335x-suspend
> [3] https://git.kernel.org/cgit/linux/kernel/git/ohad/remoteproc.git/commit/?h=for-next&id=315491e5d6ee66838a18a8ca0c14e6ffb376e48c
> [4] https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/commits/next-upstream
> 
> Dave Gerlach (3):
>   remoteproc: introduce rproc_get_by_phandle API
>   Documentation: dt: add bindings for TI Wakeup M3 processor
>   remoteproc/wkup_m3: add a remoteproc driver for TI Wakeup M3
> 
> Suman Anna (1):
>   remoteproc: add a rproc ops for performing address translation

Ping, do you have any comments on this series? This is the core
dependency for achieving suspend/resume and cpuidle on AM335x and AM437x
SoCs. I am hoping to have this series make 4.2.

regards
Suman

> 
>  .../bindings/remoteproc/wkup_m3_rproc.txt          |  52 +++++
>  Documentation/remoteproc.txt                       |   6 +
>  drivers/remoteproc/Kconfig                         |  13 ++
>  drivers/remoteproc/Makefile                        |   1 +
>  drivers/remoteproc/remoteproc_core.c               | 114 +++++++++-
>  drivers/remoteproc/wkup_m3_rproc.c                 | 249 +++++++++++++++++++++
>  include/linux/platform_data/wkup_m3.h              |  30 +++
>  include/linux/remoteproc.h                         |   4 +
>  8 files changed, 463 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
>  create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
>  create mode 100644 include/linux/platform_data/wkup_m3.h
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
