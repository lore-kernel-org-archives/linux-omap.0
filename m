From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Generic DMA chaining APIs
Date: Fri, 10 Aug 2007 00:33:03 -0700
Message-ID: <20070810073303.GF8658@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701120BC1@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701120BC1@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070605 22:07]:
> Hi all:
> 
> I would like to port Generic DMA chaining API support from TI's 2430 DMA driver to our OMAP GIT DMA driver.
> 
> - Basically these APIs give flexibility for handling DMA chaining for drivers like McBSP (for audio), McSPI (for LCD), UART, etc. 
> 
> - Chaining is very important for drivers like Audio, LCD etc.
> 
> - Our current DMA driver on GIT does support APIs to enable /configure DMA logical channel chaining, but they have to be again used in client drivers to implement the queuing logic.
> 
> - Since there are multiple drivers in need of these kind of chaining support, it's preferable to implement them in a generic way so that all other drivers can leverage the code instead of creating a redundant copy in every driver.
> 
> A code snippet (from TI's DMA driver) is as shown below. Please do let me know if you find any issues with this kind of implementation/approach before I start (this week) this porting activity.
> 
> Thanks in advance.
> 
> APIs to be ported are:
> =====================
> omap_request_dma_chain
> omap_free_dma_chain
> omap_dma_chain_a_transfer
> omap_modify_dma_chain_params
> omap_start_dma_chain_transfers
> omap_stop_dma_chain_transfers
> 
> omap_dma_chain_status
> omap_get_dma_chain_index
> omap_get_dma_chain_dst_pos
> omap_get_dma_chain_src_pos

The new functions look OK to me.

Regards,

Tony
