From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/07] pm: remove late/early platform driver pm
	callbacks V2
Date: Wed, 24 Jun 2009 18:23:06 +0900
Message-ID: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

pm: remove late/early platform driver pm callbacks V2

[PATCH 01/07] arm: rework omap suspend_late()/resume_early()
[PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
[PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
[PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
[PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume() V2
[PATCH 06/07] usb: rework musb suspend()/resume_early()
[PATCH 07/07] pm: remove platform device suspend_late()/resume_early() V2

These patches simply remove ->suspend_late() and ->resume_early()
from struct platform_driver. Drivers are converted to dev_pm_ops
with CONFIG_SUSPEND in mind. Untested.

All patches except [02/07] are known to compile.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - resolved conflicts in [05/07], rediffed [07/07]
 - include lkml, linux-usb and akpm

 arch/arm/plat-omap/debug-leds.c  |   11 +++++++----
 arch/arm/plat-omap/gpio.c        |   14 ++++++++++----
 drivers/base/platform.c          |   36 ------------------------------------
 drivers/dma/dw_dmac.c            |   15 ++++++++++-----
 drivers/dma/txx9dmac.c           |   15 ++++++++++-----
 drivers/i2c/busses/i2c-pxa.c     |   25 +++++++++++++++++--------
 drivers/i2c/busses/i2c-s3c2410.c |   25 ++++++++++++++++---------
 drivers/usb/musb/musb_core.c     |   18 ++++++++++++------
 include/linux/platform_device.h  |    2 --
 9 files changed, 82 insertions(+), 79 deletions(-)
