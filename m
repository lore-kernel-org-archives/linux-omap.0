From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Fri, 25 Feb 2011 09:49:34 -0800
Message-ID: <20110225174934.GZ20560@atomide.com>
References: <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com>
 <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
 <20110202011006.GP3358@atomide.com>
 <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
 <20110202194855.GA3322@atomide.com>
 <cace62268ad657586f07ecbb0e6a99ab@mail.gmail.com>
 <84fafb82318b1287513d198c6535eb59@mail.gmail.com>
 <20110224173840.GC20560@atomide.com>
 <08df39a319ecf8f67fb87b4ba3af85dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28372 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab1BYRtl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 12:49:41 -0500
Content-Disposition: inline
In-Reply-To: <08df39a319ecf8f67fb87b4ba3af85dd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110224 21:31]:
> >
> > Was this with linux-omap master branch or mainline?
> >
> > The V6 vs V7 issues should be sorted out with Russell's patches that
> > we also have now in linux-omap master branch.
> >
> This was with mainline.
> Then I applied RMK's series and things were OK.

OK good to hear & thanks for checking that.

Tony
