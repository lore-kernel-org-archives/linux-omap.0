From: Paul Walmsley <paul@pwsan.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Wed, 25 Jan 2012 20:44:42 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201252043590.11174@utopia.booyaka.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <alpine.DEB.2.00.1201251418310.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42848 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2AZDon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 22:44:43 -0500
In-Reply-To: <alpine.DEB.2.00.1201251418310.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Orjan Friberg <of@flatfrog.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 25 Jan 2012, Paul Walmsley wrote:

> On Wed, 25 Jan 2012, Paul Walmsley wrote:
> 
> > - Try changing all the spin_lock() calls to spin_lock_irqsave() and all 
> >   the spin_unlock() calls to spin_unlock_irqrestore() to see if the 
> >   preemption count is being prematurely decremented
> 
> Just to clarify, I mean in the jffs2 code, not the entire kernel.

... and it just occurred to me that this is a waste of time -- that change 
shouldn't affect the preemption count.  So, please ignore that suggestion.  
Sorry about that.


- Paul
