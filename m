From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/2] gpio/omap: updates for v3.10
Date: Fri, 01 Mar 2013 09:39:30 -0800
Message-ID: <874ngv2f59.fsf@linaro.org>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64887 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab3CARje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 12:39:34 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so1943892pab.29
        for <linux-omap@vger.kernel.org>; Fri, 01 Mar 2013 09:39:33 -0800 (PST)
In-Reply-To: <1362158568-1624-1-git-send-email-jon-hunter@ti.com> (Jon
	Hunter's message of "Fri, 1 Mar 2013 11:22:46 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

> Summary of updates:
> - Convert OMAP GPIO driver to use linear mapping for IRQ domains
> - Avoid crashes seen if a gpio bank is not enabled when requesting an IRQ.

Acked-by: Kevin Hilman <khilman@linaro.org>
