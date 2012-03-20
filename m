From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 1/2] arm: omap3: pm34xx.c: Fix omap3_pm_init() error out paths
Date: Tue, 20 Mar 2012 07:02:40 -0700
Message-ID: <87sjh32wvz.fsf@ti.com>
References: <1332033768-21986-1-git-send-email-mgreer@animalcreek.com>
	<1332033768-21986-2-git-send-email-mgreer@animalcreek.com>
	<1332150525.2116.334.camel@sokoban>
	<alpine.DEB.2.00.1203200316300.22974@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60738 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759083Ab2CTOCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 10:02:42 -0400
Received: by mail-pb0-f43.google.com with SMTP id wz12so126662pbc.30
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 07:02:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203200316300.22974@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 20 Mar 2012 03:17:16 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> + Kevin
>
> On Mon, 19 Mar 2012, Tero Kristo wrote:
>
>> On Sat, 2012-03-17 at 18:22 -0700, Mark A. Greer wrote:
>> > From: "Mark A. Greer" <mgreer@animalcreek.com>
>> > 
>> > It appears that the error paths were overlooked when the
>> > omap3_pm_init() routine had the prcm chain handler code
>> > added.  Fix this by adding a goto target and reordering
>> > the error handling code.  Also fix how the irq argument
>> > for free_irq() is determined.
>> 
>> You are right, it looks like the error handling part was accidentally
>> dropped from version 7 of the prcm patch set.
>> 
>> Acked-by: Tero Kristo <t-kristo@ti.com>
>> 
>> Paul, you going to grab this?
>
> Kevin is the pm34xx.c maintainer, so unless he wants me to queue it, it's 
> probably best for him to take it.

Yeah, I've already queued these for v3.4.  (branch: for_3.4/fixes/pm)

Kevin
