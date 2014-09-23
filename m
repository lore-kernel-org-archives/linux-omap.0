From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/omap: Reverse dependency between omap-iommu
	and omap-iommu2
Date: Tue, 23 Sep 2014 11:04:22 -0500
Message-ID: <54219A06.80201@ti.com>
References: <1410277545-32157-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<3123675.ihHe2cOfgC@avalon> <540F7FD0.4010109@ti.com>
	<2586861.3TFFdmAzkQ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2586861.3TFFdmAzkQ@avalon>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

>
> On Tuesday 09 September 2014 17:31:44 Suman Anna wrote:
>>> On Tuesday 09 September 2014 16:33:11 Suman Anna wrote:
>>>> On 09/09/2014 10:45 AM, Laurent Pinchart wrote:
>>>>> The OMAP IOMMU driver supports both the OMAP1 and OMAP2+ IOMMU variants
>>>>> by splitting the driver into a core module and a thin arch-specific
>>>>> operations module.
>>>>>
>>>>> (In practice only the OMAP2+ module omap-iommu2 is implemented, but
>>>>> let's not denigrate the effort.)
>>>>
>>>> Thank you for the patch. I had something similar in my list of cleanup
>>>> TODO items on the OMAP IOMMU driver, but I was intending to cut down
>>>> more and consolidate the omap-iommu.c and omap-iommu2.c files into a
>>>> single one.
>>>>
>>>> This had been the case from the introduction of the driver going back to
>>>> v2.6.30, and OMAP1 was never added and I doubt it would be added anytime
>>>> in the foreseeable future.
>>>>
>>>>> The arch-specific operations module registers itself with the OMAP IOMMU
>>>>> core module at initialization time. This initializes a module global
>>>>> arch-specific operations pointer, used at runtime by the IOMMU
>>>>> instances.
>>>>>
>>>>> This scheme causes several issues. In addition to making it impossible
>>>>> to support different OMAP IOMMU types in a single system (which in all
>>>>> fairness is quite unlikely to happen),
>>>>
>>>> Yep, except for a few enhancements (like reporting Fault PC address on
>>>> OMAP4 DSPs, and dropping both endianness support), the core IOMMU
>>>> functionality hasn't changed much between OMAP2 and the latest OMAP4+
>>>> SoCs. So, my plan was to completely get rid of the iommu_functions (it
>>>> also eliminates the need for exporting most of the OMAP IOMMU API). So
>>>> while I am ok with the current patch, I prefer consolidation than
>>>> keeping the scalability alive, it can always be added if a need for that
>>>> arises. What do you think?
>>>
>>> I agree with your approach, but in the meantime we have a problem to
>>> solve.
>>> How about applying this patch now (it goes in the right direction anyway),
>>> and then removing the iommu functions when you will have time ?
>>
>> Can you give the subsys_initcall solution a try to see if that resolves
>> the problem at hand? That would be a much smaller change, if that
>> doesn't work we can go with this patch.
> 
> It seems to work.
> 
>> I will work on my cleanup list for 3.19.
> 
> Does that schedule still hold ? If so I'll submit a simple subsys_initcall() 
> patch for v3.18.

Yes, that would be great. I am working on the patches and will post them
in a couple of days.

regards
Suman

> 
>>>>  it also causes initialization
>>>>  
>>>>> ordering issues by requiring the arch-specific operations module to be
>>>>> loaded before any IOMMU user. This results in a probe breakage with the
>>>>> OMAP3 ISP driver when not compiled as a module.
>>>>
>>>> This can be fixed if we make the current omap-iommu2.c as a
>>>> subsys_initcall as well, right?
>>>>
>>>> regards
>>>> Suman
>>>>
>>>>> Fix the problem by inverting the dependency. Instead of having the
>>>>> omap-iommu2 module register itself to iommu-omap, make the iommu-omap
>>>>> retrieve the omap-iommu2 operations structure directly when probing the
>>>>> IOMMU device. This ensures that a probed IOMMU will always have valid
>>>>> arch-specific operations.
>>>>>
>>>>> As the arch-specific operations pointer is now initialized at probe
>>>>> time, this change requires turning it from a global variable into a
>>>>> per-device variable.
>>>>>
>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>>>> ---
>>>>>
>>>>>  drivers/iommu/omap-iommu-debug.c |  6 ++-
>>>>>  drivers/iommu/omap-iommu.c       | 94 +++++++++++++--------------------
>>>>>  drivers/iommu/omap-iommu.h       | 10 ++++-
>>>>>  drivers/iommu/omap-iommu2.c      | 18 +-------
>>>>>  4 files changed, 45 insertions(+), 83 deletions(-)
> 
