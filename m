From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCH 0/3] McPDM driver patch series
Date: Thu, 17 Dec 2009 13:40:27 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59778 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965471AbZLQTki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 14:40:38 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

McPDM module is the interface between the OMAP and TWL6030 audio codec.
It transfers data between the two chips using a Pulse Density Modulation
protocol, which allows sound to be played or recorded at speeds of up to
96000 Hz. Besides data, McPDM can transfer commands and read status
to/from the codec using the frame synchronization line.

The interface supports the following:
* Up to 5 downlink channels and 3 uplink channels
* 88.2 and 96 KHz
* 32 bit sample size

Currently, driver is set to support up to 4 downlink channels. If 2
channels are selected, output will go to the headset, and if 4 channels
are selected, output will go to the headset and speakers. Functionality
to select the output at runtime will be added afterwards.

Command and status mode is not supported in current patches.

--

Jorge Eduardo Candelaria (2):
      OMAP4: IRQ: Add McPDM IRQ definition.
      ASoC: OMAP4: Add support for McPDM

Misael Lopez Cruz (1):
      ASoC: OMAP4: Add McPDM platform driver

 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 sound/soc/omap/Kconfig                 |    3 +
 sound/soc/omap/Makefile                |    2 +
 sound/soc/omap/mcpdm.c                 |  505 ++++++++++++++++++++++++++++++++
 sound/soc/omap/mcpdm.h                 |  156 ++++++++++
 sound/soc/omap/omap-mcpdm.c            |  248 ++++++++++++++++
 sound/soc/omap/omap-mcpdm.h            |   29 ++
 7 files changed, 944 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/omap/mcpdm.c
 create mode 100644 sound/soc/omap/mcpdm.h
 create mode 100644 sound/soc/omap/omap-mcpdm.c
 create mode 100644 sound/soc/omap/omap-mcpdm.h