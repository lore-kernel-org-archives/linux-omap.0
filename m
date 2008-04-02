From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] TWL4030 keyboard driver enhancements
Date: Wed, 2 Apr 2008 12:42:06 +0300
Message-ID: <20080402094205.GL31913@atomide.com>
References: <002b01c8680e$ea2df390$988818ac@ent.ti.com> <1202756968.30713.155.camel@localhost.localdomain> <20080328080645.GG24896@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58479 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYDBJmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 05:42:13 -0400
Content-Disposition: inline
In-Reply-To: <20080328080645.GG24896@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Klaus.K Pedersen (Nokia-M/Helsinki)" <klaus.k.pedersen@nokia.com>
Cc: ext Girish <girishsg@ti.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080328 10:06]:
> * Klaus.K Pedersen (Nokia-M/Helsinki) <klaus.k.pedersen@nokia.com> [080211 21:10]:
> > On Tue, 2008-02-05 at 21:21 +0530, ext Girish wrote:
> > > 
> > > >Did the patch solve your problem? 
> > 
> > > Sorry for late reply. Well, I tried with that change but still I
> > > find some suppurious keys coming in. Find the following log, this
> > > might give a clear picture.
> > > 
> > > omap_twl4030keypad omap_twl4030keypad: Spurious key event 6-2
> > > omap_twl4030keypad omap_twl4030keypad: Spurious key event 6-3
> > > omap_twl4030keypad omap_twl4030keypad: Spurious key event 6-4
> > 
> > Strange, but as you have .col = 6, it must mean that you fall
> > in this case:
> > > >>         if (col == 0xFF)
> > > >>                 return (1 << n_cols);
> > 
> > But why could row-lines 2,3 and 4 (and only?) all be activated 
> > at the same time? From the log the driver even got the same data
> > from T2 twice (ie this data):
> > 
> > 	R#  col data
> > 	0   0000 0000
> > 	1   0000 0000
> > 	2   1111 1111
> > 	3   1111 1111
> > 	4   1111 1111
> > 
> > You haven't experienced problems without this patch? I would
> > expect spurious pressing of all the keys on row's 2-4:
> > 
> >         KEY(2, 0, KEY_ENTER),
> >         KEY(2, 1, KEY_I),
> >         KEY(2, 2, KEY_J),
> >         KEY(2, 3, KEY_K),
> >         KEY(2, 4, KEY_3),
> >         KEY(3, 0, KEY_M),
> >         KEY(3, 1, KEY_N),
> >         KEY(3, 2, KEY_O),
> >         KEY(3, 3, KEY_P),
> >         KEY(3, 4, KEY_Q),
> >         KEY(4, 0, KEY_R),
> >         KEY(4, 1, KEY_4),
> >         KEY(4, 2, KEY_T),
> >         KEY(4, 3, KEY_U),
> >         KEY(4, 4, KEY_D),
> >         KEY(5, 0, KEY_V),
> >         KEY(5, 1, KEY_W),
> >         KEY(5, 2, KEY_L),
> >         KEY(5, 3, KEY_S),
> >         KEY(5, 4, KEY_H),
> > 
> > 
> > I will prepare a new patch without the non-matrix key support, then
> > we can take it from there.
> 
> Any news on updating this patch?

I've pushed Klaus' original patch plus the n_cols fix as it's already
and improvment.

Tony
