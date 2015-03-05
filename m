From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 0/3] remoteproc: Introduce wkup_m3_rproc driver
Date: Wed, 4 Mar 2015 21:53:57 -0600
Message-ID: <1425527640-2690-1-git-send-email-d-gerlach@ti.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
This patch series is version two of the series to add a
wkup_m3_rproc driver for TI AM335x SoCs. This family of SoCs
contains an ARM Cortex M3 coprocessor that is responsible for
low-level power tasks that cannot be handled by the main ARM
Cortex A8 so firmware running from the CM3 can be used instead.
This driver handles loading of the firmware and reset of the CM3
once it is booted.

The previous version of this series can be found here [1].
I have pushed a branch based on v4.0-rc1 containing the entire 
am335x suspend series here for a higher level view of the entire
series of patch sets here [2].

This patch set contains a new patch from Suman Anna that replaces
the RSC_INTMEM patch that this series used to depend on based on
comments on that series. More info is included in the patch.
Additional changes are:

v1 -> v2:
-firmware loaded has changed, new code added by Suman Anna
-wkup_m3_rproc can now be built and loaded as a module
-added binding info and docs for am437x support
-dts and pdata-quirks patch split to separate mach-omap2 series
-remove ti,no-reset-on-init from required dt binding as it asserts
 hardreset which is default state of wkup_m3 anyway

The driver expects to load firmware am335x-pm-firmware.elf from
/lib/firmware which is found here [3].

Regards,
Dave

[1] http://www.spinics.net/lists/arm-kernel/msg387984.html
[2] https://github.com/dgerlach/linux-pm/tree/pm-v4.0-rc1-am335x-suspend
[3] https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/commits/next-upstream

Dave Gerlach (2):
  Documentation: dt: add ti,am3353-wkup-m3 bindings
  remoteproc: wkup_m3: Add wkup_m3 remoteproc driver

Suman Anna (1):
  remoteproc: add a rproc ops for performing address translation

 .../bindings/remoteproc/wkup_m3_rproc.txt          |  46 +++++
 drivers/remoteproc/Kconfig                         |  13 ++
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/remoteproc_core.c               |  31 ++-
 drivers/remoteproc/wkup_m3_rproc.c                 | 229 +++++++++++++++++++++
 include/linux/platform_data/wkup_m3.h              |  25 +++
 include/linux/remoteproc.h                         |   2 +
 7 files changed, 341 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h

-- 
2.3.0
