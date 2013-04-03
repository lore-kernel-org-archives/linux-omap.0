From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 12/18] ARM: OMAP4: CPUidle: Avoid double idle driver registration
Date: Wed, 03 Apr 2013 14:03:10 -0700
Message-ID: <877gkjtjht.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50919 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760401Ab3DCVDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 17:03:14 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so831227pdj.34
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 14:03:13 -0700 (PDT)
In-Reply-To: <1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:35:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> OMAP4 CPUidle driver registration call is under a loop which leads
> to calling cpuidle_register_driver twice which is not intended.
>
> Fix it by moving the driver registration outside the loop.
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Looks good.

I've already got a for_3.10/fixes/cpuidle branch going, so I'll apply
this one there.

Kevin
