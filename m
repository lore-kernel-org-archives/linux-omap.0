From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP:GPIO:hwmod: Fix mmc compile errors
Date: Wed, 28 Apr 2010 16:19:33 -0700
Message-ID: <87eihz9ncq.fsf@deeprootsystems.com>
References: <1271951694-18556-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55295 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0D1XTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 19:19:39 -0400
Received: by pvg2 with SMTP id 2so575241pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 16:19:38 -0700 (PDT)
In-Reply-To: <1271951694-18556-1-git-send-email-charu@ti.com> (Charulatha V.'s message of "Thu\, 22 Apr 2010 21\:24\:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> In origin/pm-wip/runtime branch, compilation errors are
> observed for OMAP2430. The compilation errors are due to
> usage of clkdev_dev_id, clkdev_con_id and sysconfig fields
> in mmc hwmod structures. This patch fixes the same.
>
> Signed-off-by: Charulatha V <charu@ti.com>

Thanks, folded into MMC hwmods patch in pm-wip/hwmods branch.

Kevin
