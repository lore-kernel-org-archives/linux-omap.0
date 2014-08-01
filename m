From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/1] ARM: OMAP: add external clock provider support
Date: Fri, 1 Aug 2014 16:15:47 +0300
Message-ID: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40378 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881AbaHANPJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Aug 2014 09:15:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, linux-omap@vger.kernel.org, sassmann@kpanic.de, peter.ujfalusi@ti.com, jsarha@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This patch adds possibility to register external clocks (outside the main
SoC) on TI boards through device tree. Clock sources as such include for
example twl-6030 / twl-6040 chips and variants which can be used to clock
for example audio / WLAN chips.

This patch can be queued once someone has a use-case + patches that requires
usage of such clocks.

-Tero

