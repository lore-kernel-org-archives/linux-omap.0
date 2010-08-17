From: hvaibhav@ti.com
Subject: [PATCH 0/3] RTC:A35390A: Add Interrupt API interfaces
Date: Tue, 17 Aug 2010 14:18:38 +0530
Message-ID: <1282034921-22167-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57024 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757104Ab0HQIsz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Aug 2010 04:48:55 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, byron.bbradley@gmail.com, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This patch adds support for interrupt API interfaces like,
     - Alarm interrupt
     - Periodic interrupt
     - Per minute interrupt

Vaibhav Hiremath (3):
  RTC:s35390a: Add Alarm interrupt support
  RTC:s35390a: Add Periodic interrupt support
  RTC:s35390a: Add update_irq (per Min interrupt) support

 drivers/rtc/rtc-s35390a.c |  302 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 299 insertions(+), 3 deletions(-)

