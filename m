From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Fri, 2 Dec 2011 12:20:52 +0200
Message-ID: <CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	<1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
	<1322728943.2332.13.camel@koala>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59069 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab1LBKUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 05:20:53 -0500
Received: by eaak14 with SMTP id k14so2983939eaa.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 02:20:52 -0800 (PST)
In-Reply-To: <1322728943.2332.13.camel@koala>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Jan Weitzel <j.weitzel@phytec.de>, linux-mtd@lists.infradead.org, dedekind@infradead.org, tglx@linutronix.de, computersforpeace@gmail.com, linux-omap@vger.kernel.org

On Thu, Dec 1, 2011 at 10:42 AM, Artem Bityutskiy <dedekind1@gmail.com>=
 wrote:
> On Tue, 2011-11-29 at 10:00 +0100, Jan Weitzel wrote:
>> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
>
> Pushed to l2-mtd-2.6.git, thank you!

This breaks build here, did you really test it, Jan?

drivers/mtd/nand/omap2.c: In function 'omap_nand_probe':
drivers/mtd/nand/omap2.c:1078: error: 'struct omap_nand_platform_data'
has no member named 'options'


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
