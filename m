From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap: rm-680: fix the panic during boot
Date: Thu, 8 Dec 2011 12:43:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112081243100.6289@utopia.booyaka.com>
References: <1322850650-13171-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47470 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1LHTng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:43:36 -0500
In-Reply-To: <1322850650-13171-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2 Dec 2011, Aaro Koskinen wrote:

> Booting the Linux kernel on Nokia RM-680 board has been broken since
> 2.6.39 due to the following:
> 
> [    0.217193] omap_hwmod: timer12: enabling
> [    0.221435] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa304010

...

> Timer 12 is not necessarily available on non-GP devices (see e.g.
> http://marc.info/?l=linux-omap&m=129433066521102&w=2), so it should be
> registered only on GP OMAPs. With this change it's again possible to
> boot RM-680 into the shell. Tested with 3.2-rc4.

Thanks, tweaked the subject line a little and queued for 3.2-rc.


- Paul
