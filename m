From: Russell King - ARM Linux admin <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: SATA broken with LPAE
Date: Thu, 27 Jun 2019 11:09:19 +0100
Message-ID: <20190627100919.jgvtkhbpbml342cp@shell.armlinux.org.uk>
References: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
	<20190626125325.GA4744@lst.de>
	<20190627090753.b5xfpnsicynnqj5c@shell.armlinux.org.uk>
	<20190627091530.GA11809@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190627091530.GA11809-jcswGhMUV9g@public.gmane.org>
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

On Thu, Jun 27, 2019 at 11:15:30AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 27, 2019 at 10:07:53AM +0100, Russell King - ARM Linux admin wrote:
> > dmabounce has only ever been used with specific devices that have weird
> > setups.  Otherwise, we've never expected what you describe on ARM.  I
> > also don't recognise your assertion about the way the DMA API should
> > behave as ever having been documented as a requirement for architectures
> > to implement.
> 
> That requirement has basically always been there since at least the
> 2.6.x days.  The history here is that when 64-bit architectures showed
> up they all had iommus, so this wasn't an issue.  Next was x86 with
> highmem, which added special bounce buffering for block I/O and networking
> only.  Then ia64 showed up that didn't always have an iommu and swiotlb
> was added as a "software IOMMU".  At this point we had to bounce buffering
> schemes for block and networking, while everything else potentially
> DMAing to higher memory relied on swiotlb, which was picked up by
> basically every architecture that could have memory not covered by a
> 32-bit mask and didn't have an iommu.

If it wasn't documented...

> Except it seems arm never did
> that and has been lucky as people didn't try anything that is not
> block or networking on their extended physical address space.

Because no one knew that the requirement had been introduced, and we've
been reliant on all the code you've been stripping out.

You're now causing regressions on 32-bit ARM, so you get to fix it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
