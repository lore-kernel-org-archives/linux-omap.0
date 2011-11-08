From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via hwmod mux
Date: Mon, 07 Nov 2011 16:58:10 -0800
Message-ID: <87pqh3qvkt.fsf@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:34020 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722Ab1KHA6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 19:58:14 -0500
Received: by mail-yw0-f45.google.com with SMTP id 3so6805065ywb.32
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 16:58:13 -0800 (PST)
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 7 Oct 2011 23:17:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Vishwa,

Vishwanath BS <vishwanath.bs@ti.com> writes:

> The folowing patch series provides IO Daisychain feature via omap hwmod mux
> framework.

The series looks OK at first glance, but needs a refresh against current
mainline.

Can you refresh this against Tony's 'fixes' branch and re-test.

I tested this on OMAP3430/n900 and noticed that it no longer hit off
mode from idle.  

IOW, If I enable UART timeouts and then enable off mode, I don't
actually ever hit off during idle.  However, if I do a suspend/resume I
see it hits off mode, then subsequent attempts to hit off during idle work.

Can you investigate this?

Kevin
