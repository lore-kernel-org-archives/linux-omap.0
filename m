From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 0/4] omap smps regulator support
Date: Mon, 20 Feb 2012 12:26:04 +0200
Message-ID: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50097 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab2BTK0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 05:26:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Just some cosmetic changes compared to previous version:

- dropped out '[patchv9 4/5] regulator: twl4030: add support for external
  controller', as this was accepted for merge by Mark
- changed names of regulators from VDD1 / VDD2 -> vdd_mpu_iva / vdd_core
  in patch 3
- added document codes for TWL data manuals used as reference to commit log
  in patch 3

-Tero

