From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/5] omap: dsp: remove shm from normal memory
Date: Mon, 8 Nov 2010 17:00:34 -0800
Message-ID: <20101109010034.GA18407@kroah.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <1289166209-32251-2-git-send-email-felipe.contreras@gmail.com>
 <20101109005320.GW9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46715 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab0KIBBo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 20:01:44 -0500
Content-Disposition: inline
In-Reply-To: <20101109005320.GW9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Mon, Nov 08, 2010 at 04:53:21PM -0800, Tony Lindgren wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [101107 13:34]:
> > Also, don't be picky about the location, which incidentally fixes the
> > build since MEMBLOCK_REAL_LIMIT is gone on 2.6.37.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> This is a valid fix for 2.6.37 -rc cycle now that the memblock code
> is in and should get merged with other drivers/staging/tidspbridge
> related fixes.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Ok, I'll take this in the staging-linus tree, thanks for the ack.

Felipe, I'll pull in your other reverts as well thanks for doing them.
I hope to get to them by the end of the week, lots of work to do due to
being gone last week...

thanks,

greg k-h
