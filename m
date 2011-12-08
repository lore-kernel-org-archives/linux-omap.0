From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in
 low-power mode support
Date: Thu, 8 Dec 2011 02:36:31 +0200
Message-ID: <CAMP44s0LGVOWrKu8nTbDWdGJFoUH8kcg_nFQwnxFWHFQDf_5_w@mail.gmail.com>
References: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52380 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab1LHAgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 19:36:31 -0500
Received: by dadv6 with SMTP id v6so1091235dad.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Dec 2011 16:36:31 -0800 (PST)
In-Reply-To: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Tue, Nov 8, 2011 at 8:00 AM, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
> to use timer->func_base OCP_CFG should not use this wrapper anymore.
> Instead use __raw_writel() directly and use timer->io_base instead
> to write to OCP_CFG.
>
> The timer->sys_stat is valid only if timer->revision is 1. In the
> context restore function make this correction.
>
> Save the contexts and loss count when timer is stopped.
> Also, disable the clock. Else, clock usecount would become imbalanced.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

It looks like this patch is doing 3 things, so I think this patch
should be split into 3 logical patches.

-- 
Felipe Contreras
