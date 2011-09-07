From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [RFC 7/7] iommu/core: split mapping to page sizes as supported by
	the hardware
Date: Wed, 7 Sep 2011 17:05:16 +0900
Message-ID: <CAHQjnOMnOjAJ6QuuLmLa1UKvTRHfyyjiUYrfvzLx8FSsCixxng@mail.gmail.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-8-git-send-email-ohad@wizery.com>
	<CAHQjnOMT3UOFMi=JbSXf4-s_BbZ+fSGbOEjxwT7t7N-zd+9-zg@mail.gmail.com>
	<CAK=WgbZPFryzCFLa5AhAYDmH1S8c3x-OsSTyxYeq0WLAe8VyTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbZPFryzCFLa5AhAYDmH1S8c3x-OsSTyxYeq0WLAe8VyTg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 7, 2011 at 3:01 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Cho,
>
> On Wed, Sep 7, 2011 at 4:30 AM, KyongHo Cho <pullip.cho@samsung.com> wrote:
>> Please find the following link that I submitted for our IOMMU.
>> https://lkml.org/lkml/2011/7/3/152
>>
>> s5p_iommu_map/unmap accepts any order of physical address and iova
>> without support of your suggestion if the order is not less than PAGE_SHIFT
>
> That's exactly what I'm trying to prevent; there's no reason to
> duplicate the exact same logic in every iommu driver.
>
> As a result, your map function is quite big (it even duplicates the
> same logic for every page size it tries).
>
I agree that my map function is big :)
However, it is faster because it does not calculate the given order and
not call any function.

> Try to rebase your patch on the "iommu/core: split mapping to page
> sizes as supported by the hardware" patch I've just sent, and see how
> significantly simpler your code becomes.
>
> Relying on a single implementation, provided by the IOMMU core, means
> less code to maintain (and debug) and a consistent behavior (across
> all supported hardware) exposed to users of the IOMMU API.
>
>> But I think IOMMU API must not expect that the caller of iommu_map() knows
>> about the restriction of IOMMU API implementation.
>
> Right. But I don't think there's any disagreement here ?
>
Yes, sorry:)

> If any, then I think that s5p_iommu_map() is more limited than what I
> propose: if it is given a 64KB region aligned only to a 4KB address,
> it will BUG_ON() it. While not ideal, I don't think there's any reason
> not to map it using 4KB pages (which is exactly what the new
> iommu_map() I propose will do).
>
It is a logical error because the caller of iommu_map() gives
4KB aligned physical address while saying that it is 64KB aligned.
I think it must not be happened .

> Thanks,
> Ohad.

Thank you.

KyongHo.
