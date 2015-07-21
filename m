From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/11] iommu/omap: Remove all module references
Date: Tue, 21 Jul 2015 18:44:15 -0500
Message-ID: <55AED94F.50006@ti.com>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
	<1437431613-55656-3-git-send-email-s-anna@ti.com>
	<6880124.2DpxpaPkkx@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6880124.2DpxpaPkkx@avalon>
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
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

>
> On Monday 20 July 2015 17:33:24 Suman Anna wrote:
>> The OMAP IOMMU driver has been adapted to the IOMMU framework
>> for a while now, and it does not support being built as a
>> module anymore. So, remove all the module references from the
>> OMAP IOMMU driver.
>>
>> While at it, also relocate a comment around the subsys_initcall
>> to avoid a checkpatch strict warning about using a blank line
>> after function/struct/union/enum declarations.
>>
>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> 
> I think this is one of the checkpatch warnings that can be safely ignored, but 
> it doesn't matter much. The comment will be removed after the OMAP3 ISP and 
> OMAP IOMMU drivers get support for a saner IOMMU probing dependency order 
> solution.
> 
> The code seems fine to me.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Yes, indeed. I have also started to work on some patches to switch to
using the IOMMU_OF_DECLARE init, that should also help us. I will post
those for the 4.4 kernel merge window.

regards
Suman
