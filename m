From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02b/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
Date: Tue, 4 May 2010 16:09:17 -0700
Message-ID: <20100504230916.GR29604@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870304E80F5F@dbde02.ent.ti.com>
 <87y6g4d2ic.fsf@deeprootsystems.com>
 <20100430233002.GJ29604@atomide.com>
 <87sk6c8osn.fsf@deeprootsystems.com>
 <20100501013751.GL29604@atomide.com>
 <20100501015050.GM29604@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304F5A672@dbde02.ent.ti.com>
 <20100504004001.GB29604@atomide.com>
 <20100504005838.GF29604@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC3560870304F5AC4F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49252 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934571Ab0EDXJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 19:09:24 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870304F5AC4F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>

* Pandita, Vikram <vikram.pandita@ti.com> [100504 10:29]:
> 
> Tony
> 
> >-----Original Message-----
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Monday, May 03, 2010 7:59 PM
> >To: Pandita, Vikram
> >Cc: Kevin Hilman; linux-arm-kernel@lists.infradead.org; linux-
> >omap@vger.kernel.org; Pais, Allen
> >Subject: [PATCH 02b/11] omap2/3: Fix DEBUG_LL for omap zoom2/3
> >
> >And here's this patch one more time. Both 2a and 2b are needed
> >for zoom debug uart to work.
> 
> Test 1:
> Tested on Zoom3 with 02a and 02b applied. Enabled DEBUG_LL. 
> Booted fine.
> 
> Test 2:
> Applied Hack printk.patch (attached)
> Booted fine and duplicate logs can be seen on console => printascii is working.
> 
> Ack-by: Vikram Pandita <vikram.pandita@ti.com>

Good to hear it works for you now, thanks for testing.

Tony
