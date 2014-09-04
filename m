From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAP2+: GPMC: NAND fixes for 3.17
Date: Thu, 4 Sep 2014 12:40:28 -0700
Message-ID: <20140904194027.GA14698@atomide.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
 <20140903214045.GK11766@atomide.com>
 <20140903214232.GL11766@atomide.com>
 <5408B6E0.2090806@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59298 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754376AbaIDTkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2014 15:40:35 -0400
Content-Disposition: inline
In-Reply-To: <5408B6E0.2090806@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org

* pekon <pekon@pek-sem.com> [140904 12:01]:
> Hi Tony,
> 
> On Thursday 04 September 2014 03:12 AM, Tony Lindgren wrote:
> >* Tony Lindgren <tony@atomide.com> [140903 14:41]:
> >>* Roger Quadros <rogerq@ti.com> [140902 06:57]:
> >>>Hi Tony,
> >>>
> >>>These are some of the issues I found while testing v3.17-rc3.
> >>>
> >>>- Wrong ECC scheme used for am43x GP and EPOS evm. We need to use
> >>>BCH16 instead of BCH8.
> >>>
> >>>- Wrong read/write wait pin monitoring setting used for NAND
> >>>resulting in "L3 application error" debug message on console.
> >>>
> >>>- Pin conflict issue on am43x EPOS evm with QSPI and NAND.
> >>
> >>Thanks applying into omap-for-v3.17/fixes-v2.
> >
> >Sorry replied to the wrong thread, this series still seems
> >to have some pending comments so not applying this one.
> >
> Only [Patch 3/6] had some pending comments, but after Roger's
> clarification there are no further comments from me. So for
> entire series ..
> 
> Reviewed-by: Pekon Gupta <pekon@pek-sem.com>

OK thanks will apply all into omap-for-v3.17/fixes-v2.

Regards,

Tony
