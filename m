From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v3 0/7] OMAP System Control Module
Date: Wed, 27 Jun 2012 22:04:32 +0400
Message-ID: <4FEB4B30.2040305@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52637 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756107Ab2F0SEf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 14:04:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

 Hello.

This is a next version of series of patches(based on Eduardo Valentin's patch set) adding a basic support for system control module, on OMAP4+ context. It is a working in progress.

Main changes since previous patch set version:
- Bandgap and usb phy: drivers are now independent from control module driver, they use their own functions to acess scm registers.
- omap-control-core: resources aren't hardcoded, they are specified in dts file.
- omap-control-core: Control module is a built-in driver - added control module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
Probably, no configuration option is required!
- omap-control-core: Added early init call that ioremaps control module IOMEM window, this allows access of SCM registers very early, for example from omap_type()
- omap-control-core: Removed device pointer from omap-control-core API arguments, becuase there can be only one instance control
module device.
- omap-control-core: removed omap_control_get, omap_control_readl, omap_control_writel
- omap-control-core: added omap_control_status_read that is used early in omap_type
- Bandgap and usb phy: Added private spinlocks for bandgap and usb drivers.
- Bandgap: Check the type of bandgap dynamically in bandgap driver probe function by reading
omap core control module revision register CONTROL_GEN_CORE_REVISION.
- Bandgap and usb phy: Parent SCM platform device IOMEM resources is used to get the base address of SCM window.
- Bandgap masks defines were moved to drivers/thermal/omap-bandgap.c.

TODO list for bandgap driver:
- Reserve omap-control-core IOMEM window.
- Improve thermal zone definition for OMAP4
- Introduce the thermal zones for OMAP5
