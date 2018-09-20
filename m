From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/4] i2c: core: introduce master_xfer_irqless
Date: Thu, 20 Sep 2018 18:14:19 +0200
Message-ID: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

To keep the discussion about master_xfer_irqless going, I post here a
draft how I envision the changes to the I2C core. They are only build
tested. I am unsure if I can test them on hardware before next week, so
I'll send them around as RFC already, so people can get an idea and
comment. Maybe Stefan has some bandwidth to test his imx driver
implementation on top of this?

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/xfer_irqless

Happy hacking and thanks for all the input to this,

   Wolfram


Wolfram Sang (4):
  i2c: core: remove outdated DEBUG output
  i2c: core: remove level of indentation in i2c_transfer
  i2c: core: use I2C locking behaviour also for SMBUS
  i2c: core: introduce master_xfer_irqless callback

 drivers/i2c/i2c-core-base.c  | 44 +++++++++++++-----------------------
 drivers/i2c/i2c-core-smbus.c |  7 +++++-
 drivers/i2c/i2c-core.h       | 12 ++++++++++
 include/linux/i2c.h          | 10 +++++---
 4 files changed, 41 insertions(+), 32 deletions(-)

-- 
2.18.0
