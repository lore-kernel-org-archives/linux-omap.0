From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Thu, 01 Dec 2011 10:42:22 +0200
Message-ID: <1322728943.2332.13.camel@koala>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	 <1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42503 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047Ab1LAIm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 03:42:26 -0500
Received: by lagw12 with SMTP id w12so470780lag.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 00:42:24 -0800 (PST)
In-Reply-To: <1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-mtd@lists.infradead.org, dedekind@infradead.org, tglx@linutronix.de, computersforpeace@gmail.com, linux-omap@vger.kernel.org

On Tue, 2011-11-29 at 10:00 +0100, Jan Weitzel wrote:
> Options from struct omap_nand_platform_data are not used.
> Apply options after nand_scan_ident to avoid overwrite due to
> NAND_CHIPOPTIONS_MSK.
> So you can pass options from platformcode
> 
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>

Pushed to l2-mtd-2.6.git, thank you!

