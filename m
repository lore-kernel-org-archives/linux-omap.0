From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [patch V2 0/6] dma: edma: Provide granular residue accounting
Date: Tue, 29 Apr 2014 14:16:35 +0530
Message-ID: <20140429084635.GN32284@intel.com>
References: <20140428104416.464002156@linutronix.de> <535EBE69.6060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <535EBE69.6060803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joel Fernandes <joelf@ti.com>
Cc: nsekhar@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 28, 2014 at 03:47:37PM -0500, Joel Fernandes wrote:
> On 04/28/2014 05:49 AM, Thomas Gleixner wrote:
> > A simpler version to provide granular residue accounting and readout
> > for EDMA.
> > 
> > Delta to V1:
> > 
> >       - Removed the double read of the address in PaRAM
> > 
> >       - Simplified the stats update in the interrupt callback for
> >         intermediate transfers
> > 
> > Thanks,
> > 
> > 	tglx
> > 
> 
> Thanks for the series. I went over all the patches and it looks great.
> Acked-by: Joel Fernandes <joelf@ti.com>
> 
> The patches however didn't apply and had some conflicts with my dma
> memcpy series and peter's cyclic series so I resolved conflicts and
> created a single branch based on Vinod's slave-dma next branch (commit
> 406efb1a745c1dc512dc9c3c859e302e7b7f907e) that Vinod can pull.
> 
> I also renamed subject line of patches in Thomas's series to be
> "dmaengine: edma" and documented some of the variables used.
> 
> https://github.com/joelagnel/linux-kernel.git (for-vinod branch)
> 
> Vinod, could you pull if it looks OK?

The patches look good.

But,
commit 770f0f3a20188b7e17db2790803b9da925dc0b94
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Apr 28 10:49:43 2014 +0000

    dmaengine: edma: Make reading the position of active channels work

    As Joel pointed out, edma_read_position() uses memcpy_fromio() to read
    the parameter ram. That's not synchronized with the internal update as
    it does a byte by byte copy. We need to do a 32bit read to get a
    consistent value.

    Further reading destination and source is pointless. In DEV_TO_MEM
    transfers we are only interested in the destination, in MEM_TO_DEV we
    care about the source. In MEM_TO_MEM it really does not matter which
    one you read.

    Simple solution: Remove the pointers, select dest/source via a bool
    and return the read value.

    Remove the export of this function while at it. The only potential
    user is the dmaengine and that's always builtin.

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

You s-o-b missing in this one, also ack from Sekhar missing. Do you want to redo
this or prefer me to cherry-pick patches adding acks and your s-o-b, since I
already fetched your branch

Either way is fine with me...

-- 
~Vinod
