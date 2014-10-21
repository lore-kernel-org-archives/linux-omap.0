From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 12/17] iommu/omap: Integrate omap-iommu-debug into
	omap-iommu
Date: Tue, 21 Oct 2014 16:28:27 -0500
Message-ID: <5446CFFB.8030704@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>	<1412111772-38006-13-git-send-email-s-anna@ti.com>	<2808184.EdyuxU2UIF@avalon>
	<542C26DF.9030102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <542C26DF.9030102-l0cyMroinI0@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

On 10/01/2014 11:07 AM, Anna, Suman wrote:
> Hi Laurent,
> 
>> On Tuesday 30 September 2014 16:16:07 Suman Anna wrote:
>>> The debugfs support for OMAP IOMMU is currently implemented
>>> as a module, warranting certain OMAP-specific IOMMU API to
>>> be exported. The OMAP IOMMU, when enabled, can only be built-in
>>> into the kernel, so integrate the OMAP IOMMU debug module
>>> into the OMAP IOMMU driver. This helps in eliminating the
>>> need to export most of the current OMAP IOMMU API.
>>>
>>> The following are the main changes:
>>> - The OMAP_IOMMU_DEBUG Kconfig option is eliminated, and
>>>   the OMAP IOMMU debugfs support is built alongside the OMAP
>>>   IOMMU driver, and enabled automatically only when debugfs
>>>   is enabled.
>>
>> That's the part I'm unsure about. We're loosing the ability to save space by 
>> not building the omap-iommu debugfs support when debugfs is enabled.
> 
> Yeah, I thought about it a bit, and went in favor of eliminating the
> Kconfig. I don't have a strong opinion on this, but if saving space is
> what is preferred, I can easily rework this patch to add it back.
> 
> Joerg, any preference which way we should go here?

I am looking to refresh this series for 3.19, and this is the only patch
that may need some changes. Please let me know what your preference is,
and I can rework this patch if needed. Either way,
the plan is to not have an OMAP IOMMU debugfs module, but only to
have an option not to build the debugfs portions.

regards
Suman

> 
>>
>> For the rest of the series,
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> Thank you for reviewing the patches.
> 
> regards
> Suman
> 
