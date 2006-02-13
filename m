From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: [PATCH] omap camera
Date: Mon, 13 Feb 2006 22:53:58 +0200
Message-ID: <20060213205358.GA16271@nokia.com>
References: <304D2A85A9643F4A991BDDF8D297BBA60244DAE3@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA60244DAE3@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 13, 2006 at 10:01:55AM -0600, Zhang, Jian wrote:
> Omap1 and omap2 camera drivers were developed independently. Omap2
> drivers relies on a few omap2 advanced features (DSS, auto frame start
> detection, camera DMA) Given their current status, it would be difficult
> to merge them in practice.
> 
> Video-buf.c does the scatter-gather. Camera driver only uses the
> scattered buffers. I don't know DMA API even does scatter-gather?
> 
See Documentation/DMA-API.txt. It'll deal with the mapping and unmapping
of the scatterlists, but you'll still have to deal with the transfer
handling. I suppose the video-buf.c management code wraps in to this
already for you at first glance..

> Enabling MMU would make scatter-gather unnecessary but it would make the
> use of video-buf.c not easy. There is no plan to enable MMU as of today.
> 
Perhaps not, but you would be able to do away with most of the bounce
buffers. Not to mention, you can also pre-fault the camera TLB and not
even bother with a page fault handler. The TLB miss is also easy to
handle..

This should be trivial to deal with if you implement your own mmap() (and
possibly get_unmapped_area()) for the camera driver itself. You should be
able to zero-copy the read and write to this space. I'm not sure why
you'd even want to bother with scatterlists. Can you explain the use case
where the scatterlists are going to be useful?

For what it's worth, I have some code already for manipulating the
camera, IVA, and DSP MMUs on OMAP2420 that I can make available if
someone is interested in working on this.
