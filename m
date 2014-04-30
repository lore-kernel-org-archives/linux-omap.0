From: Joel Fernandes <joelf@ti.com>
Subject: Re: [patch V2 0/6] dma: edma: Provide granular residue accounting
Date: Tue, 29 Apr 2014 23:25:02 -0500
Message-ID: <53607B1E.2030906@ti.com>
References: <20140428104416.464002156@linutronix.de> <535EBE69.6060803@ti.com> <20140429084635.GN32284@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35998 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaD3EZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2014 00:25:37 -0400
In-Reply-To: <20140429084635.GN32284@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com, nsekhar@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/29/2014 03:46 AM, Vinod Koul wrote:
[..]
> commit 770f0f3a20188b7e17db2790803b9da925dc0b94
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Apr 28 10:49:43 2014 +0000
> 
>     dmaengine: edma: Make reading the position of active channels work
> 
>     As Joel pointed out, edma_read_position() uses memcpy_fromio() to read
>     the parameter ram. That's not synchronized with the internal update as
>     it does a byte by byte copy. We need to do a 32bit read to get a
>     consistent value.
> 
>     Further reading destination and source is pointless. In DEV_TO_MEM
>     transfers we are only interested in the destination, in MEM_TO_DEV we
>     care about the source. In MEM_TO_MEM it really does not matter which
>     one you read.
> 
>     Simple solution: Remove the pointers, select dest/source via a bool
>     and return the read value.
> 
>     Remove the export of this function while at it. The only potential
>     user is the dmaengine and that's always builtin.
> 
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> You s-o-b missing in this one, also ack from Sekhar missing. Do you want to redo
> this or prefer me to cherry-pick patches adding acks and your s-o-b, since I
> already fetched your branch
> 
> Either way is fine with me...
> 

If its Ok with you, it would great if you could add my Ack and Sob.
Thanks a lot. Let me know if you'd want me to do anything else here.

Regards,
-Joel

