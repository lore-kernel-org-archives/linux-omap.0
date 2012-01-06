From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [GIT PULL] I2C: OMAP: misc. updates for v3.3
Date: Thu, 05 Jan 2012 16:13:51 -0800
Message-ID: <87boqh7kn4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ben,

Here's a few OMAP I2C updates for the v3.3 merge window.

Thanks,

Kevin

The following changes since commit 3f6b2a8bd6e4ff43269d89066a9fe06a0e5ba961:

  I2C: OMAP: correct SYSC register offset for OMAP4 (2011-12-13 11:35:56 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/i2c/misc

Benoit Cousson (1):
      i2c: OMAP: Add DT support for i2c controller

Jan Weitzel (1):
      I2C: OMAP: NACK without STP

 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
 drivers/i2c/busses/i2c-omap.c                      |  108 +++++++++++++-------
 2 files changed, 99 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
