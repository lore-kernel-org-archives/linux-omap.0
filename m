From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/4] clk: dt: add support for default rate/parent
Date: Thu, 13 Feb 2014 11:00:44 +0200
Message-ID: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49426 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbaBMJB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 04:01:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

This set is a mix-match of new DT properties for generic and TI specific
clock drivers. Basically provided for commenting purposes. The patches
provide a way to configure clock parents / rates during boot through DT.

"default-rate" : sets rate of a clock during boot, supported for any DT
		 clock type (through generic clock driver)
"ti,default-parent" : selects a default parent for a multiplexer clock,
		      only supported for TI specific mux clock for now,
		      as generic mux clock does not support DT clocks

Patch #4 provided as a reference how to move the default rates / parents
from kernel code to DT.

Default-rate logic in patch #2 looks somewhat complicated, as the clocks
need to be sorted based on their parents to avoid cases where a child clock
would set its rate first, just to be overridden by its parent changing
rate later and resulting in incorrect rate for the child clock.

If the default-rate generic property is not going to fly, it can be moved
to TI only drivers also.

-Tero

