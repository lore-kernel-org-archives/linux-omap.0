From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v12 0/4] Allow USB devices to remain runtime-suspended when sleeping
Date: Thu,  7 Jan 2016 16:46:11 +0100
Message-ID: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, Tomas Winkler <tomas.winkler@intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

this is v12 of an attempt to make it easier for devices to remain in
runtime PM when the system goes to sleep, mainly to reduce the time
spent resuming devices.

For this, we interpret the absence of all PM callback implementations as
it being safe to do direct_complete, so their ancestors aren't prevented
from remaining runtime-suspended.

Additionally, the prepare() callback of USB devices will return 1 if
runtime PM is enabled and the current wakeup settings are correct.

With these changes, a uvcvideo device (for example) stays in runtime
suspend when the system goes to sleep and is left in that state when the
system resumes, not delaying it unnecessarily.

Thanks,

Tomeu

Changes in v12:
- Include linux/pm_domain.h in vga_switcheroo.c for dev_pm_domain_set()

Changes in v11:
- Move calls to dev_pm_domain_set() out from &dev->power.lock as that
  isn't needed for dev->pm_domain.

Changes in v10:
- Remove superfluous call to pm_runtime_enabled() as suggested by Alan

Changes in v9:
- Add docs noting the need for the device lock to be held before calling
  device_is_bound()
- Add docs noting the need for the device lock to be held before calling
  dev_pm_domain_set()
- Move to CONFIG_PM_SLEEP as suggested by Rafael and Ulf.
- Rename from device_check_pm_callbacks to device_pm_check_callbacks to
  follow with the naming convention of existing API.
- Re-add calling to device_pm_check_callbacks from device registration
  and when updating the PM domain of a device.

Changes in v8:
- Add device_is_bound()
- Add dev_pm_domain_set() and update code to use it
- Move no_pm_callbacks field into CONFIG_PM_SLEEP
- Call device_check_pm_callbacks only after a device is bound or unbound

Changes in v7:
- Reduce indentation by adding a label in device_prepare()

Changes in v6:
- Add stub for !CONFIG_PM.
- Move implementation of device_check_pm_callbacks to power/main.c as it
  doesn't belong to CONFIG_PM_SLEEP.
- Take dev->power.lock before modifying flag.

Changes in v5:
- Check for all dev_pm_ops instances associated to a device, updating a
  no_pm_callbacks flag at the times when that could change.

Tomeu Vizoso (4):
  device core: add device_is_bound()
  PM / Domains: add setter for dev.pm_domain
  PM / sleep: Go direct_complete if driver has no callbacks
  USB / PM: Allow USB devices to remain runtime-suspended when sleeping

 arch/arm/mach-omap2/omap_device.c |  7 ++++---
 drivers/acpi/acpi_lpss.c          |  5 ++++-
 drivers/acpi/device_pm.c          |  5 +++--
 drivers/base/dd.c                 | 21 +++++++++++++++++++--
 drivers/base/power/clock_ops.c    |  5 +++--
 drivers/base/power/common.c       | 24 ++++++++++++++++++++++++
 drivers/base/power/domain.c       |  8 ++++++--
 drivers/base/power/main.c         | 35 +++++++++++++++++++++++++++++++++++
 drivers/base/power/power.h        |  3 +++
 drivers/gpu/vga/vga_switcheroo.c  | 11 ++++++-----
 drivers/misc/mei/pci-me.c         |  5 +++--
 drivers/misc/mei/pci-txe.c        |  5 +++--
 drivers/usb/core/port.c           |  6 ++++++
 drivers/usb/core/usb.c            |  8 +++++++-
 include/linux/device.h            |  2 ++
 include/linux/pm.h                |  1 +
 include/linux/pm_domain.h         |  3 +++
 17 files changed, 132 insertions(+), 22 deletions(-)

-- 
2.5.0

