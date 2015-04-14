From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC 0/5] PM / clock_ops: provide default runtime ops and cleanup users
Date: Tue, 14 Apr 2015 19:04:28 +0530
Message-ID: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39865 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbbDNNer (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2015 09:34:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@deeprootsystems.com, nsekhar@ti.com, magnus.damm@gmail.com
Cc: linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>

Most users of PM clocks do the exact same thing in runtime callbacks.
Provide default callbacks and cleanup the existing users (keystone/davinci/omap1/sh)

Rajendra Nayak (5):
  PM / clock_ops: Provide default runtime ops to users
  arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
  arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
  arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
  drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS

 arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
 arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
 arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
 drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
 drivers/sh/pm_runtime.c            | 47 ++------------------------------------
 include/linux/pm_clock.h           | 10 ++++++++
 6 files changed, 54 insertions(+), 143 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

