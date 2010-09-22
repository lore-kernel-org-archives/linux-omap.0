From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 5/5] OMAP4: powerdomain: add context_offset field
Date: Wed, 22 Sep 2010 01:39:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220138490.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <1284641906-24231-3-git-send-email-rnayak@ti.com> <1284641906-24231-4-git-send-email-rnayak@ti.com> <1284641906-24231-5-git-send-email-rnayak@ti.com>
 <1284641906-24231-6-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1009220008560.21002@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02CD3C1A50@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45715 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab0IVHjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:39:19 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD3C1A50@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wed, 22 Sep 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, September 22, 2010 11:43 AM
> > To: Nayak, Rajendra; Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Kevin Hilman
> > Subject: Re: [PATCH 5/5] OMAP4: powerdomain: add context_offset field
> > 
> > Hello Santosh, Rajendra,
> > 
> > a few comments on this patch:
> > 
> > On Thu, 16 Sep 2010, Rajendra Nayak wrote:
> > 
> > > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > >
> > > Context register in various power domain is not at same offset
> > > on OMAP4. Mainly the CPUx context resgiters againts rest of
> > > them. This patch adds a field in power-domain strucures to handle
> > > this.
> > >
> > > This will be needed to make "pwrdm_clear_all_prev_pwrst" API work on
> > > OMAP4.
> > 
> > Is the powerdomain.c code that uses context_offset ready yet?  If not,
> > it seems best to submit this together with the code that uses it?
> > 
> It's the next series what Rajendra is doing. We can add this one as
> part of that series if you like.

Yep, let's do it that way.


regards

- Paul
