From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: Interesting L3 driver panic on v3.2-rc5 on 3530
Date: Tue, 20 Dec 2011 00:39:25 +0000 (UTC)
Message-ID: <loom.20111220T013434-130@post.gmane.org>
References: <alpine.DEB.2.00.1112161859190.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34520 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab1LTAkI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 19:40:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RcnkS-0006Lh-ME
	for linux-omap@vger.kernel.org; Tue, 20 Dec 2011 01:40:06 +0100
Received: from ppp92-100-93-175.pppoe.avangarddsl.ru ([92.100.93.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 01:40:04 +0100
Received: from yanok by ppp92-100-93-175.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 01:40:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Paul,

Paul Walmsley <paul <at> pwsan.com> writes:
> [    0.238494] Kernel BUG at c0033e34 [verbose debug info unavailable]
> [    0.245025] Internal error: Oops - undefined instruction: 0 [#1] SMP
> [    0.262390] PC is at omap3_l3_app_irq+0x108/0x12c

I'm getting the same error on one of my AM3517 boards.
L3_SI_FLAG_STATUS_0 register has bit 15 set that means Display SS IA burst
timeout according to the RM.

Regards, Ilya.


