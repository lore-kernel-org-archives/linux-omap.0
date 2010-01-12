From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] OMAP: UART conversion to omap_device/omap_hwmod
Date: Tue, 12 Jan 2010 15:58:46 -0800
Message-ID: <1263340728-17929-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62353 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab0ALX6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 18:58:51 -0500
Received: by pwj9 with SMTP id 9so2460315pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 15:58:50 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series applies on curren PM branch plus my omap_device series
posted on 8 jan:

  [PATCH 0/3] misc. omap_device/omap_hwmod updates

and is also available as branch 'pm-wip/uart' in my linux-omap-pm repo[1].

This series should allow further development and testing of the new
omap-serial driver from Govindraj.

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git

Kevin Hilman (2):
  OMAP3: add omap_hwmods for UART1,2,3
  OMAP: UART: omap_device converions, remove implicit 8520 assumptions

 arch/arm/mach-omap2/omap_hwmod_34xx.h |  188 +++++++++++++
 arch/arm/mach-omap2/serial.c          |  474 +++++++++++++++++----------------
 2 files changed, 430 insertions(+), 232 deletions(-)

