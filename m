From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/8] staging: tidspbridge: PM routines cleanup
Date: Wed, 23 Mar 2011 12:49:45 -0600
Message-ID: <1300906193-1732-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47124 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab1CWTBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Mar 2011 15:01:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe <x0095078@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Cleanup and fixes for tidspbridge's PM routines.

The most significant ones are:
- Protection of critical sections when disabling clocks which
  could cause issues during PM transitions.
- Fix of resume path from RET power state.

Other patches are cleanups and preparations for the usage of
spinlock.

Omar Ramirez Luna (8):
  staging: tidspbridge: make wake_dsp to handle PM code
  staging: tidspbridge: fix resume path from retention
  staging: tidspbridge: remove msleep for dsp transition wait
  staging: tidspbridge: send mbox PM command directly
  staging: tidspbridge: send wake message even if dsp is running
  staging: tidspbridge: remove redundant code from PM routines
  staging: tidspbridge: remove redundant indentation in PM routines
  staging: tidspbridge: protect critical sections on PM routines

 drivers/staging/tidspbridge/core/tiomap3430_pwr.c |  248 ++++++++++++++-------
 drivers/staging/tidspbridge/core/tiomap_io.c      |   58 +-----
 2 files changed, 168 insertions(+), 138 deletions(-)

