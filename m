From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm:omap:serial:cleanup: use module rev instead of cpu_is_xxxx
Date: Mon, 07 Nov 2011 11:44:40 -0800
Message-ID: <87k47bsonr.fsf@ti.com>
References: <1320677860-32663-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:37283 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895Ab1KGTon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 14:44:43 -0500
Received: by mail-qy0-f181.google.com with SMTP id 2so3897159qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 11:44:43 -0800 (PST)
In-Reply-To: <1320677860-32663-1-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Mon, 7 Nov 2011 20:27:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> For OMAP3 uarts (module rev >= 0x52) and all successor devices
> (omap4, TI81xx, AM33xx, etc...) empty fifo read errata is applicable,
> so we can get rid of cpu_is_xxxx check and simply check for module rev here.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> NOTE: This patch has been tested on OMAP3EVM, and I expect to work on all OMAP3
> family of devices (including TI816x, TI814x, AM335x, etc...).
> but I am quite not sure about OMAP2 device, can anybody comment/test?

Leaving OMAP2 as it is should be fine.

There is a major UART cleanup in progress from Govindraj.  I suggest you
rework this patch on top of his series from 10/18:

       [PATCH v7 00/21] OMAP2+: UART: Runtime adaptation + cleanup

although it still has a few changes to go through before being ready to
merge.

Kevin
