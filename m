From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: ti-dma-crossbar: Fix possible race condition
 with dma_inuse
Date: Fri, 22 Sep 2017 14:13:01 +0530
Message-ID: <20170922084300.GP30097@localhost>
References: <20170921113532.15297-1-peter.ujfalusi@ti.com>
 <20170921173013.GL30097@localhost>
 <9ed74f0c-9363-efbf-3fdf-47ebd1fd4eea@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ed74f0c-9363-efbf-3fdf-47ebd1fd4eea@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 22, 2017 at 10:03:59AM +0300, Peter Ujfalusi wrote:
> Vinod,
> 
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> On 2017-09-21 20:30, Vinod Koul wrote:
> > On Thu, Sep 21, 2017 at 02:35:32PM +0300, Peter Ujfalusi wrote:
> >> When looking for unused xbar_out lane we should also protect the set_bit()
> >> call with the same mutex to protect against concurrent threads picking the
> >> same ID.
> > 
> > Applied, thanks
> > 
> > Just a note, somehow the patches from you only are getting mangled for me.
> > Curiously, the ones in patchworks are fine and I used to apply that, not sure
> > what mail servers at our work places are doing!!
> 
> I'm afraid it is our mail servers where the mangling is happening :(
> We are trying to resolve this since early August when it first started
> to happen (and only for the guys in Finland).
> We are as frustrated as one can be, believe me.
> 
> PS: And the mangler will add a footer on top of this mail

ah okay, consider sending using some other server then, or just put up a
linux box in the corner like we do (@linux.intel.com)

-- 
~Vinod
