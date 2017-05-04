From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/9] Drop unnecessary static
Date: Thu,  4 May 2017 22:10:45 +0200
Message-ID: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, keescook@chromium.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, drbd-dev@lists.linbit.com
List-Id: linux-omap@vger.kernel.org

These patches fix cases where there is a static on a local variable, but
the variable is either first initialized or never used, on every possible
execution path through the function.  The static has no benefit, and
dropping it reduces the code size.

---

 drivers/block/drbd/drbd_nl.c            |    2 +-
 drivers/clocksource/timer-fttmr010.c    |    2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
 drivers/mfd/max8925-i2c.c               |    2 +-
 drivers/mfd/twl4030-irq.c               |    2 +-
 drivers/mtd/chips/cfi_cmdset_0020.c     |    2 +-
 drivers/mtd/maps/physmap_of_gemini.c    |    2 +-
 drivers/power/supply/axp20x_usb_power.c |    2 +-
 drivers/regulator/palmas-regulator.c    |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
