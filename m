From: "Steve Sakoman" <sakoman@gmail.com>
Subject: mmc broken?
Date: Fri, 5 Dec 2008 16:31:04 -0800
Message-ID: <5e088bd90812051631i35d541d7peedcae421bf23bc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:58796 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbYLFAbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 19:31:05 -0500
Received: by wf-out-1314.google.com with SMTP id 27so236024wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 05 Dec 2008 16:31:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I attempted an Overo build this afternoon with
fb3d15c023ff08c879155db630895f38526b95f6.

I set bootargs for rootfs on mmc.  The boot progresses normally and
then hangs waiting for the rootfs to mount.

Where I previously got:

  Waiting for root device /dev/mmcblk0p2...
  mmc0: host does not support reading read-only switch. assuming write-enable.
  mmc0: new SD card at address ee21
  mmcblk0: mmc0:ee21 SU02G 1.89 GiB
   mmcblk0: p1 p2

I now get:

  Waiting for root device /dev/mmcblk0p2...

Has anyone else seen mmc issues with rc7?

Steve
