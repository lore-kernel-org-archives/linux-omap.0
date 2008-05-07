From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 0/2] OMAP3 EVM: Add touchscreen support
Date: Tue, 6 May 2008 19:37:52 -0700
Message-ID: <5e088bd90805061937t1f4d81fdteffbe5f07f75c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:25111 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbYEGChy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 22:37:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so70534fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 19:37:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a re-submission addressing the comments given on my intial submission.

These patches are intended to be applied after my previous "twl4030:
set irq number" patch.

Touchscreen support was tested on my EVM using an x11 rootfs.  I was
able to calibrate the touchscreen, use the onscreen keyboard, and
manipulate UI widgets.
