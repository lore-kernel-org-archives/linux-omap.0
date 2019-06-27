From: Russell King - ARM Linux admin <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: SATA broken with LPAE
Date: Thu, 27 Jun 2019 10:07:53 +0100
Message-ID: <20190627090753.b5xfpnsicynnqj5c@shell.armlinux.org.uk>
References: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
	<20190626125325.GA4744@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190626125325.GA4744-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, "Nori,
	Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 26, 2019 at 02:53:25PM +0200, Christoph Hellwig wrote:
> Hi Roger,
> 
> it seems the arm dma direct mapping code isn't doing the right thing
> here.  On other platforms that have > 4G memory we always use swiotlb
> for bounce buffering in case a device that can't DMA to all the memory.
> 
> Arm is the odd one out and uses its own dmabounce framework instead,
> but it seems like it doesn't get used in this case.  We need to make
> sure dmabounce (or swiotlb for that matter) is set up if > 32-bit
> addressing is supported.  I'm not really an arm platform expert,
> but some of those on the Cc list are and might chime in on how to
> do that.

dmabounce has only ever been used with specific devices that have weird
setups.  Otherwise, we've never expected what you describe on ARM.  I
also don't recognise your assertion about the way the DMA API should
behave as ever having been documented as a requirement for architectures
to implement.

dmabounce comes with it some serious issues that have been known to
cause OOMs with old kernels (which have never been solved), so that
really isn't the answer.

This kind of breakage that is now being reported is exactly the problem
that I thought would happen with your patches.

32-bit ARM is in maintenance only now, there is no longer any appetite
nor funding for development work on core code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
