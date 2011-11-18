From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 0/4] Device tree support for regulators
Date: Fri, 18 Nov 2011 16:47:16 +0530
Message-ID: <1321615040-13257-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

v5 is based on 3.2-rc2 and has the following changes
-1- Used microvolt/microamp in bindings instead of uV/uA
-2- Added more documentation surrounding regulator-consumer
mapping in the core bindings
-3- Dropped CONFIG_OF_REGULATOR and use just CONFIG_OF
-4- Reused core regulator bindings on Fixed regulator bindings
-5- Corrected the gpio binding for Fixed regulator

The patches can be found here:
git://gitorious.org/omap-pm/linux.git for-dt/regulator

For the first 2 patches (1/4 and 2/4) I have dropped
Acks from Mark, since they have changed to some extent
from the last post and retained the Acks recieved on the
last 2 patches (3/4 and 4/4) as they remain unchanged.

regards,
Rajendra

Rajendra Nayak (4):
  regulator: helper routine to extract regulator_init_data
  regulator: adapt fixed regulator driver to dt
  regulator: pass additional of_node to regulator_register()
  regulator: map consumer regulator based on device tree

 .../bindings/regulator/fixed-regulator.txt         |   29 +++++++
 .../devicetree/bindings/regulator/regulator.txt    |   54 +++++++++++++
 drivers/regulator/88pm8607.c                       |    2 +-
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/aat2870-regulator.c              |    2 +-
 drivers/regulator/ab3100.c                         |    2 +-
 drivers/regulator/ab8500.c                         |    2 +-
 drivers/regulator/ad5398.c                         |    2 +-
 drivers/regulator/bq24022.c                        |    2 +-
 drivers/regulator/core.c                           |   82 ++++++++++++++++---
 drivers/regulator/da903x.c                         |    2 +-
 drivers/regulator/db8500-prcmu.c                   |    2 +-
 drivers/regulator/dummy.c                          |    2 +-
 drivers/regulator/fixed.c                          |   62 +++++++++++++++-
 drivers/regulator/isl6271a-regulator.c             |    2 +-
 drivers/regulator/lp3971.c                         |    2 +-
 drivers/regulator/lp3972.c                         |    2 +-
 drivers/regulator/max1586.c                        |    2 +-
 drivers/regulator/max8649.c                        |    2 +-
 drivers/regulator/max8660.c                        |    2 +-
 drivers/regulator/max8925-regulator.c              |    2 +-
 drivers/regulator/max8952.c                        |    2 +-
 drivers/regulator/max8997.c                        |    2 +-
 drivers/regulator/max8998.c                        |    2 +-
 drivers/regulator/mc13783-regulator.c              |    2 +-
 drivers/regulator/mc13892-regulator.c              |    2 +-
 drivers/regulator/of_regulator.c                   |   81 +++++++++++++++++++
 drivers/regulator/pcap-regulator.c                 |    2 +-
 drivers/regulator/pcf50633-regulator.c             |    2 +-
 drivers/regulator/tps6105x-regulator.c             |    3 +-
 drivers/regulator/tps65023-regulator.c             |    2 +-
 drivers/regulator/tps6507x-regulator.c             |    2 +-
 drivers/regulator/tps6524x-regulator.c             |    2 +-
 drivers/regulator/tps6586x-regulator.c             |    2 +-
 drivers/regulator/tps65910-regulator.c             |    2 +-
 drivers/regulator/tps65912-regulator.c             |    2 +-
 drivers/regulator/twl-regulator.c                  |    2 +-
 drivers/regulator/wm831x-dcdc.c                    |    8 +-
 drivers/regulator/wm831x-isink.c                   |    2 +-
 drivers/regulator/wm831x-ldo.c                     |    6 +-
 drivers/regulator/wm8350-regulator.c               |    2 +-
 drivers/regulator/wm8400-regulator.c               |    2 +-
 drivers/regulator/wm8994-regulator.c               |    2 +-
 include/linux/regulator/driver.h                   |    4 +-
 include/linux/regulator/of_regulator.h             |   20 +++++
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 46 files changed, 362 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h
