From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 00/18] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle support
Date: Wed, 03 Apr 2013 15:52:58 -0700
Message-ID: <87hajnp6ph.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34941 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489Ab3DCWxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 18:53:03 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so1144947pab.29
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 15:53:01 -0700 (PDT)
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Here is the refreshed version(v2) of the OMAP5 PM suspport which was posted
> earlier (March 1st 2013). Patch-set incorporates comments from Nishant
> Menon (Thanks for review NM) and his acked-by tags. I would like to get this
> queued for 3.10 merge window if you are ok with the series.

I did a review of this series with several comments on the individual
patches.  

I've already queued most of the CPUidle fixes/cleanups in my
for_3.10/cleanup/cpuidle branch and will get that to Tony soon.  For the
rest, I suggest probably breaking it up into cleanup/consolidation stuff
and then OMAP5 support.  The latter will depend on all the OMAP5
data/headers but the cleanup/consolidation stuff could be merged sooner
(but probably a bit late for v3.10 now.)

Kevin
