From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Fri, 12 Oct 2012 23:25:05 +0200
Message-ID: <CAMP44s3wTYTFgSw7r+77zb0fxMSjo1R69Zx0nyM6Hgy2h=Gggw@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<1350003977-32744-5-git-send-email-omar.luna@linaro.org>
	<CAMP44s2LTGPnXQuetVLV1tA8w90gUtoJ5coucBUZsbqb3vFnng@mail.gmail.com>
	<CALLhW=5k=tAXo_5ri2WgetRgju9rC_Wm-o9-pfHSNqpe6FU5qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CALLhW=5k=tAXo_5ri2WgetRgju9rC_Wm-o9-pfHSNqpe6FU5qQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 7:46 PM, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> On 12 October 2012 02:48, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> I already made most of these comments, but here they go again.
>
> I replied to all, but here it goes again:

Mostly, but not all :)

>>> @@ -142,11 +142,10 @@ static int iommu_enable(struct omap_iommu *obj)
>>>                 }
>>>         }
>>>
>>> -       clk_enable(obj->clk);
>>> +       pm_runtime_get_sync(obj->dev);
>>>
>>>         err = arch_iommu->enable(obj);
>>>
>>> -       clk_disable(obj->clk);
>>
>> The device will never go to sleep, until iommu_disable is called.
>> clk_enable -> pm_runtime_get_sync, clk_disable pm_runtime_put.
>
> Which is what you want... why would you want your iommu to be disabled
> if the client of that iommu could request a translation?

That's the whole point of *dynamic* pm; _when_ the client wants to
request a translation, _then_ the device is waken up, which is what I
believe the code currently does.

After your patch, even if I don't use the camera, or the DSP, the
iommu devices will be enabled, and will be consuming energy *all the
time*. Which I don't think is what we want.

I'm not saying I have a solution, I'm simply saying that's what's
going to happen if I'm correct.

> Remember that these iommus, sit along of other processors not on the
> main processor side. So, this code should enable it for the other
> processor to use, and there is no point where the processor can say
> "I'm not using it, shut it down" or "I'm using it, turn it on" in the
> middle of execution, other than suspend/resume and if supported,
> autosuspend.

I understand, but perhaps there should be?

>>> @@ -288,7 +285,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>>>         if (!obj || !obj->nr_tlb_entries || !e)
>>>                 return -EINVAL;
>>>
>>> -       clk_enable(obj->clk);
>>> +       pm_runtime_get_sync(obj->dev);
>>>
>>>         iotlb_lock_get(obj, &l);
>>>         if (l.base == obj->nr_tlb_entries) {
>>> @@ -318,7 +315,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>>>
>>>         cr = iotlb_alloc_cr(obj, e);
>>>         if (IS_ERR(cr)) {
>>> -               clk_disable(obj->clk);
>>> +               pm_runtime_put_sync(obj->dev);
>>>                 return PTR_ERR(cr);
>>>         }
>>
>> If I'm correct, the above pm_runtime_get/put are redundant, because
>> the count can't possibly reach 0 because of the reason I explained
>> before.
>>
>> The same for all the cases below.
>
> You can access this paths through debugfs, some of them doesn't work
> if the module is not enabled first, but in future if you just want to
> idle the iommu withouth freeing, these are needed to debug.
>
> BTW, the next patch in the series: ARM: OMAP: iommu: pm runtime save
> and restore context, let's you do a pm_runtime_[enable|put] through
> save/restore ctx functions, which is just for compatibility on how isp
> code uses the save and restore code.

All right, it has been some time since I've touched pm code, so if you say so.

>>> @@ -1009,7 +1001,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>>>         release_mem_region(res->start, resource_size(res));
>>>         iounmap(obj->regbase);
>>>
>>> -       clk_put(obj->clk);
>>> +       pm_runtime_disable(obj->dev);
>>
>> This will turn on the device unnecessarily, wasting power, and there's
>> no need for that, kfree will take care of that without resuming.
>
> Left aside the aesthetics of having balanced calls, the device will be
> enabled if there was a pending resume to be executed, otherwise it
> won't, kfree won't increment the disable_depth counter and I don't
> think that freeing the pointer is enough reason to ignore
> pm_runtime_disable.

You are doing __pm_runtime_disable(dev, true), kfree will do
__pm_runtime_disable(dev, false), which is what we want. Both will
decrement the disable_depth.

But at least you agree that there's a chance that the device will be waken up.

>> Also, I still think that something like this is needed:
> ...
>> +static struct clk cam_fck = {
>> +       .name           = "cam_fck",
>> +       .ops            = &clkops_omap2_iclk_dflt,
>> +       .parent         = &l3_ick,
>> +       .enable_reg     = OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
>
> a cam_fck name to enable the ick?

Yeap, according to the TRM. Take a look at 12.3 Camera ISP Integration
Fig 12-50.

Cheers.

-- 
Felipe Contreras
