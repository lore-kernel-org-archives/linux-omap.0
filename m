From: Tony Lindgren <tony@atomide.com>
Subject: Re: [UPDATE][PATCH 2/2][OMAPZOOM] DSPBRIDGE: Change address
	resources to void __iomem *Hi
Date: Mon, 2 Mar 2009 21:15:25 -0800
Message-ID: <20090303051524.GJ11864@atomide.com>
References: <269694c00903020500g3eaa4466x281d07a1bb7e2b7a@mail.gmail.com> <94a0d4530903020528w1e3f2d4bo56e80b572fc3e923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65068 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZCCFP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 00:15:28 -0500
Content-Disposition: inline
In-Reply-To: <94a0d4530903020528w1e3f2d4bo56e80b572fc3e923@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ameya Palande <2ameya@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Contreras <felipe.contreras@gmail.com> [090302 05:28]:
> On Mon, Mar 2, 2009 at 3:00 PM, Ameya Palande <2ameya@gmail.com> wrote:
> > I got following errors while applying this patch again the bridge patches
> > accumulated at:
> > http://gitorious.org/projects/tidspbridge2/repos/mainline/logs/tidspbridge
> 
> Tony: What happened to the dspbridge branch? IIRC you mentioned you
> created a branch in l-o.

Sorry, my fault. At some point I stopped fetching from Hiroshi's repo as
the fetch was always getting the whole pack. I still need to check that
the unnecessary pack objects don't stay around in linux-omap tree after
fetch. Hmm, maybe I'm running git prune and git repack -d -l before
doing the fetch..

Anyways, I've pushed the tidspbridge branch there manually now.

Regards,

Tony
