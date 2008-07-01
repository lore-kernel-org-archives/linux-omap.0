From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH 0 /1] Backlight control for omap3evm
Date: Tue, 1 Jul 2008 17:49:45 +0530
Message-ID: <c656a4d20807010519q6f3e20a5o5b482421f3667612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:12523 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbYGAMTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 08:19:46 -0400
Received: by py-out-1112.google.com with SMTP id p76so532572pyb.10
        for <linux-omap@vger.kernel.org>; Tue, 01 Jul 2008 05:19:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all ,

The following patch adds backlight control for omap3evm
User can vary the backlight from 0% to 100% through sysfs.

To test execute.

         a) # echo 0 > /sys/devices/platform/omapfb/panel/backlight_level
              This will turn off the backlight
         b) # echo 100 > /sys/devices/platform/omapfb/panel/backlight_level
              This will give maximum brightness

Regards,
Arun C
