From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Wed, 9 Apr 2014 17:08:31 +0200
Message-ID: <20140409150831.GW13491@8bytes.org>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1907788.6W1haHecHa@avalon> <20140408134322.GT13491@8bytes.org>
	<9980327.f1Bry2ysvR@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9980327.f1Bry2ysvR@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 08, 2014 at 05:02:37PM +0200, Laurent Pinchart wrote:
> On Tuesday 08 April 2014 15:43:22 Joerg Roedel wrote:
> > Who is "someone" in this case?
> 
> That's exactly the problem :-) The ARM DMA API implementation doesn't care who 
> that "someone" is. Existing implementations call those functions either from 
> the bus masters device drivers (in which case the drivers need to be IOMMU-
> aware, even if they use the DMA API and don't need to handle the IOMMU 
> directly) or from the IOMMU drivers (in which case the bus masters device 
> drivers don't have to care about the IOMMU, but without a way for drivers to 
> handle the IOMMU directly when they need to). Possible other candidates are 
> core IOMMU code or bus code.

That doesn't sound very transparent for the device drivers. All what you
describe above (attaching a device to its default domain for DMA-API)
should happen in the IOMMU driver. For the device driver it should make
no difference if there is an IOMMU or not.

> If we call arm_iommu_attach_device() from the IOMMU driver to get default 
> transparent IOMMU handling, the function will then attach the device to the 
> default domain with a call to iommu_attach_device().

If you have to call a function it is not transparent anymore.

> If a driver needs to handle the IOMMU directly, should it start by
> detaching the device from the ARM IOMMU domain ? We would need to be
> very careful with the assumptions made by the different layers, as
> they might not support a driver attaching a new domain to a device
> that already has a domain attached. I'd feel more comfortable with
> avoiding to attach the default domain to the device in the first
> place, but that might not be easily doable.

The way this is solved by others is that iommu_attach_device()
automatically detaches the device from its default (DMA-API) domain and
attach it to the device drivers own domain. On iommu_detach_device() the
device is attached back to the default domain.


	Joerg
