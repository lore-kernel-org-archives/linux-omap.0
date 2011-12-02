From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mdt nand: omap2+ use platform options
Date: Fri, 2 Dec 2011 09:28:30 -0800
Message-ID: <CAN8TOE-YkQvm76ZXxh-CBF05y6BoHY+FM95-TtJdAiP0knhZtg@mail.gmail.com>
References: <CAN8TOE9=ux=suwcQMwJY1XUhp_mnD_DL613ffF1-HTL1OVB2PQ@mail.gmail.com>
	<1322557213-23565-1-git-send-email-j.weitzel@phytec.de>
	<1322728943.2332.13.camel@koala>
	<CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56654 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197Ab1LBR2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 12:28:31 -0500
Received: by wgbdr13 with SMTP id dr13so1557975wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 09:28:30 -0800 (PST)
In-Reply-To: <CANOLnOOE3a0BP0TcLnRAmq5YAiHLZTpkbriDh9WtkkBT7TotFA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: dedekind1@gmail.com, Jan Weitzel <j.weitzel@phytec.de>, linux-mtd@lists.infradead.org, dedekind@infradead.org, tglx@linutronix.de, linux-omap@vger.kernel.org

On Fri, Dec 2, 2011 at 2:20 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Thu, Dec 1, 2011 at 10:42 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>> On Tue, 2011-11-29 at 10:00 +0100, Jan Weitzel wrote:
>>> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
>>
>> Pushed to l2-mtd-2.6.git, thank you!
>
> This breaks build here, did you really test it, Jan?
>
> drivers/mtd/nand/omap2.c: In function 'omap_nand_probe':
> drivers/mtd/nand/omap2.c:1078: error: 'struct omap_nand_platform_data'
> has no member named 'options'

This is exactly what I was asking already. I don't see 'options' in
'struct omap_nand_platform_data' in
'arch/arm/plat-omap/include/plat/nand.h', even in linux-next.

Brian
