From: Thara Gopinath <thara@ti.com>
Subject: [RFC 0/7] OMAP: Basic DVFS framework
Date: Fri,  2 Jul 2010 15:48:22 +0530
Message-ID: <1278065909-32148-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47174 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab0GBKSj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 06:18:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com, Thara Gopinath <thara@ti.com>

This patch series is RFC for support of Dynamic Voltage and
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
   the set_rate pointer in the device opp table.s

Work pending -
1. Handle inter VDD dependencies.
2. Add OMAP4 support.

Contributors to conceptualization of the design include
Benoit Cousson <b-cousson@ti.com>,
Kevin Hilman <khilman@deeprootsystems.com>,
Paul Wamsley <paul@pwsan.com>,
Vishwanath Sripathy <vishwanath.bs@ti.com>
Parthasarathy Basak <p-basak2@ti.com>
Anand Sawant <sawant@ti.com>

This patch series is primarily based of pm-sr branch of kevin's PM tree due to
it's dependency on the newly introduced opp and voltage layer. On top of this
branch I had to apply a few patches to test out dvfs using cpufreq framework.
The following are the link to these additional patches.
	https://patchwork.kernel.org/patch/107876/
	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=aa14cb9937e67c48f760c99a3c7fb3b2e7f5e623
	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=8f1298921d10789bb2f0a2d56cd3b92d844a1450
	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=10474ce3b07949d791b419aad433590e072e7159
	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=52fd40b873f8cd5aaea2d01d86ef35017c207eba
	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=57a2e45ff4a596a175aba27ae55a2b0d99adc3b5	

This series has been tested on OMAP3430 SDP for mpu and iva DVFS through
cpu freq framework.

Thara Gopinath (7):
  OMAP: Introduce a user list for each voltage domain instance in the
    voltage driver.
  OMAP: Introduce API in the OPP layer to find the opp entry
    corresponding to a voltage.
  OMAP: Introduce voltage domain pointer and device specific set rate
    and get rate in device opp structures.
  OMAP: Voltage layer changes to support DVFS.
  OMAP: Introduce device set_rate and get_rate.
  OMAP3: Update OMAP3 opp tables to contain the voltage domain and
    device set rate get rate info
  OMAP3: Update cpufreq driver to use the new set_rate API

 arch/arm/mach-omap2/cpufreq34xx.c             |  160 +++++++++++++++++++----
 arch/arm/mach-omap2/voltage.c                 |  172 ++++++++++++++++++++++++-
 arch/arm/plat-omap/cpu-omap.c                 |    5 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/opp.h         |   39 ++++++-
 arch/arm/plat-omap/include/plat/voltage.h     |    6 +-
 arch/arm/plat-omap/omap_device.c              |   87 +++++++++++++
 arch/arm/plat-omap/opp.c                      |   75 +++++++++--
 8 files changed, 505 insertions(+), 41 deletions(-)

