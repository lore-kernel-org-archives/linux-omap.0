From: cody <mail.kai.huang@gmail.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as supported
 by the hardware
Date: Thu, 10 Nov 2011 20:16:16 +0800
Message-ID: <4EBBC090.4070109@gmail.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com> <1318850846-16066-3-git-send-email-ohad@wizery.com> <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com> <CAK=WgbZbfCRJqA-wwHN=iLH6rYyoKjJCaL0zMfY93Tg6Jw2uvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZbfCRJqA-wwHN=iLH6rYyoKjJCaL0zMfY93Tg6Jw2uvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/10/2011 03:31 PM, Ohad Ben-Cohen wrote:
> On Thu, Nov 10, 2011 at 8:17 AM, Kai Huang<mail.kai.huang@gmail.com>  wrote:
>    
>> Seems the unmap function don't take phys as parameter, does this mean
>> domain->ops->unmap will walk through the page table to find out the
>> actual page size?
>>      
> The short answer is yes, and furthermore, we also consider to remove
> the size param from domain->ops->unmap entirely at some point.
>
> We had a long discussion about it, please see:
>
> https://lkml.org/lkml/2011/10/10/234
>    
Yes I've seen your discussion, I followed this thread from beginning:)

How about the IOTLB flush? As I said I think we need to consider that 
IOMMU (even does not exist now) may have some limitation on IOTLB flush, 
and hiding page size from IOTLB flush code may hurt performance, or even 
worse, trigger undefined behaviors.

-cody
