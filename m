From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Thu, 03 Jun 2010 11:46:13 -0700
Message-ID: <87wrugq7ii.fsf@deeprootsystems.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:34701 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab0FCSqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 14:46:17 -0400
Received: by pzk15 with SMTP id 15so315526pzk.15
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 11:46:16 -0700 (PDT)
In-Reply-To: <1274194260-16401-1-git-send-email-charu@ti.com> (Charulatha V.'s message of "Tue\, 18 May 2010 20\:20\:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> This patch series implements GPIO module in platform device model.
> It also makes OMAP2PLUS specific GPIO implemented in HWMOD FW way.
>
> This patch series is created on "origin/pm-wip/runtime".
>
> This patch series is tested on OMAP3430 SDP board. It would be of
> great help if someone could test the same on OMAP1 and OMAP2 boards.

Hi Charu,

This series is looking really good.  Thanks!

Can you rebase it onto current pm-wip/runtime branch which has been
updated to v2.6.35?  There were a handful of GPIO changes that went
upstream for 2.6.35 that make it so your series no longer applies.
Yes, this is partially my fault for taking so long to review your
series.  Sorry.

Also note that current pm-wip/runtime is based on my pm-fixes branch
which also includes this GPIO fix against 2.6.35:

   https://patchwork.kernel.org/patch/103831/

Kevin
