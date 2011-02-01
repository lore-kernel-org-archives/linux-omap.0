From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Pandaboard boot problem
Date: Tue, 1 Feb 2011 19:30:25 +0100
Message-ID: <AANLkTikCjuhHJbvK6YL40mYq2Yt99UCob4bHKRqPRToW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58520 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab1BASa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 13:30:26 -0500
Received: by qwa26 with SMTP id 26so6994915qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 10:30:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

I have a problem with a Pandaboard hanging a few seconds after the
kernel boot, likely due to the watchdog firing.
The kernel boots fine, mounts the root FS (initramfs) and the shell
prompt works OK.

Board details: Panda A1, OMAP4430 ES2
Kernel details: l-o tree master, using the omap2plus_defconfig +
initramfs. WDOG is enabled in the config.

>From some investigation I can see that PM runtime disables the wdog
(omap_device_idle). Is that intented?

Any thought?

Thanks,
Jean
