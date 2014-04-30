From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [patch V2 0/6] dma: edma: Provide granular residue accounting
Date: Wed, 30 Apr 2014 10:38:28 +0530
Message-ID: <20140430050828.GP32284@intel.com>
References: <20140428104416.464002156@linutronix.de>
 <535EBE69.6060803@ti.com>
 <20140429084635.GN32284@intel.com>
 <53607B1E.2030906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16469 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757775AbaD3FUk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 01:20:40 -0400
Content-Disposition: inline
In-Reply-To: <53607B1E.2030906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com, nsekhar@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Apr 29, 2014 at 11:25:02PM -0500, Joel Fernandes wrote:
> On 04/29/2014 03:46 AM, Vinod Koul wrote:
> [..]
> > commit 770f0f3a20188b7e17db2790803b9da925dc0b94
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Mon Apr 28 10:49:43 2014 +0000
> > 
> >     dmaengine: edma: Make reading the position of active channels work
> > 
> >     As Joel pointed out, edma_read_position() uses memcpy_fromio() to read
> >     the parameter ram. That's not synchronized with the internal update as
> >     it does a byte by byte copy. We need to do a 32bit read to get a
> >     consistent value.
> > 
> >     Further reading destination and source is pointless. In DEV_TO_MEM
> >     transfers we are only interested in the destination, in MEM_TO_DEV we
> >     care about the source. In MEM_TO_MEM it really does not matter which
> >     one you read.
> > 
> >     Simple solution: Remove the pointers, select dest/source via a bool
> >     and return the read value.
> > 
> >     Remove the export of this function while at it. The only potential
> >     user is the dmaengine and that's always builtin.
> > 
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > You s-o-b missing in this one, also ack from Sekhar missing. Do you want to redo
> > this or prefer me to cherry-pick patches adding acks and your s-o-b, since I
> > already fetched your branch
> > 
> > Either way is fine with me...
> > 
> 
> If its Ok with you, it would great if you could add my Ack and Sob.
> Thanks a lot. Let me know if you'd want me to do anything else here.
Done, The changes are getting pushed, pls do verify

-- 
~Vinod

