From: ming.lei@canonical.com
Subject: [PATCH v6 0/3] OMAP4: support PMU
Date: Sat, 26 Nov 2011 10:53:46 +0800
Message-ID: <1322276029-3701-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44459 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab1KZCyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 21:54:15 -0500
Received: by iage36 with SMTP id e36so5397164iag.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 18:54:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com

Hi,

These 3 patches are against -next tree and Benoit's debugss 
hwmod patch, so pmu irq on OMAP4 can be routed OK to CPU
with these patches, and perf can work well on OMAP4 now.


[1], http://marc.info/?l=linux-arm-kernel&m=132162120904916&w=2


thanks,
--
Ming Lei

