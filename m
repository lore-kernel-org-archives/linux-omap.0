From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] timer optimization part 2.
Date: Thu, 8 May 2008 10:40:40 -0700
Message-ID: <20080508174039.GD24454@atomide.com>
References: <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903D3B096@dlee13.ent.ti.com> <20080331104904.GK26502@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903E22347@dlee13.ent.ti.com> <20080402072340.GH31913@atomide.com> <49DA3A9F04A0E5498FF06EFCC343DCF90203DA56FF@dlee13.ent.ti.com> <3B6D69C3A9EBCA4BA5DA60D91302742904410321@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:63364 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbYEHRkl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 13:40:41 -0400
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742904410321@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [080507 16:47]:
> So what about this?

Yeah, looks good, I'll push it today.

Tony

> > -----Original Message-----
> > From: Woodruff, Richard
> > Sent: Friday, April 04, 2008 3:04 PM
> > To: Tony Lindgren
> > Cc: Kevin Hilman; linux-omap@vger.kernel.org
> > Subject: [PATCH] timer optimization part 2.
> > 
> > Hi,
> > 
> > This patch adds a new function timer_load_start() which optimizes the
> > system timer. In tree users have been updated to use this function.
> > 
> > This was tested and working on a pull as of 4 April 08 on 2.6.25-rc8-
> > omap1-04408-g722c80b on 3430SDP.  A previous version has been working
> > with out issue for a while now.
> > 
> > * Before patch register writes are taking up .078% @ 500MHz.
> > 
> >  Address                 |total  |min  |max      |avr
> |count|ratio%
> >  old\process\default_idle|7.369s |0.0us|999.902ms|14.477ms|509.
> |62.661%
> >  ld\Global\cpu_v7_do_idle|4.265s |0.0us|375.786ms|24.374ms|175.
> |36.270%
> >                 (UNKNOWN)|17.503ms|0.us|531.080us|5.119us|3419.
> |0.148%
> >  r\omap_dm_timer_set_load|8.135ms|0.0us|79.887us|15.065us|540.
> |0.069%
> > <--
> >  \vmlinux-old\Global\_end|2.023ms|0.0us|4.000us|0.560us|3613.
> |0.017%
> >  -old\Global\__raw_readsw|1.962ms|0.0us|108.610us|9.167us|214.
> |0.016%
> >  old\smc91x\smc_interrupt|1.353ms|0.0us|10.212us|2.348us|576.
> |0.011%
> >  s/namei\__link_path_walk|1.161ms|0.0us|4.310us|0.762us|  1524.
> |0.009%
> >  \omap_dm_timer_write_reg|1.085ms|0.0us|126.150us|2.153us|504.
> |0.009%
> > <--
> > 
> > * After patch timer functions do not show up in top listings.
> > 
> > Regards,
> > Richard W.
> 
