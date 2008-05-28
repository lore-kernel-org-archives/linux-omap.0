From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 0/4] OMAP3 Beagle: update defconfig to match board file
Date: Tue, 27 May 2008 22:45:03 -0700
Message-ID: <5e088bd90805272245q4ab6c1aue4b4d7d76e025422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:42899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbYE1FpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 01:45:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1695070fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 27 May 2008 22:45:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

While preparing a set of patches to add nand support for beagle I
noticed that the beagle defconfig hasn't kept up with the features
present in board-omap3beagle.c

This series of patches updates the defconfig to enable mmc, rtc, usb, and fb
