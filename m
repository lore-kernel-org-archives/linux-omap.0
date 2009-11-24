From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH] ARM: OMAP: McBSP: Use register cache
Date: Tue, 24 Nov 2009 09:59:23 +0200
Message-ID: <20091124095923.4f60044c.jhnikula@gmail.com>
References: <200908121239.26346.jkrzyszt@tis.icnet.pl>
	<200911140306.44784.jkrzyszt@tis.icnet.pl>
	<200911232142.50234.jkrzyszt@tis.icnet.pl>
	<20091123235355.GJ22923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f223.google.com ([209.85.218.223]:43232 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbZKXH6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 02:58:18 -0500
Received: by bwz23 with SMTP id 23so6043625bwz.29
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 23:58:23 -0800 (PST)
In-Reply-To: <20091123235355.GJ22923@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 23 Nov 2009 15:53:55 -0800
Tony Lindgren <tony@atomide.com> wrote:

> > I have just found this patch, initially submitted on 2009-08-12, archived in 
> > linux-omap patchwork with State: Awaiting Upstream. What does it mean? Am I 
> > supposed to do something about it? After that many weeks of no negative 
> > comments nor requests for changes, and taking into account what Jarkko said 
> > lately in a different thread[*] about the McBSP register cache concept, can I 
> > assume that it has been generally accepted? Is it worth of refreshing against 
> > current linux-omap?
> 
> I'll just mark patches "Awaiting upstream" if I feel like somebody else
> should ack or merge it. If there are obvious changes needed, I'll mark
> it "Changes requested".
> 
> So for the patch, please refresh. Then let's apply it assuming Jarkko
> acks it.
> 
Yep, I was aware of this Janusz's patch and was thinking that it could
help also for developing the McBSP context save/restore features.

> > > > +	OMAP_MCBSP_WRITE(io_base, SPCR2, reg_cache->spcr2 = config->spcr2);
> > > > +	OMAP_MCBSP_WRITE(io_base, SPCR1, reg_cache->spcr1 = config->spcr1);
...
> > > > -	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
> > > > -	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
> > > > +	mcbsp->rx_word_length = (reg_cache->rcr1 >> 5) & 0x7;
> > > > +	mcbsp->tx_word_length = (reg_cache->xcr1 >> 5) & 0x7;

IMO these would be cleaner if you embed cache handling into read and
write functions only. Probably reading could have explicit _read and
read_cache functions when code is dealing with the status bits and when
just updating some cached bits.


-- 
Jarkko
