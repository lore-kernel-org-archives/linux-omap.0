From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 0/6] OMAP IOMMU fixes
Date: Thu, 03 Apr 2014 23:23:29 +0200
Message-ID: <2189223.Pd4Lz3KLMf@avalon>
References: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<533DCC51.60101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <533DCC51.60101-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Thursday 03 April 2014 16:02:09 Suman Anna wrote:
> On 04/03/2014 03:01 PM, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set fixes miscellaneous issues with the OMAP IOMMU driver,
> > found when trying to port the OMAP3 ISP away from omap-iovmm to the ARM
> > DMA API. The biggest issue is fixed by patch 6/6, while the other patches
> > fix smaller problems that I've noticed when reading the code, without
> > experiencing them at runtime.
> > 
> > I believe I've addressed all comments received for v1. Suman, could you
> > please have a quick look at ack the patches you haven't acked yet ? I'll
> > then send a pull request.
> 
> Thanks for the revised series.
> 
> Just acked Patch 4/6. Patch 3/6 is a simple comment removal, and I am
> good with that change. First 3 are already are from me, so I guess you
> need to add your sign-off before you send out the pull request.

Sure, that was planned. Thank you for your ack.

-- 
Regards,

Laurent Pinchart
