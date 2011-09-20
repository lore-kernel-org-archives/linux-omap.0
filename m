From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Tue, 20 Sep 2011 17:27:32 +0530
Message-ID: <4E787FAC.5070905@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38417 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752442Ab1ITL5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 07:57:40 -0400
Received: by mail-gy0-f180.google.com with SMTP id 8so967504gyd.39
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 04:57:39 -0700 (PDT)
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com

On Sunday 04 September 2011 07:24 PM, Santosh Shilimkar wrote:
> This series adds OMAP4 MPUSS (MPU SubSystem) power management support for
> suspend (S2R), CPU hotplug and CPUidle.
> 
Thanks all for your review's and testing of this series. Have addressed
all the concerns/comments as part of the next post which  I am holding
for couple of days more.

Reason is mainly to ensure that dependent patches(series) are merged or
on the way for 3.2, and the patches are re-based against the
right tree for the merge.

As documented earlier, there are 3 dependencies for this series.

1) Russell's L2 cache update to generic suspend which seems to be
be ready now since Lorenzo confirmed that pending issue is fixed.
http://www.spinics.net/lists/linux-omap/msg57625.html

2) CPU PM notifier series for which I have pull request ready
to be send.
https://lkml.org/lkml/2011/9/3/49

3) IRQ subystem patch which is already in Thomas's irq/core for 3.2
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg55483.html

Regards
Santosh
