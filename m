From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP PM interface, version 3
Date: Wed, 16 Jul 2008 19:57:58 -0600
Message-ID: <20080717015741.14287.75980.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48305 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbYGQCAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 22:00:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, rnayak@ti.com


Hello everyone,

this is the third version of the OMAP PM interface patch.

Major changes since the second revision:

1. set_max_mpu_wakeup_lat() has been added.  This is intended to limit
   the amount of time needed for the MPU to wake up and enter a device
   driver's interrupt handler.

2. set_max_dma_lat() has been renamed to set_max_sdma_lat()

3. omap_pm_dsp_get_opp_table() and struct omap_opp have been added for
   future DSPBridge/CPUFreq use.  omap_pm_if_init() now takes pointers
   to struct omap_opp arrays that are intended to be passed in from the
   board-*.c files.

4. Interface documentation has been moved to the=20
   include/asm-arm/arch-omap/omap-pm.h file.

5. Documentation updated and moved into Documentation/arm/OMAP/omap_pm


=46urther comments welcome,


- Paul=20

---------------------------------

This message proposes the third version of a power management
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

The device driver portion of the interface covers four types of PM
constraints:

1. Set the maximum MPU wakeup latency

2. Set the maximum device wakeup latency

3. Set the maximum system DMA transfer start latency (CORE pwrdm)

4. Set the minimum bus throughput needed by a device


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

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
