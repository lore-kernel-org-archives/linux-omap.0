From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 4/4] TEMP: OMAP3: beagle rev-c4: enable OPP6
Date: Fri, 05 Aug 2011 12:41:37 -0700
Message-ID: <87liv7sl1q.fsf@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
	<1311853739-18984-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36188 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752460Ab1HETlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 15:41:40 -0400
Received: by mail-iy0-f174.google.com with SMTP id 40so4292046iyf.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 12:41:39 -0700 (PDT)
In-Reply-To: <1311853739-18984-5-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 28 Jul 2011 14:48:59 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Beagleboard rev-c4 has a speed sorted OMAP3530 chip which can run at 720MHz.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

FYI... this needs an update similar to the patch I just posted for
v3.1-rc so it's not directly using omap_device:

  https://patchwork.kernel.org/patch/1036202/

Kevin
