From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 0/4] musb/dsps: suspend related patches for 3.14 (rebased)
Date: Mon, 25 Nov 2013 22:26:39 +0100
Message-ID: <1385414803-13212-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:53754 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab3KYV1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 16:27:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

v1 -> v2:

 * *un*conditionally save and restore registers upon suspend/resume
   rather than only doing it for the DSPS glue.
 * do not call musb_port_reset() from glue, but rather introduce a
   flag and let musb-hdrc.ko do it.
 * dropped 'usb: musb: dsps: indentation and whitespace fixes'

Daniel Mack (4):
  usb: musb: unconditionally save and restore the context on suspend
  usb: musb: call musb_port_suspend from musb_bus_suspend
  usb: musb: dsps: add {tx,rx}_mode to wrapper
  usb: musb: dsps: add support for suspend and resume

 drivers/usb/musb/musb_core.c    | 14 ++++++++-
 drivers/usb/musb/musb_dsps.c    | 64 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_host.c    |  9 +++++-
 drivers/usb/musb/musb_host.h    |  4 +++
 drivers/usb/musb/musb_virthub.c |  4 +--
 include/linux/usb/musb.h        |  3 ++
 6 files changed, 94 insertions(+), 4 deletions(-)

-- 
1.8.4.2

