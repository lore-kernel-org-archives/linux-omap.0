From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: dmtimer: remove redundant sysconfig context restore
Date: Thu, 12 Apr 2012 07:23:33 -0700
Message-ID: <87wr5lhvve.fsf@ti.com>
References: <1334223827-28812-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51203 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754959Ab2DLOXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 10:23:36 -0400
Received: by pbcxa12 with SMTP id xa12so2239349pbc.9
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 07:23:35 -0700 (PDT)
In-Reply-To: <1334223827-28812-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 12 Apr 2012 15:13:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Since hwmod framework now manages sysconfig context save/restore
> there is no more need to touch this register in driver. Hence,
> remove restore of sysconfig register in omap_timer_restore_context.
> This was causing incorrect context restore of sysconfig register.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> v2: removed tiocp_cfg from struct timer_regs {}

Acked-by: Kevin Hilman <khilman@ti.com>
