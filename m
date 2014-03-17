From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Tue, 18 Mar 2014 00:12:37 +0100
Message-ID: <11532438.LiO4XssOJh@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<53232B0F.6090701@ti.com> <201403141757.48824.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201403141757.48824.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Friday 14 March 2014 17:57:48 Arnd Bergmann wrote:
> On Friday 14 March 2014, Santosh Shilimkar wrote:
> > I remember NAKing this approach in past and my stand remains same. The
> > cache APIs which you are trying to use here are not suppose to be used
> > outside.
> > 
> > I think the right way to fix this is to make use of streaming APIs.
> > If needed, IOMMU can have its own dma_ops for special case handling if
> > any.
> > 
> > Russell, Arnd might have more ideas.
> 
> I have a bad feeling about using the dma-mapping API within the IOMMU code,
> because that driver is also used to implement the dma-mapping API for
> devices attached to the IOMMU. It's possible that it just works.

Right, but I hope the memory port used by the IOMMU to fetch page table 
entries will not go through itself the same IOMMU :-)

> Is the IOMMU actually designed to have page tables in noncoherent memory? I
> would have expected that the iopt accesses must all be done on
> dma_alloc_coherent() provided memory to guarantee proper accesses.

I'm not knowledgeable enough about the OMAP IOMMU, but at least the Renesas 
IOMMU doesn't need coherent memory as long as the driver makes sure that 
changes to the page tables are made visible to the device. That IOMMU can also 
use the DVM hardware coherency protocols on a cache coherent interconnect, but 
I haven't investigated that yet.

-- 
Regards,

Laurent Pinchart
