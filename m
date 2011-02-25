From: Hema HK <hemahk@ti.com>
Subject: [PATCH 0/5 v2] usb: musb: Power management support
Date: Fri, 25 Feb 2011 18:54:01 +0530
Message-ID: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52024 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182Ab1BYNYP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:24:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>

This patch series supports the retention and offmode support in the 
idle path for musb driver using runtime pm APIs.

This is restricted to support offmode and retention only when device not
connected.When device/cable connected with gadget driver loaded, configured
to no idle/standby which will not allow the core transition to retention
or off.

There is no context save/restore done by hardware for musb in OMAP3
and OMAP4,driver has to take care of saving and restoring the context
during offmode.

Musb has a requirement of configuring sysconfig register to force
idle/standby mode and set the ENABLE_FORCE bit in module STANDBY register
for retention and offmode support.

Runtime pm and hwmod frameworks will take care of configuring to force
idle/standby when pm_runtime_put_sync is called and back to no
idle/standby when pm_runeime_get_sync is called.

Compile, boot tested and also tested the retention in the idle path on
OMAP3630Zoom3. And tested the global suspend/resume with offmode enabled.
Usb basic functionality tested on OMAP4430SDP.

There is some problem with idle path offmode in mainline, I could not test
with offmode. But I have tested this patch with resetting the controller
in the idle path when wakeup from retention just to make sure that the
context is lost, and restore path is working fine.

V2 version:
----------
Rebased patches on Felipe's musb-hwmod-pm-runtime branch.
Fixed comments from Felipe.

Hema HK (5):
  usb: otg: TWL4030: Update the last_event variable.
  usb: musb: Remove platform context save/restore APIs
  usb: musb: Idle path retention and offmode support for OMAP3
  usb: musb: OMAP4430: Power down the PHY during board init
  usb:musb: OMAP4430: Save/restore the context

 arch/arm/mach-omap2/omap_phy_internal.c |    7 ++++
 arch/arm/mach-omap2/usb-musb.c          |    4 ++
 drivers/usb/musb/musb_core.c            |   40 +++++++++++++++++++++++
 drivers/usb/musb/musb_core.h            |    4 --
 drivers/usb/musb/musb_gadget.c          |   11 ++++++
 drivers/usb/musb/omap2430.c             |   54 ++++++++++++++----------------
 drivers/usb/otg/twl4030-usb.c           |    2 +
 7 files changed, 89 insertions(+), 33 deletions(-)

