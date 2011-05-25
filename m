From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 08/15] OMAP2+: GPIO: make workaround_enabled bank specific
Date: Wed, 25 May 2011 15:39:03 -0700
Message-ID: <874o4ipfqw.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51093 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754631Ab1EYWjH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 18:39:07 -0400
Received: by mail-pw0-f50.google.com with SMTP id 3so95850pwi.37
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 15:39:06 -0700 (PDT)
In-Reply-To: <1306247094-25372-9-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Make workaround_enabled flag bank-specific instead of using a single
> flag for all the banks together. This would be helpful while making
> use of runtime framework in OMAP GPIO driver which would make the
> driver handle each GPIO bank independently.
>
> Also rename workaround_enabled flag to off_mode_wkup_wa_enabled

Do we even need a dedicated flag for this?

I seems that the combination of enabled_non_wakeup_gpios and whether or
not context has been lost could be used to check this condition.

Kevin
