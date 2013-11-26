From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 0/4] musb/dsps: suspend related patches for 3.14 (rebased)
Date: Tue, 26 Nov 2013 13:31:10 +0100
Message-ID: <1385469074-19312-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:39683 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab3KZMbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 07:31:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

v2 -> v3:
 * removed a development left-over

v3 -> v4:
 * one hunk removed that sneaked in during rebasing


Daniel Mack (4):
  usb: musb: unconditionally save and restore the context on suspend
  usb: musb: call musb_port_suspend from musb_bus_suspend
  usb: musb: dsps: add {tx,rx}_mode to wrapper
  usb: musb: dsps: add support for suspend and resume

 drivers/usb/musb/musb_core.c    | 14 +++++++++-
 drivers/usb/musb/musb_dsps.c    | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_host.c    |  9 +++++-
 drivers/usb/musb/musb_host.h    |  4 +++
 drivers/usb/musb/musb_virthub.c |  4 +--
 include/linux/usb/musb.h        |  3 ++
 6 files changed, 91 insertions(+), 4 deletions(-)

-- 
1.8.4.2

