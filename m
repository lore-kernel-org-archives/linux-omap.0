From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH D 01/11] OMAP: Add clk_get_parent() for OMAP2/3
Date: Sat, 31 Jan 2009 14:23:44 +0000
Message-ID: <20090131142344.GM1394@n2100.arm.linux.org.uk>
References: <20090128191638.16688.33452.stgit@localhost.localdomain> <20090128191807.16688.91255.stgit@localhost.localdomain> <20090129110043.GE12627@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901292327090.26985@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53178 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZAaOX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 09:23:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0901292327090.26985@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Tony Lindgren <tony@atomide.com>

On Thu, Jan 29, 2009 at 11:29:31PM -0700, Paul Walmsley wrote:
> On Thu, 29 Jan 2009, Russell King - ARM Linux wrote:
> 
> > On Wed, Jan 28, 2009 at 12:18:16PM -0700, Paul Walmsley wrote:
> > > From: Mans Rullgard <mans@mansr.com>
> > > 
> > > This makes clk_get_parent() work on OMAP2/3.
> > 
> > This is clearly something that the generic code should be doing.
> > It's not something specific to OMAP2/3.  Please move it to
> > arch/arm/plat-omap/clock.c
> 
> Done; revised patch below.

Great, thanks.  However, I'd forgotten that one of my patches completely
removes clk_get_parent() since it's unused by any code in OMAP at present.

What was the reasoning behind making this work?
