From: cody <mail.kai.huang@gmail.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as supported
 by the hardware
Date: Thu, 10 Nov 2011 22:35:34 +0800
Message-ID: <4EBBE136.4030404@gmail.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com> <1318850846-16066-3-git-send-email-ohad@wizery.com> <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com> <CAK=WgbZbfCRJqA-wwHN=iLH6rYyoKjJCaL0zMfY93Tg6Jw2uvA@mail.gmail.com> <4EBBC090.4070109@gmail.com> <20111110130801.GC13213@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111110130801.GC13213@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/10/2011 09:08 PM, Joerg Roedel wrote:
> On Thu, Nov 10, 2011 at 08:16:16PM +0800, cody wrote:
>    
>> On 11/10/2011 03:31 PM, Ohad Ben-Cohen wrote:
>>      
>>> On Thu, Nov 10, 2011 at 8:17 AM, Kai Huang<mail.kai.huang@gmail.com>   wrote:
>>>        
>>>> Seems the unmap function don't take phys as parameter, does this mean
>>>> domain->ops->unmap will walk through the page table to find out the
>>>> actual page size?
>>>>          
>>> The short answer is yes, and furthermore, we also consider to remove
>>> the size param from domain->ops->unmap entirely at some point.
>>>
>>> We had a long discussion about it, please see:
>>>
>>> https://lkml.org/lkml/2011/10/10/234
>>>        
>> Yes I've seen your discussion, I followed this thread from beginning:)
>>
>> How about the IOTLB flush? As I said I think we need to consider
>> that IOMMU (even does not exist now) may have some limitation on
>> IOTLB flush, and hiding page size from IOTLB flush code may hurt
>> performance, or even worse, trigger undefined behaviors.
>>      
> We can only care about IOMMUs that exist today or ones that will exist
> and we already know of.
> In general for the hardware I know of a page-size is not required for
> implementing unmap operations. Requiring this would imply that any user
> of the IOMMU-API needs to keeps track of the page-sizes used to map a
> given area.
> This would be a huge burden which is not really necessary because the
> IOMMU driver already has this information and can return it to the user.
> So if you want to change that you need a very good reason for it.
>
>    
Yes I totally agree page-size is not required for unmap operations and 
should not be added as parameter to map/unmap operations. I am not 
saying the unmap operation, but the IOTLB flush operation. My point is 
we also may also need to add similar logic in IOTLB flush code (such as 
in Intel IOMMU dirver) to grantee that when issuing IOTLB flush command 
for large page, we will still meet the hardware limitation of flushing 
large page. Seems for Intel IOMMU the only limitation is the mask value 
(indicating number of 4k-pages) cannot be smaller than the value to 
cover large page, and seems current Intel IOMMU driver code has covered 
this case well. I am not familiar with how AMD IOMMU issues IOTLB flush 
command, it should be able to handle this large page case too. So at 
this moment, this patch should not have any issues :)

-cody
> 	Joerg
>
>    
