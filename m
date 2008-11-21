From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/2] OMAP2/3 GPTIMER: skip unnecessary TLDR write	during
 non-autoreload
Date: Fri, 21 Nov 2008 16:53:17 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036CD41930@dlee02.ent.ti.com>
References: <20081014172417.5459.36601.stgit@localhost.localdomain>
 <20081014172745.5459.1893.stgit@localhost.localdomain>
 <13B9B4C6EF24D648824FF11BE89671620365C448AB@dlee02.ent.ti.com>
 <20081121222232.GG4927@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35404 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbYKUWxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:53:25 -0500
In-Reply-To: <20081121222232.GG4927@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> * Woodruff, Richard <r-woodruff2@ti.com> [081014 12:47]:
> > >       omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
> > > -     omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
> > >       omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> > >  }
> >
> > I seem to recall there was a missed interrupt condition which this worked
> around.
> >
> > IIRC, the original code didn't bother with the load I added back as a work
> around as a way to get posted mode working.
>
> Well these seem to be working based on some quick timer tests.
> Pushing so we can verify it ;)

This kind of change might be better tested on the PM branch.  It's the kind of thing more likely to work with PM disabled.  Testing in both is good, PM for many things is less forgiving...

Regards,
Richard W.

