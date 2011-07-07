From: "Raju, Sundaram" <sundaram@ti.com>
Subject: RE: [RFC] dmaengine: add new api for preparing simple slave transfer
Date: Thu, 7 Jul 2011 17:45:04 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9403024F5420@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
	<20110609124723.GA24636@n2100.arm.linux.org.uk>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE2EFB@dbde02.ent.ti.com>
	<1307686140.10976.111.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE3405@dbde02.ent.ti.com>
	<1307724439.10976.188.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E9403020B7C2A@dbde02.ent.ti.com>
	<1308203119.10976.234.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1308203119.10976.234.camel@vkoul-udesk3>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan <dan.j.williams@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Koul, Vinod [mailto:vinod.koul@intel.com]
> Sent: Thursday, June 16, 2011 11:15 AM
> To: Raju, Sundaram
> Cc: Russell King - ARM Linux; Linus Walleij; Dan; davinci-linux-open-
> source@linux.davincidsp.com; linux-omap@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [RFC] dmaengine: add new api for preparing simple slave transfer
> 
> On Tue, 2011-06-14 at 12:12 +0530, Raju, Sundaram wrote:

<snip>

> Okay now things are more clear on what you are trying to do...

Vinod, 
Sorry for the delayed response. I was OOO and not well.
Thanks for going through the design documents and giving options.

>
> 2) I think this can be achieved in two ways:
> a) you use current standard sg_list mechanism, the dmac driver parses
> the list and  programs the dma offsets into dmac
> Pros: you can use existing APIs, no changes to i/f.
> If dmac has this capability they program dmac accordingly
> Cons: you need to create sg-list in client driver
>

This option does not satisfy the requirements.
As Russell has pointed out

> > >
> > > The overall conclusion which I'm coming to is that we already support
> > > what you're asking for, but the problem is that we're using different
> > > (and I'd argue standard) terminology to describe what we have.
> > >
> > > The only issue which I see that we don't cover is the case where you want
> > > to describe a single buffer which is organised as N bytes to be transferred,
> > > M following bytes to be skipped, N bytes to be transferred, M bytes to be
> > > skipped.  I doubt there are many controllers which can be programmed with
> > > both 'N' and 'M' parameters directly.
> > >
> >
> > Yes this is what I wanted to communicate and discuss in the list.
> > Thanks for describing it in the standard terminology, and pointing me in the
> > right direction.
> >

The sg_list caters to all the parameters that a client driver has to pass
to the DMAC driver except for the STRIDE related info of skipping certain
bytes within a single buffer entry of the sg_list.

> 
> b) create a new api to describe these offset values, something like:
> prep_buffer_offset(struct offset_description *buffer,.....)
> I would not like to change the current API for this and rather have a
> new API for this, this should better then overriding current.
> 

Yes, it would be better not to change the existing API.
This option seems good. But new API has to be added for this option.
Linus, had suggested something similar, but different,
Using the control API with a new dma_ctrl_cmd enum
defined for TI DMAC special configuration to be passed.
 
| Sundaram is this how your controller works?
| I mean the hardware can skip over sequences like this?
| 
| When we added the config interface to DMAengine I originally included
| a "custom config" call, but Dan wanted me to keep it out until we
| had some specific usecase for it. FSLDMA recently started
| to use it.
| 
| Notice how dmaengine_slave_config() is implemented:
| 
| static inline int dmaengine_slave_config(struct dma_chan *chan,
| 					  struct dma_slave_config *config)
| {
| 	return dmaengine_device_control(chan, DMA_SLAVE_CONFIG,
| 			(unsigned long)config);
| }
| 
| So what is passed to the driver is just an unsigned long.
| 
| This is actually modeled to be ioctl()-like so you can pass in a
| custom config to the same callback on the device driver,
| just use some other enumerator than DMA_SLAVE_CONFIG,
| say like FSLDMA already does with FSLDMA_EXTERNAL_START.
| 
| Just put some enumerator in enum dma_ctrl_cmd in
| dmaengine.h such as SDMA_TEXAS_STRIDE_CONFIG and call
| like this:
| 
| /* However that config struct needs to look, basically */
| static struct sdma_ti_stride_cgf = {
|      take = M,
|      skip = N,
| };
| 
| ret = chan->device->device_control(chan, SDMA_TEXAS_STRIDE_CONFIG,
| &sdma_ti_stride_cfg);
| 
| Or something like this.

I think this is better option than your 2b. This requires just an addition of
one more enum in the dma_ctrl_cmd. What do you think about this?
If Dan and you are okay with this I will send a small patch for this asap.

Regards,
Sundaram
