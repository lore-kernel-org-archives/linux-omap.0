From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Wed, 30 Nov 2011 12:31:13 -0800
Message-ID: <CAN8TOE-uO2rzPt64ubwzTkh6Wz2wBnH88d3RdsGdJJSpCHsdeg@mail.gmail.com>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	<1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49367 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab1K3UbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Nov 2011 15:31:15 -0500
Received: by faaq16 with SMTP id q16so916967faa.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 12:31:14 -0800 (PST)
In-Reply-To: <1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-mtd@lists.infradead.org, tglx@linutronix.de, dedekind@infradead.org, linux-omap@vger.kernel.org

On Tue, Nov 29, 2011 at 1:00 AM, Jan Weitzel <j.weitzel@phytec.de> wrote:
> Options from struct omap_nand_platform_data are not used.
> Apply options after nand_scan_ident to avoid overwrite due to
> NAND_CHIPOPTIONS_MSK.
> So you can pass options from platformcode

Just to clarify, were the pdata->options ever used before? And does
struct omap_nand_platform_data even have such a field?

Brian
