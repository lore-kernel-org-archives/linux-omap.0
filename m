From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clocks: add dummy clock for mailbox
Date: Tue, 21 Dec 2010 21:25:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012212121380.1446@utopia.booyaka.com>
References: <1290108000-16835-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52644 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0LVEZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 23:25:19 -0500
In-Reply-To: <1290108000-16835-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: linux omap <linux-omap@vger.kernel.org>, b-cousson@ti.com, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, 18 Nov 2010, Hari Kanigeri wrote:

> In omap4, there is no explicit configuration register to enable mailbox clocks.
> Defining dummy clock for mailbox clock module to keep the mailbox driver
> backward compatible with previous omaps.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>

Thanks, queued for 2.6.38 as part of the "clk_b_2.6.38" branch on 
git://git.pwsan.com/linux-2.6

This patch appears in the integration tree as part of tag 
'integration-2.6.38-20101221-011' at git://git.pwsan.com/linux-integration


- Paul
