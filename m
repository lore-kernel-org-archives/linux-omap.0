From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] omap_pm_get_device_context_loss_count() support on OMAP4
Date: Wed, 22 Jun 2011 10:27:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106220934300.23249@utopia.booyaka.com>
References: <4DF8AA2A.5050200@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57725 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab1FVQ1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:27:05 -0400
In-Reply-To: <4DF8AA2A.5050200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi Rajendra,

On Wed, 15 Jun 2011, Rajendra Nayak wrote:

> This is to take the discussion forward which I started here
> http://marc.info/?l=linux-omap&m=130812942102354&w=2
> on how to support the omap_pm_get_device_context_loss_count()
> api on OMAP4.
> 
> I started to work on this and thought I almost had patches
> which would do the job on OMAP4,(keep a per-module/hwmod
> context count by looking at the per-module context registers
> that exist on OMAP4, similar to the per-pwrdm count maintained by
> looking at the per-pwrdm prepwrst registers on OMAP3)
> until I realized my approach had 2 issues
> 
> -1- The book keeping (similar to whats done in pwrdm_pre_transition()
> and pwrdm_post_transition()) was turning out to be quite expensive
> to be done for *every* low power system/cpu transition.
> (Btw, some profiling shows me the existing book keeping is quite
> expensive already)

Do you know what the expensive part of the book keeping is?  i.e., is it 
the PRM register access, or waiting for the powerdomain transition, etc.?

> -2- Doing this book keeping *only* during low power system/cpu
> transitions is'nt enough as there could be modules which can
> independently transition while the MPU and L3 are still active
> like DSS, ABE, GFX etc.

This can only happen while the drivers are idle from a runtime PM 
perspective, correct?  In other words, context could only be lost after 
the driver's last pm_runtime_put*().

> This was avoided on OMAP3 with 'autodeps' as described in the discussion
> thread above which made book keeping in low power system/cpu
> transitions work for all.
> 
> Issue -1- might be a little easy to solve if the book-keeping
> needs to be done only for domains/modules which transition along
> with the system/cpu. The book keeping can then only be done for
> specific C states (and suspend) instead of doing it for all C states.
> 
> What I am unable to fix is Issue -2-.
> 
> Me and Santosh discussed a lot on how to handle this and we thought
> with all the HW governed transitions, the only foolproof way of
> doing this was if the HW itself could log a count instead of just
> logging the state of previous transition.
> (Which is not the case on OMAP4 :-))
> 
> Does anyone else see any other way of handling this (Issue -2-) on OMAP4
> in software?

As I understand it, those LOSTCONTEXT bits are only cleared when they are 
written to, correct?  So is it enough to check those bits during the hwmod 
enable, if the hwmod's enclosing powerdomain was programmed to some state 
that might cause it to lose context?

In other words, to take DSS as an example, when DSS is not in use, I don't 
think the exact count of how many times the DSS hardware went off and on 
is important.  (And as you mention, it doesn't seem possible to track this 
with the current hardware without those autodeps, which are undesirable 
for other reasons.)  But what is important to the core code is whether the 
DSS lost context between the last pm_runtime_put*() and a 
pm_runtime_get*().  And those LOSTCONTEXT bits should stay set until Linux 
clears them, right?

Does this sound reasonable, or am I missing something obvious? :-)


- Paul
