From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Tue, 1 Feb 2011 17:57:37 +0530
Message-ID: <f317bf5f6fd12d8b3686aa141a03f7fc@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35498 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754634Ab1BAMe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 07:34:27 -0500
Received: by fxm5 with SMTP id 5so8188316fxm.25
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 04:34:24 -0800 (PST)
In-Reply-To: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ping.

Vishwa

> -----Original Message-----
> From: Vishwanath BS [mailto:vishwanath.bs@ti.com]
> Sent: Friday, January 21, 2011 7:31 PM
> To: linux-omap@vger.kernel.org
> Cc: patches@linaro.org; Vishwanath BS
> Subject: [PATCH 00/13] OMAP: Basic DVFS Framework
>
> This patch series introduces support for Dynamic Voltage and Frequency
> Scaling
> (DVFS) for OMAP devices.
>
> For detailed design details, refer to DVFS Documentation.
>
> Pending Work:
> 1. OMAP4 support
>
> Changes done in this series:
> 1. Seperated DVFS code from Voltage layer (voltage.c) and introduced
> DVFS layer
>    in dvfs.c
> 2. Added support for frequency throttling and frequency locking (by
> introducing
>    frequency list per device)
> 3. Added changes in omap cpufreq driver for DVFS support
> 4. Fixed race condition issues in DVFS layer
> 5. Added documentation for DVFS framework
> 5. Addressed comments received on V2
> 	V1: https://patchwork.kernel.org/patch/120132/
> 	V2: https://patchwork.kernel.org/patch/290542/
>
> Contributors to conceptualization of the design include
> Anand Sawant <sawant@ti.com>
> Benoit Cousson <b-cousson@ti.com>,
> Kevin Hilman <khilman@deeprootsystems.com>,
> Paul Wamsley <paul@pwsan.com>,
> Parthasarathy Basak <p-basak2@ti.com>
> Thara Gopinath <thara@ti.com>
> Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> This patch series is generated against latest kevin's pm branch and has
> been
> tested on ZOOM3 for mpu, iva and core DVFS.
>
> Thara Gopinath (6):
>   OMAP: Introduce device specific set rate and get rate in omap_device
>     structure
>   OMAP3: Introduce custom set rate and get rate APIs for scalable
>   OMAP: Disable Smartreflex across DVFS
>     devices
>   OMAP3: Introduce voltage domain info in the hwmod structures.
>   OMAP3: Add voltage dependency table for VDD1.
>   OMAP2PLUS: Enable various options in defconfig
>
> Vishwanath BS (7):
>   OMAP: Introduce accessory APIs for DVFS
>   OMAP: Implement Basic DVFS
>   OMAP: Introduce dependent voltage domain support
>   OMAP: Introduce device scale implementation
>   OMAP3: cpufreq driver changes for DVFS support
>   OMAP2PLUS: Replace voltage values with Macros
>   OMAP: Add DVFS Documentation
>
>  Documentation/arm/OMAP/omap_dvfs              |  111 ++++
>  arch/arm/configs/omap2plus_defconfig          |    4 +
>  arch/arm/mach-omap2/Makefile                  |    2 +-
>  arch/arm/mach-omap2/dvfs.c                    |  751
> +++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    3 +
>  arch/arm/mach-omap2/opp3xxx_data.c            |   47 +-
>  arch/arm/mach-omap2/opp4xxx_data.c            |   13 +-
>  arch/arm/mach-omap2/pm.c                      |   71 +++
>  arch/arm/mach-omap2/voltage.c                 |  159 ++----
>  arch/arm/plat-omap/cpu-omap.c                 |   35 +-
>  arch/arm/plat-omap/include/plat/dvfs.h        |   34 ++
>  arch/arm/plat-omap/include/plat/omap_device.h |    9 +
>  arch/arm/plat-omap/include/plat/voltage.h     |  148 +++++
>  arch/arm/plat-omap/omap_device.c              |   58 ++
>  14 files changed, 1293 insertions(+), 152 deletions(-)
>  create mode 100644 Documentation/arm/OMAP/omap_dvfs
>  create mode 100644 arch/arm/mach-omap2/dvfs.c
>  create mode 100644 arch/arm/plat-omap/include/plat/dvfs.h
