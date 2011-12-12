From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] ARM: remove header files included more than once
Date: Mon, 12 Dec 2011 14:25:53 -0600
Message-ID: <CAB-zwWg=7x2qLq52JC8LRzEu7HuzCHgqFZCB4ZBuVxAs_O0VWg@mail.gmail.com>
References: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
	<CAN1soZyaDO1dFTuG-5AgNGEHua6pi_W7VQ24yxyV1+dadK-vdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34205 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203Ab1LLUZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 15:25:54 -0500
Received: by mail-ww0-f49.google.com with SMTP id dt11so10898127wgb.6
        for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 12:25:53 -0800 (PST)
In-Reply-To: <CAN1soZyaDO1dFTuG-5AgNGEHua6pi_W7VQ24yxyV1+dadK-vdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Daniel Walker <dwalker@fifo99.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Silverstone <dsilvers@simtec.co.uk>, Lei Wen <leiwen@marvell.com>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pwsan.com>, Eric Miao <eric.y.miao@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Scott Branden <sbranden@broadcom.com>, Stephen Boyd <sboyd@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>, Jiandong Zheng <jdzheng@broadcom.com>, Krzysztof Halasa <khc@pm.waw.pl>

Hi Haojian,

On Sun, Dec 11, 2011 at 7:10 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
...
> Hi Omar,
>
> Thanks for your patch. Could you help to split your patches into small
> pieces? Since different people are handling for different files. For
> example, I can help to handle files in arch-pxa. But I can't handle
> other files.

No problem, I'll split the patch to be included by independent trees.

Thanks,

Omar
