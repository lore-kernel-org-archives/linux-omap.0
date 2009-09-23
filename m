From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH v2 0/4] RTC-MSECURE: platform data structure defined
Date: Wed, 23 Sep 2009 19:14:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31AD76@dbde02.ent.ti.com>
References: <1251126410-27105-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50232 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbZIWNom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 09:44:42 -0400
In-Reply-To: <1251126410-27105-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "sameo@linux.intel.com" <sameo@linux.int>
Cc: "Garcia, Thierry" <thierry-garcia@ti.com>, "Sawant, Anand" <sawant@ti.com>

Tony,

Can you upstream these series of patches if there are no comments?

________________________________________
From: Varadarajan, Charu Latha
Sent: Monday, August 24, 2009 8:36 PM
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com; david-b@pacbell.net; sameo@linux.intel.com; p_gortmaker@yahoo.com; Varadarajan, Charu Latha
Subject: [PATCH v2 0/4] RTC-MSECURE: platform data structure defined

Review comments are incorporated.
This series contains patches which does the following.
        1. define TWL4030 rtc platform data which has msecure gpio line info
        2. initialise msecure gpio line from rtc driver
        3. twl core file passes rtc platform data from board file to rtc driver
        4. Board files handle mux configuration of msecure gpio line

This series applies on top of linux-2.6.31-rc5.

CharuLatha (4):

        [PATCH 1/4] RTC platform data structure defined
        [PATCH 2/4] RTC msecure initialization
        [PATCH 3/4] handling rtc platform data
        [PATCH 4/4] board files do msecure line mux configuration


Signed-off-by: Charulatha V <charu@ti.com>
---
 include/linux/i2c/twl4030.h           |    5 +++++
 drivers/rtc/rtc-twl4030.c             |   38 +++++++++++++++++++++++++++++++++++++-
 drivers/mfd/twl4030-core.c            |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c   |    7 +++++++
 arch/arm/mach-omap2/board-3430sdp.c   |   18 +++++++++++++++++-
 arch/arm/mach-omap2/board-ldp.c       |   19 +++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h |    2 ++

 8 files changed, 93 insertions(+), 3 deletions(-)
