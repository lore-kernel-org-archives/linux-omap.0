From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] CBUS Patches
Date: Mon, 13 Jun 2011 22:40:56 +0300
Message-ID: <1307994058-25486-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57752 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab1FMTlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 15:41:03 -0400
Received: by mail-fx0-f43.google.com with SMTP id 3so4002924fxm.2
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 12:41:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

the following two patches get rid of
the static global variable holding the
bus context. It's not needed at all.

This will allow us to have multiple
CBUS buses by using different GPIOs.

Will never be useful, but that's it
should've been done anyway :-p

Felipe Balbi (2):
  cbus: make cbus parent of bus users
  cbus: pass device as argument

 arch/arm/mach-omap1/board-nokia770.c |    4 ++++
 arch/arm/mach-omap2/board-n8x0.c     |    4 ++++
 drivers/cbus/cbus.c                  |   20 +++++++++++---------
 drivers/cbus/cbus.h                  |    5 +++--
 drivers/cbus/retu.c                  |    4 ++--
 drivers/cbus/tahvo.c                 |    9 +++++++--
 6 files changed, 31 insertions(+), 15 deletions(-)

-- 
1.7.6.rc1

