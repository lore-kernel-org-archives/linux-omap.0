From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES
 revisions
Date: Tue, 15 Dec 2009 14:26:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912151425070.12561@utopia.booyaka.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com> <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com> <4ADE5EE4.2030901@ti.com> <71a0d6ff0911020512k478a3f1du929f2abed42be07a@mail.gmail.com> <4AEEE901.6010000@ti.com>
 <20091102170123.GC15200@shisha.kicks-ass.net> <4AEF1B96.6070406@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671AbZLOV0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 16:26:34 -0500
In-Reply-To: <4AEF1B96.6070406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, virtuoso@slind.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2 Nov 2009, Nishanth Menon wrote:

> Alexander Shishkin had written, on 11/02/2009 11:01 AM, the following:
> [..]
> > > > > Issues with the strategy of restricting to the current 8 bits:
> > > > > a) Why extrabits now:
> > > > > we have 8 bits now and we would have used all 8 bits with 3630 with
> > > > > the
> > > > > mentioned patch. What do we do with the next revision of 3430? Do we
> > > > > want to
> > > > > increase the size once it comes along? OR Do we want to do it right
> > > > > now? Why
> > > > > wait till we get additional silicons to go figure how to add those
> > > > > bits as
> > > > > Richard pointed out, when there could be one more in the pipeline?
> > > > But this code will have to be revisited for each additional silicon
> > > > revision anyway, right? Why reserve now?
> > > > 
> > > Agreed, that is one of the possible approaches we could take (and
> > > seems to be the common consensus), we can review the structure at a
> > > later point of time.
> > > 
> > > http://patchwork.kernel.org/patch/54847/ seems to be the right
> > > direction for now at least.
> > 
> > Ok, so let's have it in, perhaps.
> Tony, Kevin, upto you guys now..

The product of this good discussion has been merged into Abhijit's first 
OMAP4 powerdomain patch and is queued for .34.


- Paul
