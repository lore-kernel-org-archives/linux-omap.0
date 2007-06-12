From: Tony Lindgren <tony@atomide.com>
Subject: Re: Query regarding omap_set_dma_transfer_params()
Date: Tue, 12 Jun 2007 06:43:00 -0700
Message-ID: <20070612134259.GH28834@atomide.com>
References: <61445c750706110756k39f09613ge0e7eedd0befe51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <61445c750706110756k39f09613ge0e7eedd0befe51f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Pharaoh . <pharaoh137@gmail.com> [070611 08:02]:
> Hi,
>
> I am trying to configure the DMA channels in my ALSA driver.  Functions 
> like
>
>
> void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
>                              unsigned long dest_start,
>                              int dst_ei, int dst_fi)
> and omap_set_dma_src_params() are used for configuration.
>
> What the last two fields i.e dst_ie and dst_fi mean here?

See dma.h, ei = element index and fi = frame index. Some of these are
documented in the 2912 TRM pdf.

> I think this has to do something with interrupts etc but not sure about it.
> Also
> I couldn't see those fields being populated anywhere in source (they are 0
> everywhere).
> I am referring 2.6.19-omap1.
>
> Also, I think that these are unnecessarily exported, since the function
> omap_set_dma_params()
> is already exported and it calls the above mentioned functions.  And
> normally the sequence of
> configuring the DMA channel is like
>
> -set src params
> -set dest params
> -set transfer params

Well you can do it both ways, sometimes you just want to update the
source or destination between transfers.

Tony
