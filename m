From: jean.pihet@newoldbits.com
Subject: [PATCH v5 0/6] PM QoS: implement the OMAP low level constraints management code
Date: Mon, 12 Dec 2011 17:18:15 +0100
Message-ID: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33188 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1LLQSt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 11:18:49 -0500
Received: by eekc4 with SMTP id c4so1674351eek.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 08:18:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

. Implement the devices wake-up latency constraints using the global
  device PM QoS notification handler which applies the constraints to the
  underlying layer
. Implement the low level code which controls the power domains next power
  states, through the hwmod and pwrdm layers
. Add cpuidle and power domains wake-up latency figures for OMAP3, cf. 
  comments in the code and [1] for the details on where the numbers
  are magically coming from
. Implement the relation between the cpuidle and per-device PM QoS frameworks
  in the OMAP3 specific idle callbacks.
  The chosen C-state shall satisfy the following conditions:
   . the 'valid' field is enabled,
   . it satisfies the enable_off_mode flag,
   . the next state for MPU and CORE power domains is not lower than the
     state programmed by the per-device PM QoS.


ToDo:
1. validate the constraints framework on OMAP4 HW (done on OMAP3)
2. Re-visit the OMAP power domains states initialization procedure. Currently
   the power states that have been changed from the constraints API which were
   applied before the initialization of the power domains are lost
3. Further clean-up the OMAP PM layer, use the generic frameworks instead (OPP,
   PM QoS...)


Based on the pm-qos branch of the linux-omap git tree (3.2.0-rc4), cf. [2].

Tested on OMAP3 Beagleboard (ES2.x) with constraints on MPU, CORE, PER in
RETention and OFF modes.

[1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git


v5:
. rebased on latest linux-omap [2]
. rework after Kevin's comments on the MLs

v4:
. split up the patches which remove the omap_pm_ code from the patch set.
  Those patches are to be submitted later, on top of this patch set.
. latency numbers: provide the measurements setup and conditions in the code
  comments, added the link to the details on wiki [1].
. improved kerneldoc
. split big functions into smaller ones, in order to improve the readability

v3: reworked the error return path and improved the kerneldoc

v2: reworked the OMAP specific cpuidle code to demote the initial C-state to
     a valid C-state which fulfills the per-device constraints

v1: initial version


Jean Pihet (6):
  OMAP2+: powerdomain: control power domains next state
  OMAP2+: omap_hwmod: manage the wake-up latency constraints
  OMAP: PM: register to the per-device PM QoS framework
  OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and
    CORE constraints
  OMAP3: update cpuidle latency and threshold figures
  OMAP3: powerdomain data: add wake-up latency figures

 arch/arm/mach-omap2/cpuidle34xx.c            |  107 +++++++-----
 arch/arm/mach-omap2/omap_hwmod.c             |   27 +++-
 arch/arm/mach-omap2/pm.c                     |   71 ++++++++-
 arch/arm/mach-omap2/pm.h                     |   17 ++-
 arch/arm/mach-omap2/powerdomain.c            |  245 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h            |   36 ++++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c  |   83 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 8 files changed, 539 insertions(+), 49 deletions(-)

-- 
1.7.5.4

