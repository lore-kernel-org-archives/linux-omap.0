From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/5] Device tree support for regulators
Date: Mon, 10 Oct 2011 21:49:33 +0530
Message-ID: <1318263578-7407-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mark, Grant,

I have reworked the regulator-dt-suppport series based
on your reviews and also split it so I remove any dependency
with the omap specific dt conversion for i2c/twl.
So this latest series is based on mainline 3.1-rc9.

I will post the twl-regulator driver adaptation to dt and
the omap-panda/omap-sdp board regulator data being
passed from dt as a seperate series.

changes in v2:
-1- removed the int to u32 convertions as -ve voltages do exist
-2- merged patches to support fixed voltage regulator dt adaptation
-3- added support for regulator_get() without a device associated (ex: cpufreq)
-4- used same binding for regulator<->consumer and regulator<->parent mapping

regards,
Rajendra

Rajendra Nayak (5):
  regulator: twl: Remove hardcoded board constraints from driver
  dt: add empty dt helpers for non-dt build
  regulator: helper routine to extract regulator_init_data
  regulator: adapt fixed regulator driver to dt
  regulator: map consumer regulator based on device tree

 .../bindings/regulator/fixed-regulator.txt         |   24 +++++
 .../devicetree/bindings/regulator/regulator.txt    |   44 +++++++++
 drivers/regulator/Kconfig                          |    8 ++
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/core.c                           |   91 ++++++++++++++++---
 drivers/regulator/fixed.c                          |   58 ++++++++++++
 drivers/regulator/of_regulator.c                   |   93 ++++++++++++++++++++
 drivers/regulator/twl-regulator.c                  |    8 --
 include/linux/of.h                                 |   19 ++++
 include/linux/regulator/driver.h                   |    2 +
 include/linux/regulator/of_regulator.h             |   21 +++++
 11 files changed, 346 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h
