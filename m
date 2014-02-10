From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 00/17] i2c: deprecate class based instantiation for embedded
	I2C drivers
Date: Mon, 10 Feb 2014 11:03:54 +0100
Message-ID: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With I2C, class based instantiation means if a master driver has e.g.
I2C_CLASS_HWMON set, all slave drivers with this class will try to probe a
device using an array of possible addresses and some heuristics. That creates
traffic and needs time, even when nothing is connected. This mechanism is
needed when you do not have another method to describe the slaves. Embedded I2C
drivers do not need class based instantiation, since there is i2c_board_info or
devicetree description. Some drivers have the class flags set, though, and it
has spread further over the years. We can't remove the flags directly, because
there might be users out there relying on this feature. So, we add a
deprecation warning if a device is instantiated via class attributes. After
giving some time to switch over, we can then finally remove the class flags and
gain boot time.

Patch 1 adds some missing documentation. Patch 2 adds the deprecation feature.
Patches 3+4 are tested on hardware I need. Patches 5-17 are suggestions for
drivers I think could benefit from that. For those, acks are needed before I
will apply them to my tree. If you use a different driver which can also
benefit from this, just send a patch adding the new DEPRECATED flag.

The series can also be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/deprecated_class

Thanks,

   Wolfram


Wolfram Sang (17):
  Documentation: i2c: describe devicetree method for instantiating
    devices
  i2c: add deprecation warning for class based instantiation
  i2c: i2c-omap: deprecate class based instantiation
  i2c: i2c-at91: deprecate class based instantiation
  i2c: i2c-bcm2835: deprecate class based instantiation
  i2c: i2c-bfin-twi: deprecate class based instantiation
  i2c: i2c-davinci: deprecate class based instantiation
  i2c: i2c-designware-platdrv: deprecate class based instantiation
  i2c: i2c-mv64xxx: deprecate class based instantiation
  i2c: i2c-nomadik: deprecate class based instantiation
  i2c: i2c-ocores: deprecate class based instantiation
  i2c: i2c-rcar: deprecate class based instantiation
  i2c: i2c-s3c2410: deprecate class based instantiation
  i2c: i2c-sirf: deprecate class based instantiation
  i2c: i2c-stu300: deprecate class based instantiation
  i2c: i2c-tegra: deprecate class based instantiation
  i2c: i2c-xiic: deprecate class based instantiation

 Documentation/i2c/instantiating-devices     | 34 +++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-at91.c               |  2 +-
 drivers/i2c/busses/i2c-bcm2835.c            |  2 +-
 drivers/i2c/busses/i2c-bfin-twi.c           |  2 +-
 drivers/i2c/busses/i2c-davinci.c            |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
 drivers/i2c/busses/i2c-mv64xxx.c            |  2 +-
 drivers/i2c/busses/i2c-nomadik.c            |  2 +-
 drivers/i2c/busses/i2c-ocores.c             |  2 +-
 drivers/i2c/busses/i2c-omap.c               |  2 +-
 drivers/i2c/busses/i2c-rcar.c               |  2 +-
 drivers/i2c/busses/i2c-s3c2410.c            |  2 +-
 drivers/i2c/busses/i2c-sirf.c               |  2 +-
 drivers/i2c/busses/i2c-stu300.c             |  2 +-
 drivers/i2c/busses/i2c-tegra.c              |  2 +-
 drivers/i2c/busses/i2c-xiic.c               |  2 +-
 drivers/i2c/i2c-core.c                      |  7 ++++++
 include/linux/i2c.h                         |  1 +
 18 files changed, 55 insertions(+), 17 deletions(-)

-- 
1.8.5.1
