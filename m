From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 REPOST 00/24] gpio/omap: driver cleanup and fixes
Date: Tue, 27 Sep 2011 07:27:19 -0700
Message-ID: <87vcse3vso.fsf@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41196 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742Ab1I0O1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:27:25 -0400
Received: by mail-iy0-f173.google.com with SMTP id f6so6858956iag.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:27:23 -0700 (PDT)
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 27 Sep 2011 05:43:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*
>
> Baseline: git://gitorious.org/khilman/linux-omap-pm.git
> Branch: for_3.2/gpio-cleanup
> Commit: 8323374

Is this functionally different than the branch you posted yesterday?

I replied to that saying it does not fix the PER retention problems on
n900, and giving a suggestion of how to test it.

Kevin
