From: Tony Lindgren <tony@atomide.com>
Subject: Re: tidspbridge build fails
Date: Sun, 23 Sep 2012 14:16:22 -0700
Message-ID: <20120923211621.GU28835@atomide.com>
References: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26587 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754464Ab2IWVQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Sep 2012 17:16:24 -0400
Content-Disposition: inline
In-Reply-To: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joni Lapilainen <joni.lapilainen@gmail.com>
Cc: linux-omap@vger.kernel.org

* Joni Lapilainen <joni.lapilainen@gmail.com> [120921 18:47]:
> Building tidspbridge fails:
> 
>   CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
> drivers/staging/tidspbridge/core/tiomap3430.c:421:25: error:
> 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
> drivers/staging/tidspbridge/core/tiomap3430.c:421:25: note: each
> undeclared identifier is reported only once for each function it
> appears in
> make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1

Hmm I think a fix for that is already queued by Greg and it
seems we don't have it in linux-omap master any longer as
I dropped it after Greg picked it up.

Does commit c37a1747 (staging: tidspbridge: Prepare for irqs.h removal)
in linux next solve the problem for you?

Regards,

Tony
