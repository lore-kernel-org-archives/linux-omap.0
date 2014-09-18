From: Tony Lindgren <tony@atomide.com>
Subject: Re: Questions about enabling dps(dynamic power switching) and SLM
Date: Thu, 18 Sep 2014 10:06:36 -0700
Message-ID: <20140918170635.GJ14505@atomide.com>
References: <BLU185-W2233E35F6629F6D4F137D6ECEB0@phx.gbl>
 <20140814140943.GB9239@atomide.com>
 <BLU185-W41F1B3F381C31F1C3B8266ECD40@phx.gbl>
 <BLU185-W16CBCC06A88D78F300AE9AECD40@phx.gbl>
 <20140819150110.GG9239@atomide.com>
 <BLU185-W41D02CD4B210AFAA8F36ECECC50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50559 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932117AbaIRRGt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 13:06:49 -0400
Content-Disposition: inline
In-Reply-To: <BLU185-W41D02CD4B210AFAA8F36ECECC50@phx.gbl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Deepa Raj <draj187@hotmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Deepa Raj <draj187@hotmail.com> [140904 08:59]:
>
> 1) Which register in omap3 (as you said dps works in OMAP3) that will
>  be configured to enable dps and slm?

Hardware enters deeper idle states automatically when configured
properly, see commits 3b8c4ebb7630, 9eca2837dd69 and c46f601cc2a0.
Also see the recent changes to drivers/mfd/twl4030-power.c.

> 2) I was working on OMAP3, I disabled TIDSP bridge driver mpu side as
> we do not need IVA2. IVA2 powerdomain was always on during boot and
> if the system is idle, it keeps on always on where I was expecting it
> will move to low power state (checked the transitions from pm_dbg/count).
> During suspend to RAM also , IVA2 was always on (hundred %s  sure no
> body is using it as mputidspbridge driver is always disabled). Why is
> it always on or do it needs some configuration. Since it was not going
> low power state, so I manually powered it off.Is there register
> configuration that i am missing so it will enter into low power state
> automatically, otherwise why it is always on even it is not being used?

IVA2 needs to be idled always, see commit 2d403f7b1981.

Regards,

Tony
