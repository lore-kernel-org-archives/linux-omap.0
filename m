From: "arun c" <arunedarath@mistralsolutions.com>
Subject: VRFB based rotation for omapfb
Date: Tue, 25 Mar 2008 14:23:14 +0530
Message-ID: <c656a4d20803250153x344a8706j9fbba527576044e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:12965 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYCYIxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 04:53:15 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1662263rnb.15
        for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2008 01:53:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I am trying to implement vrfb based rotation for the git omapfb
driver.

It requires change of fb_fix_screeninfo ( Physical address of fb and
such things)
and fb_info (virtual address of buffer) because different rotation
angles require
different physical addresses for VRFB based rotation. Moreover this changes
has to be done dynamically.

In the current implementation it assumes the framebuffer position (address) is
not changed and passes the control to DSS (dispc.c) to rotate the framebuffer.
This will work nicely for controllers (eg blizzard) which changes some register
bits for rotation.

Can anybody suggest me some hints how to implement this dynamic changes??

Currently i am planning to do all vrfb initialization stuff in omap_dispc_init.
But i am getting confused how to manage the changes for fb_fix_screeninfo
dynamically for different angles, even though the ultimate aim is to program
the DMA and SMS.

Regards,
Arun c
