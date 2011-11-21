From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 07/18] mfd: omap-prm: added suspend prepare and
 complete callbacks
Date: Mon, 21 Nov 2011 15:00:36 +0200
Message-ID: <1321880436.2153.5.camel@sokoban>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
	 <1316781986-30642-8-git-send-email-t-kristo@ti.com> <87d3cpxnhc.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60095 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068Ab1KUNAo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Nov 2011 08:00:44 -0500
In-Reply-To: <87d3cpxnhc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Fri, 2011-11-18 at 11:02 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > These are needed because runtime PM is disabled during suspend, and
> > it is bad if we get interrupts from the PRCM chain handler during it.
> > Now, PRCM interrupt forwarding is disabled until the suspend->complete,
> > which makes sure that all the needed drivers are up.
> 
> Just to clarify...  based on reading the patch, the wakeup and PRCM
> interrupts themselves still happen (and are saved). They are just not
> dispatched to the drivers until ->complete().
> 

Yea, this is true. We just postpone the dispatching until ->complete().
This is accomplished by disabling all the interrupts from the mask
register once a wakeup interrupt happens, saving the mask, and restoring
it at complete() which triggers the pending interrupts again.

> I think the changelog should be a bit clearer about that.

I can take a look at this for the next version.

-Tero

> 
> Thanks,
> 
> Kevin


