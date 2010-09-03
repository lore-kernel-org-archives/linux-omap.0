From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 00/11] OMAP: DMA: HWMOD and DMA as platform driver
Date: Fri, 03 Sep 2010 13:38:37 -0700
Message-ID: <87eidawoj6.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57792 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757413Ab0ICUik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 16:38:40 -0400
Received: by pwi3 with SMTP id 3so348089pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 13:38:40 -0700 (PDT)
In-Reply-To: <1282647866-6918-1-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Tue, 24 Aug 2010 16:34:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> This patch series has review comments incorporated which are received
> for v1 version.
> The review comments can be found at:
> http://www.spinics.net/lists/linux-omap/msg34291.html
> http://www.spinics.net/lists/linux-omap/msg34292.html
> http://www.spinics.net/lists/linux-omap/msg34078.html
> http://www.spinics.net/lists/linux-omap/msg34083.html
>
> These changes are tested on following boards:
> - Zoom3     (OMAP3630)
> - Beagle    (OMAP3530)
> - OMAP4 SDP (OMAP4430)
> I don't have omap1 and omap2 boards and appreciate if 
> some one can test these boards and provides feedback.
>
> Build tested for both omap1 and omap2 plus boards.

Your team now has OMAP2 hardware, please test on OMAP2 as well as you're
making significant changes that affect code in OMAP2, 3 and 4.

Kevin
