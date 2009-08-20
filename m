From: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] i2c-omap: I2C clean-up patch
Date: Thu, 20 Aug 2009 11:21:13 -0500
Message-ID: <1250785276-31713-1-git-send-email-m-sonasath@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch includes the following fixes:
-Fix I2C status ACK
-ACK pending [R/X]DR and [R/X]RDY interrupts in the error/completeion path
-Enable workaround for Errata 1.153 based on I2C IP block

Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

Moiz Sonasath (3):
  i2c-omap: Fix I2C status ACK
  i2c-omap: ACK pending [R/X]DR and [R/X]RDY interrupts in the
    error/completeion path
  i2c-omap: Enable workaround for Errata 1.153 based on I2C IP block

 drivers/i2c/busses/i2c-omap.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
