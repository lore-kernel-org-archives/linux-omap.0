From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH 0/2] Per-user clock constraints
Date: Thu,  2 Oct 2014 15:04:55 +0200
Message-ID: <1412255097-15928-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50611 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbaJBNGe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2014 09:06:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Boyd <sboyd@codeaurora.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Hello,

these patches add the possibility of setting constraints on the frequency of
clocks. In contrast to my two previous approaches, this is accomplished with
per-user clocks, but without requiring changes to existing drivers. An
exception to the latter are a few boards in mach-omap2, which still register
their clocks statically and thus had to be changed to initialize struct
clk_core. Hopefully the whole of clk-private.h can be removed once those boards
have been converted to initialize their clocks with DTS files.

The first patch implements per-user clocks properly, and the second adds the
constraint API.

Thanks,

Tomeu

Tomeu Vizoso (2):
  clk: Make clk API return per-user struct clk instances
  clk: Add floor and ceiling constraints to clock rates

 arch/arm/mach-omap2/cclock3xxx_data.c   | 108 +++--
 arch/arm/mach-omap2/clock.h             |  11 +-
 arch/arm/mach-omap2/clock_common_data.c |   5 +-
 drivers/clk/clk.c                       | 723 +++++++++++++++++++++-----------
 drivers/clk/clk.h                       |   8 +
 drivers/clk/clkdev.c                    |  23 +-
 include/linux/clk-private.h             |  40 +-
 include/linux/clk-provider.h            |  27 +-
 include/linux/clk.h                     |  18 +
 9 files changed, 656 insertions(+), 307 deletions(-)

-- 
1.9.3

