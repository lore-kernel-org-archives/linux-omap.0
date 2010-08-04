From: John Faith <jfaith7@gmail.com>
Subject: Board mux entries ignored?
Date: Wed, 4 Aug 2010 12:28:55 -0700
Message-ID: <AANLkTimYgkviKVfXNpQB9vsjSZyMdxuwkrXYQHSb02wY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39251 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab0HDT2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 15:28:55 -0400
Received: by pzk26 with SMTP id 26so2180366pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 12:28:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I'm trying to set mux modes for a 3530, package CBC in my board.c
(2.6.32 kernel) using an omap_board_mux entry:
 OMAP3_MUX(GPMC_WAIT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),

, but sysfs reports mode4:
# grep WAIT1 /sys/kernel/debug/omap_mux/board
OMAP3_MUX(GPMC_WAIT1, OMAP_PIN_INPUT | OMAP_MUX_MODE4),

I tried adding to bootargs "omap_mux=gpmc_wait1.gpmc_wait1=0x100", but
still got MODE4.  Doing "echo 0x100 >
/sys/kernel/debug/omap_mux/gpmc_wait1" gave me MODE0, but I'd prefer
to init pins in board.c.  I've also noticed for pin SDMMC2_DAT3 that
my OMAP3_MUX() entry specifies MODE1, but sysfs shows MODE4; it
changed to MODE1 after adding:
 omap_mux_init_signal("mcspi3_cs0", OMAP_PIN_OUTPUT);

Is just having the mode in omap_board_mux entries sufficient?

Thanks!
,
John
