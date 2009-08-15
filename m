From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH 8/9] OMAP2: add board file for Nokia N800 and N810
Date: Sat, 15 Aug 2009 10:38:30 +0300
Message-ID: <87ocqhzfux.fsf@litku.valot.fi>
References: <20090811094348.32577.81307.stgit@localhost>
	<20090811095558.32577.26177.stgit@localhost>
	<20090813091510.GK6132@n2100.arm.linux.org.uk>
	<87vdkrhr2q.fsf@litku.valot.fi> <20090814110850.GU7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:34807 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbZHOHic (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 03:38:32 -0400
Received: by bwz22 with SMTP id 22so1484591bwz.18
        for <linux-omap@vger.kernel.org>; Sat, 15 Aug 2009 00:38:32 -0700 (PDT)
In-Reply-To: <20090814110850.GU7278@atomide.com> (Tony Lindgren's message of "Fri\, 14 Aug 2009 14\:08\:51 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

>> > Still passing clock names around?
>> 
>> Sorry, I'm not familiar with this. How should I fix it?
>
> This should be fixed with the clkdev alias, see omap24xx_clks[].
>
> But we need to check how the fix affects other platforms for
> drivers/usb/musb/musb_core.c and send the patch via linux-usb.
>
> Maybe take a quick look, and if it looks like a bigger change,
> then leave out the tusb_data for now and let's do it in a separate
> patch?

I'm not familiar enough the clock framework and right now I don't have
enough time to study it properly. So I decided to remove tusb_data and
also rest of the now unusable usb code from the board file. I'll send a
v2 shortly.

-- 
Kalle Valo
