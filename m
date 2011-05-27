From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Fri, 27 May 2011 08:49:21 -0700
Message-ID: <87fwo03zzy.fsf@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
	<20110527032439.GK5032@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45692 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774Ab1E0PtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 11:49:25 -0400
Received: by mail-px0-f174.google.com with SMTP id 15so1144247pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 08:49:24 -0700 (PDT)
In-Reply-To: <20110527032439.GK5032@ponder.secretlab.ca> (Grant Likely's
	message of "Thu, 26 May 2011 21:24:39 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

Hi Grant,

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, May 20, 2011 at 05:14:43PM +0200, Kevin Hilman wrote:
>> Start moving SoC-specific register handling out of the driver by passing
>> in register offsets in via platform data.
>> 
>> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
>> 
>> Applies on top of Tony's for-next branch (which include's the generic
>> IRQ chip work from tglx) and the OMAP GPIO driver move to
>> drivers/gpio.
>
> Hey Kevin,
>
> If you've got a branch with this series in it and tested, then I'd be
> happy to pull that instead of applying the patches myself.
>

Being very late in the cycle, I'd prefer to save this for 2.6.41.  Let's
just do the move for 2.6.40, and I'll (re)submit this early in the
2.6.41 cycle.  

Thanks,

Kevin
