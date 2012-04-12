From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP2+: dmtimer: remove redundant sysconfig context
 restore
Date: Thu, 12 Apr 2012 15:39:47 +0530
Message-ID: <4F86A9EB.9020708@ti.com>
References: <1334223827-28812-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:52945 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753178Ab2DLKKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 06:10:03 -0400
Received: by obbef5 with SMTP id ef5so2636750obb.38
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 03:10:01 -0700 (PDT)
In-Reply-To: <1334223827-28812-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com

On Thursday 12 April 2012 03:13 PM, Tarun Kanti DebBarma wrote:
> Since hwmod framework now manages sysconfig context save/restore
> there is no more need to touch this register in driver. Hence,
> remove restore of sysconfig register in omap_timer_restore_context.
> This was causing incorrect context restore of sysconfig register.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> v2: removed tiocp_cfg from struct timer_regs {}
> 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
