From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: disable DPLL autoidle while waiting for
 DPLL to lock
Date: Fri, 21 Nov 2008 16:22:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811211622210.22538@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811141043400.27331@utopia.booyaka.com> <20081121222807.GI4927@atomide.com> <87zljs66ty.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39136 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYKUXXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 18:23:01 -0500
In-Reply-To: <87zljs66ty.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Peter de Schrijver <peter.de-schrijver@nokia.com>

On Fri, 21 Nov 2008, Kevin Hilman wrote:

> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Paul Walmsley <paul@pwsan.com> [081114 09:46]:
> >> 
> >> During _omap3_noncore_dpll_lock(), if a DPLL has no active downstream
> >> clocks and DPLL autoidle is enabled, the DPLL may never lock, since it
> >> will enter autoidle immediately.  To resolve this, disable DPLL
> >> autoidle while locking the DPLL, and unconditionally wait for the DPLL
> >> to lock.  This fixes some bugs where the kernel would hang when returning
> >> from retention or return the wrong rate for the DPLL.
> >> 
> >> This patch is a collaboration with Peter de Schrijver 
> >> <peter.de-schrijver@nokia.com> and Kevin Hilman 
> >> <khilman@deeprootsystems.com>.
> >
> > Pushing to l-o tree today.
> >
> 
> Actually, I think Tero and Paul have a different fix for this now,
> which is what I've included in the latest PM branch.
> 
> Tero can you send the updated version of you "Fix a bug with noncore
> dpll rate calculation" patch?

No, this patch is still valid, and still should be pushed.  The 
calculation patch fixes a separate bug.


- Paul
