From: Shreyas Mahajan <mahajan.shreyas@gmail.com>
Subject: Omap3430 does not resume after suspend
Date: Fri, 30 Jan 2009 14:54:26 +0530
Message-ID: <d105d8d00901300124i60025abete9f0b0e86d676f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:54036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZA3JYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 04:24:32 -0500
Received: by fg-out-1718.google.com with SMTP id 13so269665fge.17
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 01:24:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
         I am a newbie with omap3430. As a part of my project, I
suspended my board with 'echo mem > /sys/power/state'.The suspend
happens correctly, without giving any failure message. But, when I
tried it to resume, it is not resuming.I tried to find some reasons
for this, and got the patches for unmasking keyboard interrupt while
suspending. But, all patches are for omap2 and omap1 board
architecture. Are there any patches to do this thing in omap3430?

Thanks,
