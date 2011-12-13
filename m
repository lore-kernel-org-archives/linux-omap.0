From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [GIT PULL] I2C: OMAP fixes for v3.2-rc
Date: Tue, 13 Dec 2011 11:50:38 -0800
Message-ID: <87d3bsuu7l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Jean,

Could you pull the following I2C fixes for the OMAP platform for v3.2?
The first one belongs in stable (change log already Cc's stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)

Since this is an embedded platform, I have asked Ben Dooks a few times
but gotten no response, so am hoping you can queue these before it's too
late for v3.2-rc.

Thanks,

Kevin

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/i2c

Alexander Aring (1):
      I2C: OMAP: correct SYSC register offset for OMAP4

Shubhrajyoti D (1):
      I2C: OMAP: fix FIFO usage for OMAP4

 drivers/i2c/busses/i2c-omap.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)
