From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] dmaengine: dma_slave_config: add support for
 slave port window
Date: Tue, 29 Nov 2016 18:44:44 +0530
Message-ID: <20161129131444.GR6408@localhost>
References: <20161117125017.14954-1-peter.ujfalusi@ti.com>
 <20161117125017.14954-2-peter.ujfalusi@ti.com>
 <1c9221e8-c2e9-4d87-4d74-670e1bc2fec1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c9221e8-c2e9-4d87-4d74-670e1bc2fec1@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 29, 2016 at 12:47:48PM +0200, Peter Ujfalusi wrote:
> Vinod,
> 
> On 11/17/2016 02:50 PM, Peter Ujfalusi wrote:
> > Some slave devices uses address window instead of single register for read
> > and/or write of data. With the src/dst_port_window_size the address window
> > can be specified and the DMAengine driver should use this information to
> > correctly set up the transfer to loop within the provided window.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> >  include/linux/dmaengine.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index cc535a478bae..689d44327ef3 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -336,6 +336,12 @@ enum dma_slave_buswidth {
> >   * may or may not be applicable on memory sources.
> >   * @dst_maxburst: same as src_maxburst but for destination target
> >   * mutatis mutandis.
> > + * @src_port_window_size: The length of the register area the data need to be
> > + * written on the device side. It is only used for devices which is using an
> > + * area instead of a single register to receive the data. Typically the DMA
> > + * loops in this area in order to transfer the data.
> > + * @dst_port_window_size: same as src_port_window_size but for the destination
> > + * port.
> 
> I think this needs some clarification.
> Should the src/dst_port_window_size be in bytes or in words? I think it would
> make more sense to define it as number of words to be in sync with the
> src/dst_maxburst.

Yes good catch, I would indeed prefer words here


-- 
~Vinod
