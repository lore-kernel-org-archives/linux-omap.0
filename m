From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 13/18] ARM: OMAP: CPUidle: Unregister drivere on device registration failure
Date: Wed, 03 Apr 2013 14:03:59 -0700
Message-ID: <871uartjgg.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58506 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762313Ab3DCVEC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 17:04:02 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1065850pdc.28
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 14:04:02 -0700 (PDT)
In-Reply-To: <1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> If the CPUidle device registration fails for some reason, we should
> unregister the driver on error path.
>
> Fix the code accordingly. Also when at it, check of the driver registration
> failure too.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Adding to my for_3.10/fixes/cpuidle branch.

Kevin
