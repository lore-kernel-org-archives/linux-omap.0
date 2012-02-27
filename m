From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 16:05:59 +0530
Message-ID: <1330338961-31765-1-git-send-email-rnayak@ti.com>
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

Re-sending on top of Tero's changes which are already
in -next and the one which adds support for twl6030 
vdd1/2/3 SMPS [1].

v3 has mainly 2 differences from v2
-1- TWL driver now uses just one table for both dt and
non-dt based lookup for driver data.
-2- All common regulator nodes for twl4030 and twl6030 are
now defined in the twl4030.dtsi and twl6030.dtsi instead of
repeating the nodes in all board files, which also means
the patch ('arm/dts: twl: Pass regulator data from dt')
has a dependency with the series from Benoit which adds the
twl4030.dtsi and twl6030.dtsi files[2].

I have tested the patches on omap4panda and omap3beagle boards.

[1] http://marc.info/?l=linux-omap&m=133009693905864&w=2
[2] git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
	for_3.4/dt_i2c_twl

Rajendra Nayak (2):
  regulator: twl: adapt twl-regulator driver to dt
  arm/dts: twl: Pass regulator data from dt

 .../bindings/regulator/twl-regulator.txt           |   66 +++++
 arch/arm/boot/dts/omap3-beagle.dts                 |    6 +
 arch/arm/boot/dts/twl4030.dtsi                     |   18 ++
 arch/arm/boot/dts/twl6030.dtsi                     |   60 +++++
 drivers/regulator/twl-regulator.c                  |  259 +++++++++++++-------
 5 files changed, 322 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
