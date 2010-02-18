From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] DSPBRIDGE: unrelated fixes
Date: Thu, 18 Feb 2010 15:55:32 -0600
Message-ID: <1266530134-8186-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55632 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab0BRVm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:42:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

A couple of unrelated fixes.

Omar Ramirez Luna (2):
  DSPBRIDGE: logic error fix for SleepDSP timeout value
  DSPBRIDGE: check pointer before dereference

 drivers/dsp/bridge/pmgr/msg.c           |   16 ++++++++--------
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

