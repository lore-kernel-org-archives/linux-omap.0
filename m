From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 0/7] ARM: OMAP3PLUS PM: Add IO DaisyChain support via hwmod mux
Date: Tue, 10 Jan 2012 09:26:10 -0800
Message-ID: <878vlftqod.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37365 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755695Ab2AJR0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:26:14 -0500
Received: by mail-yx0-f172.google.com with SMTP id l8so1919676yen.31
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:26:13 -0800 (PST)
In-Reply-To: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> The following patch series provides IO Daisychain feature via omap hwmod mux framework.
> The patch series has been generated against Tero's V11 irq chaining series [1].

Tero's series has now been reworked a bit by Paul for merging in v3.3.

Can you rebase and retest this against Tony's 'uart' branch which now
includes the reworked PRCM handler as well as the UART runtime PM series
that is queued for v3.3.

Thanks,

Kevin
