From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/18] GPIO: OMAP: Driver Cleanup and Fixes
Date: Thu, 16 Jun 2011 09:15:57 -0700
Message-ID: <87ei2trbuq.fsf@ti.com>
References: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41524 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755640Ab1FPQQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 12:16:05 -0400
Received: by mail-pv0-f169.google.com with SMTP id 12so1485498pvc.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 09:16:00 -0700 (PDT)
In-Reply-To: <1308058321-12875-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 14 Jun 2011 19:01:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.

A quick test of this series on 3430/n900 shows that it prevents PER
retention.  I see CM_FCLKEN_PER=0000c000 (debounce clock for GPIO banks
3 & 4 are still enabled.)

Can you retest with debounce enabled on one of the GPIOs for one of your platforms?

Kevin



