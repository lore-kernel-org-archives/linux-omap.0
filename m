From: Ari Kauppi <Ext-Ari.Kauppi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] i2c: i2c-omap: Reliablity and register fixes
Date: Fri,  6 Mar 2009 15:34:52 +0200
Message-ID: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Two patches for i2c-omap driver.

Ari Kauppi (1):
  i2c: i2c-omap: Call request_irq with IRQF_DISABLED

Eero Nurkkala (1):
  i2c: i2c-omap: Fix BUFSTAT_REG reading

 drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)
