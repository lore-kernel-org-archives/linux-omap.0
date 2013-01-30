From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 1/1] drivers: net: davinci_cpdma: acknowledge interrupt properly
Date: Wed, 30 Jan 2013 21:03:27 +0100
Message-ID: <EF466712-C5FF-4A91-BDF3-477559B02705@dominion.thruhere.net>
References: <1359575813-15703-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:57197 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab3A3UD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 15:03:28 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so1093275eek.28
        for <linux-omap@vger.kernel.org>; Wed, 30 Jan 2013 12:03:27 -0800 (PST)
In-Reply-To: <1359575813-15703-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, panto@antoniou-consulting.com


Op 30 jan. 2013, om 20:56 heeft Mugunthan V N <mugunthanvnm@ti.com> het volgende geschreven:

> CPDMA interrupts are not properly acknowledged which leads to interrupt
> storm, only cpdma interrupt 0 is acknowledged in Davinci CPDMA driver.
> Changed cpdma_ctlr_eoi api to acknowledge 1 and 2 interrupts which are
> used for rx and tx respectively.

A brief inspection shows that this still isn't following the TRM, but Pantelis' patch does. Can you please fix this driver to follow the TRM and make it work on both PG1.0 and PG2.0 instead of papering over bugs instead of fixing them properly?


