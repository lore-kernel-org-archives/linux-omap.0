From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Thu, 01 Dec 2011 09:21:11 +0100
Message-ID: <1322727671.4543.28.camel@lws-weitzel>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	 <1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
	 <CAN8TOE-uO2rzPt64ubwzTkh6Wz2wBnH88d3RdsGdJJSpCHsdeg@mail.gmail.com>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:59748 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab1LAIVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 03:21:13 -0500
In-Reply-To: <CAN8TOE-uO2rzPt64ubwzTkh6Wz2wBnH88d3RdsGdJJSpCHsdeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, tglx@linutronix.de, dedekind@infradead.org, linux-omap@vger.kernel.org

Am Mittwoch, den 30.11.2011, 12:31 -0800 schrieb Brian Norris:
> On Tue, Nov 29, 2011 at 1:00 AM, Jan Weitzel <j.weitzel@phytec.de> wrote:
> > Options from struct omap_nand_platform_data are not used.
> > Apply options after nand_scan_ident to avoid overwrite due to
> > NAND_CHIPOPTIONS_MSK.
> > So you can pass options from platformcode
> 
> Just to clarify, were the pdata->options ever used before? And does
> struct omap_nand_platform_data even have such a field?

No not used, but field exists. There is also a devsize field which is
used to provide NAND_BUSWIDTH_16 to info->nand.options
(drivers/mtd/nand/omap2.c)
Jan

> Brian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


