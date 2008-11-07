From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: Problems with jffs2 rootfs using 2.6.28-rc3
Date: Fri, 7 Nov 2008 14:20:40 -0800
Message-ID: <5e088bd90811071420l2c29a74fi32bd0ddd3d73cb93@mail.gmail.com>
References: <5e088bd90811071209w6fb1b6c0y689d589819104862@mail.gmail.com>
	 <200811071246.17303.david-b@pacbell.net>
	 <5e088bd90811071321v5bc2b4adm2b89eebf1f3f906c@mail.gmail.com>
	 <200811071330.44168.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:18515 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYKGWUm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 17:20:42 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1350159ugf.37
        for <linux-omap@vger.kernel.org>; Fri, 07 Nov 2008 14:20:40 -0800 (PST)
In-Reply-To: <200811071330.44168.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Fri, Nov 7, 2008 at 1:30 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 07 November 2008, Steve Sakoman wrote:
>> On Fri, Nov 7, 2008 at 12:46 PM, David Brownell <david-b@pacbell.net> wrote:
>> > On Friday 07 November 2008, Steve Sakoman wrote:
>> >> I'm having little success.  It used to work back in 2.6.26 timeframe
>> >> but seems to have broken sometime during 2.6.27.
>> >
>> > There's a patch floating around making the omap2 NAND driver
>> > use readsw not readsl, which might explain that problem...
>>
>> Do you recall where you saw that patch?  Here or linux-mtd?  My
>> initial search efforts weren't successful.
>
> On linux-omap.  Or just look at the driver to see the
> readsl()... it's a one-liner.

Yes, that one line change did indeed fix the issue!

Is that patch currently in the queue somewhere?

For the record:

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 2ede116..d18a8c9 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -196,7 +196,7 @@ static void omap_read_buf16(struct mtd_info *mtd,
u_char *buf, int len)
 {
 	struct nand_chip *nand = mtd->priv;

-	__raw_readsl(nand->IO_ADDR_R, buf, len / 2);
+	readsw(nand->IO_ADDR_R, buf, len / 2);
 }

 /*
