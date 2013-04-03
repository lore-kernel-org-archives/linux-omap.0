From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 14/18] ARM: OMAP4: CPUidle: Make C-state description field more precise
Date: Wed, 03 Apr 2013 14:05:52 -0700
Message-ID: <87vc83s4sv.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:37924 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759074Ab3DCVF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 17:05:56 -0400
Received: by mail-da0-f41.google.com with SMTP id w4so832006dam.0
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 14:05:55 -0700 (PDT)
In-Reply-To: <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> It is useful to know the CPU power state along with MPUSS power state
> in a supported C-state. Since the data is available via sysfs, one can
> avoid scrolling the source code for precise construction of C-state.
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Nice.

Adding to for_3.10/fixes/cpuidle branch.

Kevin
