From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH F 10/12] OMAP2/3 clock: omap2_clk_enable(): fix logic
Date: Mon, 2 Feb 2009 01:01:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0902020057560.888@utopia.booyaka.com>
References: <20090128193326.2396.9437.stgit@localhost.localdomain> <20090128193525.2396.11744.stgit@localhost.localdomain> <20090131105848.GC1394@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41555 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbZBBIBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 03:01:47 -0500
In-Reply-To: <20090131105848.GC1394@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Russell,

On Sat, 31 Jan 2009, Russell King - ARM Linux wrote:

> On Wed, Jan 28, 2009 at 12:35:28PM -0700, Paul Walmsley wrote:
> > Rearrange the parent clock enable status check code so it actually makes
> > sense.  No functional change.
> 
> I don't think there's anything gained from introducing the additional
> 'parent_ret' variable.

I thought it made the code slightly easier to understand; but, am not 
attached to it.  Please let me know if you'd like me to send a version of 
the patch without it,


- Paul
