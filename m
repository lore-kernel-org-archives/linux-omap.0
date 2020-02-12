From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 00/14] mtd: rawnand: ams-delta: Prepare for merging
Date: Wed, 12 Feb 2020 01:39:15 +0100
Message-ID: <20200212003929.6682-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33320 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBLAkO (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 19:40:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so292185lji.0
        for <linux-omap@vger.kernel.org>; Tue, 11 Feb 2020 16:40:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

In preparation for merging the driver with "gpio-nand", as suggested by
Boris Brezillon and others, drop Amstrad Delta specific bits or replace
them with more generic ones.

The series starts with v2 of a patch that adds write protection on boot,
originally submitted as a part of the driver GPIO migratiton series but
not merged, with comments received at that time from Boris Brezillon now
hopefully addressed.

The series also contains v4 of a previously discussed patch that drops
Amstrad Delta specific partition table info from the driver, now
provided by the board file via platform data, with an OF fix added in v2
now excluded to a separate patch.

Remaining patches are new submissions.

Janusz Krzysztofik (14):
  mtd: rawnand: ams-delta: Write protect device during probe
  mtd: rawnand: ams-delta: Use struct gpio_nand_platdata
  ARM: OMAP1: ams-delta: Provide board specific partition info
  mtd: rawnand: ams-delta: Drop board specific partition info
  mtd: rawnand: ams-delta: Enable OF partition info support
  mtd: rawnand: ams-delta: Push inversion handling to gpiolib
  mtd: rawnand: ams-delta: Don't hardcode read/write pulse widths
  mtd: rawnand: ams-delta: Make read pulses optional
  mtd: rawnand: ams-delta: Handle more GPIO pins as optional
  mtd: rawnand: ams-delta: Add module device tables
  mtd: rawnand: ams-delta: Support custom driver initialisation
  mtd: rawnand: ams-delta: Drop useless local variable
  mtd: rawnand: ams-delta: Make the driver custom I/O ready
  mtd: rawnand: ams-delta: Rename structures and functions to gpio_nand*

 arch/arm/mach-omap1/board-ams-delta.c |  47 ++++-
 drivers/mtd/nand/raw/ams-delta.c      | 237 +++++++++++++++++---------
 2 files changed, 198 insertions(+), 86 deletions(-)

-- 
2.24.1
