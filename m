From: Ran Shalit <ranshalit@gmail.com>
Subject: ideas about idle loop and power management
Date: Tue, 23 Sep 2014 22:23:26 +0300
Message-ID: <CAJ2oMhKRSo76NEppiR6oqJXeuwrN=Um2azKCNGgP3PbuH_T3PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62132 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbaIWTX2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2014 15:23:28 -0400
Received: by mail-wg0-f50.google.com with SMTP id l18so4039042wgh.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2014 12:23:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I have a system which is required to have 2 modes operation:
1. idle - in which devices in Soc and on board should be off.
2. active mode

Moving from idle to active on interrupt, and moving from active to
idle when there is inactivity.
After reading and re-reading about PM various mechanism, I got to
conculsion that the best and easiest way to achive this on omap
(omap3530) will be as following:
1. use cpuidle
2. find the exact place in cpuidle mechanism where we enter idle loop,
and where we exit idle loop.
3. on entering idle loop: turn off various devices on board, and
devices power domain
4. on exit idle loop: power again the devices.

I think that working such way on low machine registers will be easiest
and best instead of trying to do it using PM mechanism, which is quite
difficult to understand and do and also, I'm not sure even possible
using the existing mechanism.

I would appreciate your feedback.

Regards,
Ran
