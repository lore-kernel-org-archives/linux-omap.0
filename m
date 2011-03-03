From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the hwmod
 data.
Date: Thu, 3 Mar 2011 10:31:11 -0800
Message-ID: <20110303183111.GO20560@atomide.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com>
 <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com>
 <4D62AAAA.40104@ti.com>
 <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40121 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab1CCSbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 13:31:15 -0500
Content-Disposition: inline
In-Reply-To: <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Sricharan R <r.sricharan@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110221 11:01]:
> > -----Original Message-----
> > From: Cousson, Benoit [mailto:b-cousson@ti.com]
> > Sent: Monday, February 21, 2011 11:41 PM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
> > Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the
> > hwmod data.
> >
> > On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
> > > From: sricharan<r.sricharan@ti.com>
> > >
> > > The l3 interconnect device is build with all the data required
> > > to handle the error logging. The data is extracted from the
> > > hwmod data base.
> > >
> > > Signed-off-by: sricharan<r.sricharan@ti.com>
> > > Signed-off-by: sricharan<r.sricharan@ti.com>
> > > Tested-by: sricharan<r.sricharan@ti.com>
> >
> > Mmm, I'm not sure the tested-by is meaningfull in your case, since
> > you wrote the code and so everybody will assume you tested it.
> > One s-o-b should be probably enough.
> >
> 
> Well he tested whole series including the patch from Felipe.
> So a tested-by on whole series doesn't hurt, right ?
> 
> Just for record, I have seen tested by applied on whole series
> Where as some of the patches in this series are just comment
> updates.

Well Signed-off-by also means Tested-by. If not, it should
be specifically mentioned when the patch is posted. Something
like "PLEASE NOTE THAT THIS PATCH IS COMPLETELY UNTESTED".

Also one Signed-off-by is enough like Benoit pointed out :)

Tony



