From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 00/13] OMAP: Basic DVFS framework
Date: Wed, 18 Aug 2010 16:49:59 +0530
Message-ID: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41218 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab0HRLUX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, thara gopinath <thara@ti.com>

From: thara gopinath <thara@ti.com>

This patch series introduces support  for support of Dynamic Voltage and
Frequency Scaling (DVFS) for OMAP devices. DVFS is a technique that
uses the optimal operating frequency and voltage to allow a task to be
performed in the required amount of time.
OMAP processors have voltage domains whose voltage can be scaled to
various levels depending on which the operating frequencies of certain
devices belonging to the domain will also need to be scaled. This voltage
frequency tuple is known as Operating Performance Point (OPP). A device
can have multiple OPP's. Also a voltage domain could be shared between
multiple devices. Also there could be dependencies between various
voltage domains for maintaining system performance like VDD<X>
should be at voltage v1 when VDD<Y> is at voltage v2.

The design of this framework take into account all the above mentioned points.
To summarize the basic design of DVFS framework:-

1. Have device opp tables for each device whose operating frequency can be
   scaled. This is easy now due to the existance of hwmod layer which
   allow storing of device specific info. The device opp tables contain
   the opp pairs (frequency voltage tuples), the voltage domain pointer
   to which the device belongs to, the device specific set_rate and
   get_rate API's which will do the actual scaling of the device frequency
   and retrieve the current device frequency.
2. Introduce use counting on a per VDD basis. This is to take care multiple
   requests to scale a VDD. The VDD will be scaled to the maximum of the
   voltages requested.
3. Keep track of all scalable devices belonging to a particular voltage
   domain the voltage layer.
4. Generic API in the omap device layer which can be called by anybody
   to scale a device opp. This API will take in the device pointer and
   frequency to which the device needs to be scaled to. This API will
   then internally find out the voltage domain to which the device
   belongs to and the voltage to which the voltage domain needs to
   be put to for the device to be scaled to the new frequency from
   the device opp table. Then this API will call into the newly
   introduced API in voltage layer (as mentioned in 2) to see if
   there are other requests for the associated voltage domain to
   be at a voltage higher than the current chosen one. If not this
   API will go ahead and scale the voltage domain to the new voltage,
   run through the list of all scalable devices belonging to this
   voltage domain and scale them to the appropriate frequencies using
   the set_rate pointer in the device opp tables.
5. Handle inter VDD dependecies.

Work pending -
2. Add OMAP4 support.

Contributors to conceptualization of the design include
Benoit Cousson <b-cousson@ti.com>,
Kevin Hilman <khilman@deeprootsystems.com>,
Paul Wamsley <paul@pwsan.com>,
Vishwanath Sripathy <vishwanath.bs@ti.com>
Parthasarathy Basak <p-basak2@ti.com>
Anand Sawant <sawant@ti.com>

This patch series is primarily based of origin/pm-opp branch
of kevin's PM tree and due to it's dependency on the newly
introduced opp and voltage layer, and to test dvfs using
cpufreq layer the following are the dependent patches
to be applied in order.

	https://patchwork.kernel.org/patch/119544/
        https://patchwork.kernel.org/patch/117347/
        https://patchwork.kernel.org/patch/117348/
        https://patchwork.kernel.org/patch/117349/
        http://marc.info/?l=linux-omap&m=128162263809748&w=2
        https://patchwork.kernel.org/patch/119854/
        all 5 patches from origin/pm-cpufreq branch off Kevin's pm tree
        http://marc.info/?l=linux-omap&m=128170725127719&w=2
                                - all eight patches in this series
	http://marc.info/?l=linux-omap&m=128213020527909&w=2
				- all 10 patches in this series

This series has been tested on OMAP3430 SDP for mpu, iva and
core  DVFS through cpu freq framework.

Thara Gopinath (13):
  OMAP: Introduce a user list for each voltage domain instance in the
    voltage driver.
  OMAP: Introduce API in the OPP layer to find the opp entry
    corresponding to a voltage.
  OMAP: Introduce voltage domain information in the hwmod structures
  OMAP: Introduce API to return a device list associated with a voltage
    domain
  OMAP: Introduce device specific set rate and get rate in device opp
    structures.
  OMAP: Voltage layer changes to support DVFS.
  OMAP: Introduce dependent voltage domain support.
  OMAP: Introduce device set_rate and get_rate.
  OMAP: Disable smartreflex across DVFS
  OMAP3: Introduce custom set rate and get rate APIs for scalable
    devices
  OMAP3: Update cpufreq driver to use the new set_rate API
  OMAP3: Introduce voltage domain info in the hwmod structures.
  OMAP3: Add voltage dependency table for VDD1.

 arch/arm/mach-omap2/cpufreq34xx.c             |  104 ++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    3 +
 arch/arm/mach-omap2/voltage.c                 |  313 +++++++++++++++++++++++++
 arch/arm/plat-omap/cpu-omap.c                 |    3 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    3 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    5 +
 arch/arm/plat-omap/include/plat/opp.h         |   45 ++++-
 arch/arm/plat-omap/include/plat/voltage.h     |    4 +
 arch/arm/plat-omap/omap_device.c              |   74 ++++++
 arch/arm/plat-omap/opp.c                      |  159 +++++++++++++
 10 files changed, 711 insertions(+), 2 deletions(-)

-- 
1.7.1.GIT

