From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/11] Some OMAP IOMMU cleanup patches
Date: Mon, 3 Aug 2015 11:12:29 -0500
Message-ID: <55BF92ED.7030704@ti.com>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
	<20150803135533.GH14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150803135533.GH14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 08/03/2015 08:55 AM, Joerg Roedel wrote:
> On Mon, Jul 20, 2015 at 05:33:22PM -0500, Suman Anna wrote:
>> Suman Anna (11):
>>   Documentation: dt: Add #iommu-cells info to OMAP iommu bindings
>>   iommu/omap: Remove all module references
>>   iommu/omap: Move debugfs functions to omap-iommu-debug.c
>>   iommu/omap: Protect omap-iopgtable.h against double inclusion
>>   iommu/omap: Remove unused union fields
>>   iommu/omap: Remove trailing semi-colon from a macro
>>   iommu/omap: Remove unnecessary error traces on alloc failures
>>   iommu/omap: Use BIT(x) macros in omap-iopgtable.h
>>   iommu/omap: Use BIT(x) macros in omap-iommu.h
>>   iommu/omap: Align code with open parenthesis
> 
> Applied these patches to arm/omap.

Thanks Joerg.

> 
>>   iommu/omap: Split multiple assignments into separate lines
> 
> Did not apply this one, there is nothing wrong with multiple
> assignments.

Yeah, that was just to satisfy checkpatch --strict.

regards
Suman
