From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Mon, 3 May 2010 17:40:01 -0700
Message-ID: <20100504004001.GB29604@atomide.com>
References: <87sk6cirt0.fsf@deeprootsystems.com>
 <20100430210216.GI29604@atomide.com>
 <87vdb8hc2d.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
 <87y6g4d2ic.fsf@deeprootsystems.com>
 <20100430233002.GJ29604@atomide.com>
 <87sk6c8osn.fsf@deeprootsystems.com>
 <20100501013751.GL29604@atomide.com>
 <20100501015050.GM29604@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55223 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0EDAkG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 20:40:06 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>

* Pandita, Vikram <vikram.pandita@ti.com> [100503 15:06]:
> 
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Friday, April 30, 2010 8:51 PM
> >To: Kevin Hilman
> >Cc: Pandita, Vikram; linux-arm-kernel@lists.infradead.org; linux-
> >omap@vger.kernel.org; Pais, Allen
> >Subject: Re: [PATCH 02/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
> >
> >* Tony Lindgren <tony@atomide.com> [100430 18:33]:
> >>
> >> So far only tested on n900, will give it a try also on zoom3 after
> >> updating the zoom3 related patch.
> >
> >And here's the updated zoom debug_ll patch, seems to work.
> 
> For testing if I put this printk hack (the good old days patch), 
> Zoom3 does not boot after applying your patch.

You should not need that any longer if you have set
CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK and have earlyprintk
in the kernel cmdline.
 
> So looks like we are still missing something for zoom2/3 to work.
> Can debug tomorrow.

Hmm works just fine for me. Sounds like you only applied one of
the two patches needed to make DEBUG_LL work on zoom?

Anyways, I'll repost both patches needed for zoom as a reply to
this mail.

Regards,

Tony
