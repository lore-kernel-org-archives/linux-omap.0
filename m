From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 0/7] OMAP3 EVM: series of patches to add additional hw support
Date: Mon, 28 Apr 2008 16:27:13 -0700
Message-ID: <5e088bd90804281627x694b4084x334d6d4f76ee44fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:41034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbYD1X1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:27:14 -0400
Received: by ug-out-1314.google.com with SMTP id z38so952864ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 16:27:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series of patches adds support for mmc, usb, onenand, lcd, and
rtc on the OMAP3 EVM.

The first patch (mmc) was submitted individually a couple of days ago
-- I'm resubmitting it as part of this group since the usb, onenand,
lcd, and rtc patches assume that the mmc patch has been applied first.

I have tested the resulting kernel on my OMAP 35XX EVM.

Steve
