From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: TSC2046 Touchscreen Driver Lost?
Date: Sun, 6 Dec 2009 19:30:46 -0800
Message-ID: <6cb013310912061930l299ec57frb01261833634543a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59159 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073AbZLGDa7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Dec 2009 22:30:59 -0500
Received: by pwj9 with SMTP id 9so659524pwj.21
        for <linux-omap@vger.kernel.org>; Sun, 06 Dec 2009 19:31:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

In May of 2007, a touchscreen driver for the TSC2046 was posted to the
linux-omap mailing list (before it was hosted on vger):

http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/009745.html

Looking through git history, this driver seems to have been lost...Can
anyone shed some light on where it might be?

Reason I ask is that I'll be looking at some point soon to resubmit
it, as we're using this driver in the Linwizard and Wing Linux
projects for omap850 based devices.  It provides 16-bit commands,
instead of the 8-bit commands used by the ads7684 driver, and also
seems to behave a bit differently.  But, if it was already submitted
once and rejected, i'd like to know why before I submit mine.

Thanks
Cory
