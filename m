From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] twl-regulator DT adaptation and updates to add new
	regulators
Date: Tue, 28 Feb 2012 15:09:09 +0530
Message-ID: <1330421953-29517-1-git-send-email-rnayak@ti.com>
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
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Here is a consolidated series which adds DT support for twl regulator
driver and adds support for VDD1/2/3 regulator and support for
fixed LDO V1V8 and V2V1. The patches are based on -next and tested
on omap3 beagle and omap4 panda boards.

I have dropped the patch updating the dts entries for twl4030 and
twl6030 because of other dependencies and will submit them via
the OMAP tree. The driver DT changes however do not have any dependency
on the dts file updates (except that regulator support will not work with DT,
but will not break DT build or boot) and no functionality would change
in the non-DT case.

regards,
Rajendra

Peter Ujfalusi (2):
  regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
  MFD: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS

Rajendra Nayak (1):
  regulator: twl: adapt twl-regulator driver to dt

Tero Kristo (1):
  regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators

 .../bindings/regulator/twl-regulator.txt           |   68 +++++
 drivers/mfd/twl-core.c                             |   25 ++
 drivers/regulator/twl-regulator.c                  |  294 ++++++++++++++------
 include/linux/i2c/twl.h                            |    7 +-
 4 files changed, 309 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
