From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Mon, 5 Jul 2010 16:55:27 +0300
Message-ID: <20100705135526.GF15951@atomide.com>
References: <20100623133636.GC7058@shareable.org>
 <20100629141836.GM2822@atomide.com>
 <alpine.LFD.2.00.1006291355520.24097@xanadu.home>
 <20100630110828.GZ2822@atomide.com>
 <20100630131737.GF2822@atomide.com>
 <alpine.LFD.2.00.1006301011520.24097@xanadu.home>
 <20100701092510.GH2822@atomide.com>
 <20100701174051.GA8786@shareable.org>
 <alpine.LFD.2.00.1007012226170.26524@xanadu.home>
 <20100702103744.GJ6632@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54804 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab0GENze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 09:55:34 -0400
Content-Disposition: inline
In-Reply-To: <20100702103744.GJ6632@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jamie Lokier <jamie@shareable.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100702 13:32]:
> * Nicolas Pitre <nico@fluxnic.net> [100702 05:31]:
> > On Thu, 1 Jul 2010, Jamie Lokier wrote:
> > 
> > > Tony Lindgren wrote:
> > > > +static void __init kuser_get_tls_init(unsigned long vectors)
> > > > +{
> > > > +	/*
> > > > +	 * vectors + 0xfe0 = __kuser_get_tls
> > > > +	 * vectors + 0xfe8 = hardware TLS instruction at 0xffff0fe8
> > > > +	 */
> > > > +	if (tls_emu || has_tls)
> > > > +		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
> > > > +}
> > > 
> > > Just a little opinion: Perhaps has_tls_reg would be a clearer name.
> > > All variants "have TLS" after all.
> > 
> > Good point.
> 
> I like that too. Updated patch below.

I've uploaded this patch into Russell's patch system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6207/1

Jamie, assuming no more comments, do you care to Ack/Reviewed/Tested-by
the patch in the link above?

Regards,

Tony
