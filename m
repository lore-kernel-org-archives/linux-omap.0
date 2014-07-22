From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Wed, 23 Jul 2014 01:42:30 +0200
Message-ID: <2209624.IN4gI3gsAa@avalon>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<5717663.qOZzl7syrN@avalon> <20140722061929.GD18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140722061929.GD18374-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

(Your attention is kindly requested in time for v3.17, please see below)

On Monday 21 July 2014 23:19:29 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [140721 11:17]:
> > On Monday 21 July 2014 02:33:36 Tony Lindgren wrote:
> >> * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [140721 02:16]:
> >>> On Friday 18 July 2014 11:53:56 Suman Anna wrote:
> >>>> On 07/18/2014 05:49 AM, Laurent Pinchart wrote:
> >>>>> Hello,
> >>>>> 
> >>>>> The OMAP3 ISP driver was the only user of the OMAP IOVMM API. Now
> >>>>> that is has been ported to the DMA API, remove the unused virtual
> >>>>> memory manager.
> >>>>> 
> >>>>> The removal is split in three patches to ease upstream merge. The
> >>>>> first patch removes the omap-iovmm driver, the second patch
> >>>>> removes setting of now unused platform data fields from arch code,
> >>>>> and the last patch cleans up the platform data structure.
> >>>> 
> >>>> Thanks for the revised series, it looks good. I have also tested the
> >>>> series on OMAP3, OMAP4 and OMAP5.
> >>>> 
> >>>> For the changes in the entire series,
> >>>> Acked-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> >>> 
> >>> Thank you.
> >>> 
> >>>>> I'd like to get at least the first patch merged in v3.17. To avoid
> >>>>> splitting the series across three kernel versions, it would be
> >>>>> nice to also merge at least the second patch for v3.17. If there's
> >>>>> no risk of conflict everything could be merged in one go through
> >>>>> the ARM SoC tree. Otherwise a stable branch with patch 1/3 will be
> >>>>> needed to base the arch change on.
> >>>>> 
> >>>>> Joerg, Tony, how would you like to proceed ?
> >>> 
> >>> The v3.17 merge window is getting close, it's probably too late to
> >>> merge patch 2/3. Joerg, could you please take 1/3 in your tree for
> >>> v3.17 ? 2/3 and 3/3 would then get in v3.18. Tony, how would you like
> >>> to proceed for those ?
> >> 
> >> How about Joerg maybe do an immutable branch against v3.16-rc1
> >> with just these three patches and merge it into your tree?
> >> 
> >> That way I too can merge the minimal branch in if there are conflics.
> >> If that works for Joerg, then for arch/arm/*omap* changes:
> >> 
> >> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > 
> > I've created an immutable branch (or, rather, immutable until the changes
> > reach mainline, at which point I will remove the branch) on top of
> > v3.16-rc1 with just the three patches from this series. You can find it
> > at.
> > 
> > 	git://linuxtv.org/pinchartl/media.git omap/iommu
> > 
> > Tony, is there still time to get this (and especially patch 2/3, which
> > touches arch/ code) in v3.17 ?
> 
> Yes as long as Joerg is OK to merge that branch in :)

Are you ? :-)

-- 
Regards,

Laurent Pinchart
