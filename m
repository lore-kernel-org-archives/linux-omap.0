From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] i2c-omap patches for 2.6.35 merge window
Date: Tue, 11 May 2010 11:35:01 -0700
Message-ID: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52191 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0EKSe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 14:34:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org, ben-linux@fluff.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are the i2c-omap patches that we'd like to get in for 2.6.35.

I believe all of these patches have been posted earlier already
to the i2c list. They all have been merged into the linux-omap master
branch for testing. 

I've removed some duplicate Cc fields from the commit messages
for the obvious mailings lists and the people who will be merging
them.

Anyways, if no comments over the next few days, I'll reply to
this message with a pull request for Ben.

Regards,

Tony

---

Alexander Shishkin (2):
      omap: i2c: make errata 1.153 workaround a separate function
      omap: i2c: add a timeout to the busy waiting

Kalle Jokiniemi (1):
      i2c-omap: add mpu wake up latency constraint in i2c

Santosh Shilimkar (1):
      omap: i2c: Add i2c support on omap4 platform

manjugk manjugk (2):
      OMAP2/3: I2C: Errata ID i207: Clear wrong RDR interrupt
      OMAP3: I2C: Clean up Errata 1p153 handling


 arch/arm/plat-omap/i2c.c      |   39 ++++--
 drivers/i2c/busses/i2c-omap.c |  265 ++++++++++++++++++++++++++++++++---------
 include/linux/i2c-omap.h      |    9 +
 3 files changed, 246 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/i2c-omap.h

-- 
Signature
