From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/3] mfd: menelaus: couple simple cleanups
Date: Sat, 28 Mar 2015 22:45:34 +0200
Message-ID: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:50147 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbbC1UqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Mar 2015 16:46:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

Hi,

I came across these while trying to start DT conversion for menelaus
(http://marc.info/?t=141970287300005&r=1&w=2).

While the DT work failed and is still pending, I think it's still worth
to apply these as they are independent and they remove some cruft
from the tree.

A.

Aaro Koskinen (3):
  mfd: menelaus: delete omap_has_menelaus
  mfd: menelaus: drop support for SW controller VCORE
  mfd: menelaus: use macro for magic number

 drivers/mfd/menelaus.c       | 25 +------------------------
 include/linux/mfd/menelaus.h |  7 -------
 2 files changed, 1 insertion(+), 31 deletions(-)

-- 
2.2.0

