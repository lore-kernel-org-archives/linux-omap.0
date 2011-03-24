From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
Date: Thu, 24 Mar 2011 08:27:55 -0700
Message-ID: <87fwqc1qtg.fsf@ti.com>
References: <1299844601-13248-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34875 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756682Ab1CXP2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 11:28:22 -0400
Received: by mail-iy0-f172.google.com with SMTP id 12so98425iyi.17
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 08:28:19 -0700 (PDT)
In-Reply-To: <1299844601-13248-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 11 Mar 2011 17:26:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On OMAP4430 ES1.0, Power Management features are not supported.
> Avoid omap4_pm_init() on ES1.0 silicon so that we can continue
> to use same kernel binary to boot on all OMAP4 silicons.
>
> The ES1.0 boot failure with OMAP4 PM series was because of
> the clockdomain initialisation code. Hardware supervised
> clockdomain mode isn't functional for all clockdomains
> on OMAP4430 ES1.0 silicon so avoid the same.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> Patch applies on top of OMAP4 PM series

This looks OK.

Please include in the repost of your OMAP4 PM series.

Kevin
