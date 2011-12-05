From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Mon, 05 Dec 2011 09:11:17 +0100
Message-ID: <1323072677.12068.5.camel@lws-weitzel>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	 <1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
	 <1322728943.2332.13.camel@koala>
	 <CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phycard.co.uk ([217.6.246.34]:50482 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab1LEILU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Dec 2011 03:11:20 -0500
In-Reply-To: <CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: dedekind1@gmail.com, linux-mtd@lists.infradead.org, dedekind@infradead.org, tglx@linutronix.de, computersforpeace@gmail.com, linux-omap@vger.kernel.org

Am Freitag, den 02.12.2011, 12:20 +0200 schrieb Grazvydas Ignotas:
> On Thu, Dec 1, 2011 at 10:42 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > On Tue, 2011-11-29 at 10:00 +0100, Jan Weitzel wrote:
> >> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> >
> > Pushed to l2-mtd-2.6.git, thank you!
> 
> This breaks build here, did you really test it, Jan?
Sorry, I wasn't carefully enough. I missed 7a559c78 where you removed
options from struct omap_nand_platform_data. Did you think getting we
should reintroduce it? I am looking for a good way to get
NAND_NO_SUBPAGE_WRITE from boardfile to driver.
Jan
> drivers/mtd/nand/omap2.c: In function 'omap_nand_probe':
> drivers/mtd/nand/omap2.c:1078: error: 'struct omap_nand_platform_data'
> has no member named 'options'
> 
> 


