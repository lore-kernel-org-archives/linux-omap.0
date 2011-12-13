From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv11 0/8] OMAP3+: PRCM chain handler
Date: Mon, 12 Dec 2011 16:33:56 -0800
Message-ID: <87ty55z4wb.fsf@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:32853 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753472Ab1LMAd7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 19:33:59 -0500
Received: by mail-iy0-f170.google.com with SMTP id j26so4677516iaf.29
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 16:33:58 -0800 (PST)
In-Reply-To: <1323713733-13115-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 12 Dec 2011 20:15:25 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:


> PRCM chain handler is adding a support to the omap3+ kernel that
> allows different drivers to use PRCM interrupt events for their
> own purposes, typically this means IO wakeups. This work was
> attempted to integrate as its own driver at some point of
> the evolution of this set, however this was now postponed as
> the lacking support is basically blocking a few drivers.
>
> This is the version 11 of this set, now posted to linux-arm-kernel also
> as cc. Contains just a couple of minor changes compared to previous
> version proposed by Kevin Hilman.

Thanks Tero for the quick update.  

All of this series can go through Paul, so from my side

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
