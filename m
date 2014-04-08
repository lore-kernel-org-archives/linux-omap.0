From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Tue, 08 Apr 2014 14:50:38 +0200
Message-ID: <1907788.6W1haHecHa@avalon>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1523736.5PrLY3OqT5@avalon> <20140404101811.GR13491@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140404101811.GR13491-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

On Friday 04 April 2014 12:18:11 Joerg Roedel wrote:
> On Fri, Mar 14, 2014 at 12:00:16PM +0100, Laurent Pinchart wrote:
> > Right, we indeed need two levels of API, one for drivers such as
> > remoteproc that need direct control of the IOMMU, and one for drivers that
> > only need to map buffers without any additional requirement. In the second
> > case the drivers should ideally use the DMA mapping API not even be aware
> > that an IOMMU is present. This would require moving the ARM mapping
> > allocation out of the client driver.
> 
> These two levels exist in the form of the DMA-API and the IOMMU-API. In
> fact, the IOMMU-API was created to provide a way to drivers to specifiy
> the IOVA->PHYS mappings on its own.

I agree with you, the two levels are already present, but there's still rough 
edges that we need to soften. 

The ARM DMA API implementation requires someone to create the VA space mapping 
by calling arm_iommu_create_mapping() and attach devices to mappings by 
calling arm_iommu_attach_device(). This must only be performed for devices 
that use the DMA API, devices that manage their IOMMU directly will call to 
the IOMMU API directly.

One obvious possibility is to call those functions in the IOMMU bus masters 
device drivers. This is pretty easy, but makes the drivers IOMMU-aware (which 
I'd like to avoid) and doesn't allow multiple bus masters to share a VA space 
mapping. Another possibility is to place the calls in the IOMMU drivers. This 
has the advantage of removing any IOMMU knowledge from bus masters device 
drivers and allowing multiple bus masters per IOMMU, but makes IOMMU 
management by the DMA API unconditional.

Has anyone given this problem a though ?

> > The IOMMU core or the IOMMU driver will need to know whether the driver
> > expects to control the IOMMU directly or to have it managed transparently.
> > As this is a software configuration I don't think the information belongs
> > to DT. The question is, how should this information be conveyed ?
> 
> The way this works on x86 is that a device driver can use the DMA-API per
> default. If it wants to use the IOMMU-API it has to allocate a domain and
> add the device it handles to this domain (it can't use DMA-API anymore
> then).

Are drivers supposed to reimplement the DMA API internally in that case ?

-- 
Regards,

Laurent Pinchart
