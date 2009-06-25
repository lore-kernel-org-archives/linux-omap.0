From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] driver updates from PM branch for upstream
Date: Thu, 25 Jun 2009 14:34:02 -0700
Message-ID: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58244 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbZFYVeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:34:09 -0400
Received: by ewy6 with SMTP id 6so2748369ewy.37
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:34:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a series of driver patches (i2c, SPI) from the PM branch
that are ready to go upstream via the sybsystem lists.

Here's one more review pass before I send them to their respective lists.

Applies to current Linus' tree or 'omap-fixes' branch of linux-omap.

Kevin


Hemanth V (1):
  OMAP3 McSPI: Adds context save/restore

Jouni Hogander (2):
  OMAP: McSPI: enable wake-ups and smart-idle
  OMAP: McSPI: Convert bit shifted values into BIT format

Rajendra Nayak (1):
  I2C: OMAP3: PM: (re)init for every transfer to support off-mode

 drivers/i2c/busses/i2c-omap.c |   59 +++++++++-----
 drivers/spi/omap2_mcspi.c     |  179 +++++++++++++++++++++++++++++------------
 2 files changed, 165 insertions(+), 73 deletions(-)

