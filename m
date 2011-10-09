From: Michael Opdenacker <michael.opdenacker@linaro.org>
Subject: [PATCH 0/1] arm: omap: remove obsolete IRQF_DISABLED
Date: Sun,  9 Oct 2011 07:46:37 +0200
Message-ID: <1318139198-6865-1-git-send-email-michael.opdenacker@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43357 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab1JIFqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Oct 2011 01:46:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patches@linaro.org

Remove all occurrences of IRQF_DISABLED in the OMAP tree.
This flag is deprecated and obsolete and as IRQ handlers now run
with all interrupts disabled since 2.6.36

