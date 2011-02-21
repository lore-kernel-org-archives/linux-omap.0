From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operation can
 cause data corruption
Date: Mon, 21 Feb 2011 09:46:22 +0000
Message-ID: <AANLkTi=75FCNufKQsJTqREbsNhmwP-QrU7uUUtBr_i8-@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54644 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab1BUJqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 04:46:23 -0500
Received: by iyb26 with SMTP id 26so531037iyb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 01:46:22 -0800 (PST)
In-Reply-To: <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux-omap@vger.kernel.org

On 18 February 2011 12:35, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> operation (offset 0x7FC). This operation runs in background so that
> PL310 can handle normal accesses while it is in progress. Under very
> rare circumstances, due to this erratum, write data can be lost when
> PL310 treats a cacheable write transaction during a Clean & Invalidate
> by Way operation.
>
> Workaround:
> Disable Write-Back and Cache Linefill (Debug Control Register)
> Clean & Invalidate by Way (0x7FC)
> Re-enable Write-Back and Cache Linefill (Debug Control Register)
>
> This patch also removes any OMAP dependency on PL310 Errata's
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
