From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: don't trace functions called from sched_clock
Date: Tue, 31 May 2011 04:50:40 -0700
Message-ID: <20110531115039.GZ11352@atomide.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
 <87hb8fyj2p.fsf@ti.com>
 <8762ovvf5f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19401 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754439Ab1EaLup (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 07:50:45 -0400
Content-Disposition: inline
In-Reply-To: <8762ovvf5f.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rabin Vincent <rabin@rab.in>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110527 17:28]:
> Kevin Hilman <khilman@ti.com> writes:
> 
> > Rabin Vincent <rabin@rab.in> writes:
> >
> >> omap_readl() is used from the sched_clock() implementations and so must
> >> be marked notrace to avoid recursion in ftrace.  Same thing with
> >> mpu_read() for OMAP1.
> >>
> >> Signed-off-by: Rabin Vincent <rabin@rab.in>
> >
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> I also meant to suggest this should probably queue for .40-rc series.

Took a quick look and we should get rid of the omap_readl usage instead
like I commented in another mail.

Tony
