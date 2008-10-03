From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP PM interface, version 4
Date: Fri, 03 Oct 2008 04:58:33 -0600
Message-ID: <20081003104140.10040.23992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40736 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbYJCLBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:01:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

this is the fourth version of the OMAP PM interface patch.

Major changes since the third revision:

1. omap_pm_get_dev_context_loss_count() has been added.  Normally,
   drivers must restore their context upon every clk_enable(), since
   the device's powerdomain could have been previously switched off.
   If, after clk_enable() in driver code, this function returns the
   same value than was returned in a previous call before a
   clk_disable(), drivers can avoid restoring device context.

2. Documentation updated.


=46urther comments welcome,

- Paul=20

---------------------------------

This message proposes the fourth version of a power management
interface (the "OMAP PM interface") for the linux-omap kernel tree.

It includes a general device driver PM interface, along with some
specialized interfaces for CPUFreq, DSPBridge, and the
powerdomain/clockdomain code.  This message focuses on the general
device driver portion, since it is most relevant to the larger
community of OMAP device driver developers.

The interface is intended to allow drivers to take advantage of OMAP
power management features:

- without locking drivers into a particular underlying implementation;

- without adding constraints that are specific to particular OMAP
  variants; and

- without affecting other architectures.

The device driver portion of the interface covers five types of PM
constraints:

1. Set the maximum MPU wakeup latency

2. Set the maximum device wakeup latency

3. Set the maximum system DMA transfer start latency (CORE pwrdm)

4. Set the minimum bus throughput needed by a device

5. Get the number of times a device has lost context.

These are described in more detail in the patch.

This interface is intended to be temporary, to survive only until the
Linux PM QoS layer supports these features.

This interface is a collaborative product of many people from Nokia
and TI: Karthik Dasu, Jouni H=C3=B6gander, Tony Lindgren, Rajendra Naya=
k,
Sakari Poussa, Veeramanikandan Raju, Anand Sawant, Igor Stoppa, Paul
Walmsley, and Richard Woodruff.

Included in the patch is a 'no-op' implementation that documents the
interface and emits debug messages.  Rajendra Nayak at TI has
developed an initial implementation of the OMAP PM interface that
relies mostly on TI's Shared Resource Framework.  Also under
development is an implementation of the OMAP PM code that uses the
existing Linux PM QoS code.


Comments welcomed,

- Paul

---

 Documentation/arm/OMAP/omap_pm            |  204 ++++++++++++++++++
 arch/arm/mach-omap2/io.c                  |    4=20
 arch/arm/plat-omap/Kconfig                |   13 +
 arch/arm/plat-omap/Makefile               |    1=20
 arch/arm/plat-omap/include/mach/omap-pm.h |  319 +++++++++++++++++++++=
+++++++
 arch/arm/plat-omap/omap-pm-noop.c         |  330 +++++++++++++++++++++=
++++++++
 6 files changed, 871 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/OMAP/omap_pm
 create mode 100644 arch/arm/plat-omap/include/mach/omap-pm.h
 create mode 100644 arch/arm/plat-omap/omap-pm-noop.c

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
