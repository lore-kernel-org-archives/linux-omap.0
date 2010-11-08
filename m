From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
Date: Mon, 8 Nov 2010 17:48:42 -0600
Message-ID: <AANLkTi=JhdGqB-mXnvjT_Y4cCOu2i8bwfQyy=FAC1Chh@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-4-git-send-email-omar.ramirez@ti.com>
	<4CD5BEFF.40301@ti.com>
	<AANLkTim=5bgGo1cnkWJCPF4HmMnQrBhP_sPCK3rRKUPS@mail.gmail.com>
	<4CD885DD.7020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:59568 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751557Ab0KHXsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 18:48:45 -0500
Received: by mail-gy0-f182.google.com with SMTP id 6so4840882gya.41
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 15:48:43 -0800 (PST)
In-Reply-To: <4CD885DD.7020909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 8, 2010 at 5:21 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> I wrote this one from scratch, I didn't see that there were pieces to
>> handle some stuff since the code is buried in a private tree.
>
> Not true at all... It was sent to l-o:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32854.html

I did review v3 of this patch set, care to point the exact place for
mmu hwmod on this patch set. It seems [v2 5/7] had mailbox, but I
don't think v3 made it to the list.

> And stored in a supposedly private tree, which appears to be public:
> http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=summary

I took whatever was in:

http://dev.omapzoom.org/?p=integration/kernel-omap4.git;a=shortlog;h=refs/heads/L24.11

> Please do not do any change on that code base, just use the original code
> and update it if needed.

Will do, as taken from the tree you mention.

Regards,

Omar
