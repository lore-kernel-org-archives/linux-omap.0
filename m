From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 2/6] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Mon, 15 Oct 2012 20:29:29 -0500
Message-ID: <CALLhW=6_0Rnp7-gNhCexUVzxam54KhoqAF6e8eiH5yo-wKBxzQ@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<1350003977-32744-5-git-send-email-omar.luna@linaro.org>
	<CAMP44s2LTGPnXQuetVLV1tA8w90gUtoJ5coucBUZsbqb3vFnng@mail.gmail.com>
	<CALLhW=5k=tAXo_5ri2WgetRgju9rC_Wm-o9-pfHSNqpe6FU5qQ@mail.gmail.com>
	<CAMP44s3wTYTFgSw7r+77zb0fxMSjo1R69Zx0nyM6Hgy2h=Gggw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMP44s3wTYTFgSw7r+77zb0fxMSjo1R69Zx0nyM6Hgy2h=Gggw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 12 October 2012 16:25, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>>> @@ -142,11 +142,10 @@ static int iommu_enable(struct omap_iommu *obj)
>>>>                 }
>>>>         }
>>>>
>>>> -       clk_enable(obj->clk);
>>>> +       pm_runtime_get_sync(obj->dev);
>>>>
>>>>         err = arch_iommu->enable(obj);
>>>>
>>>> -       clk_disable(obj->clk);
>>>
>>> The device will never go to sleep, until iommu_disable is called.
>>> clk_enable -> pm_runtime_get_sync, clk_disable pm_runtime_put.
>>
>> Which is what you want... why would you want your iommu to be disabled
>> if the client of that iommu could request a translation?
>
> That's the whole point of *dynamic* pm; _when_ the client wants to
> request a translation, _then_ the device is waken up, which is what I
> believe the code currently does.

No it doesn't, current code is working because the processor and the
iommu share the same clock, so enabling the processor is implicitly
guaranteeing that the iommu will be enabled. IMHO, there shouldn't be
such assumption that you can control both with the same clock.

So, once the remote processor is enabled, any "dynamic pm" from iommu
with current code has no effect because the clock was already enabled
for the processor.

> After your patch, even if I don't use the camera, or the DSP, the
> iommu devices will be enabled, and will be consuming energy *all the
> time*. Which I don't think is what we want.

Wrong, the iommu device will be enabled by pm_runtime_get_sync once
you decide to attach with iommu_attach_device, if you do not use
camera or the dsp, you won't turn ON the iommus.

On probe this patch does pm_runtime_enable, however this doesn't mean
the device is turned ON or resumed or kept ON all the time.

> I'm not saying I have a solution, I'm simply saying that's what's
> going to happen if I'm correct.

Ok, but that is not what happens here.

>> Remember that these iommus, sit along of other processors not on the
>> main processor side. So, this code should enable it for the other
>> processor to use, and there is no point where the processor can say
>> "I'm not using it, shut it down" or "I'm using it, turn it on" in the
>> middle of execution, other than suspend/resume and if supported,
>> autosuspend.
>
> I understand, but perhaps there should be?

Autosuspend is a feature missing and should handle the scenario where
the remote processor can sleep dynamically, this scenario should turn
off the iommu and the remote processor itself when there is no
workload but it depends on the remote processor activity not the iommu
activity.

>>>> @@ -1009,7 +1001,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>>>>         release_mem_region(res->start, resource_size(res));
>>>>         iounmap(obj->regbase);
>>>>
>>>> -       clk_put(obj->clk);
>>>> +       pm_runtime_disable(obj->dev);
>>>
>>> This will turn on the device unnecessarily, wasting power, and there's
>>> no need for that, kfree will take care of that without resuming.
>>
>> Left aside the aesthetics of having balanced calls, the device will be
>> enabled if there was a pending resume to be executed, otherwise it
>> won't, kfree won't increment the disable_depth counter and I don't
>> think that freeing the pointer is enough reason to ignore
>> pm_runtime_disable.
>
> You are doing __pm_runtime_disable(dev, true), kfree will do
> __pm_runtime_disable(dev, false), which is what we want. Both will
> decrement the disable_depth.

I'm quite confused here, could you please point me to the kfree snip
that does __pm_runtime_disable(dev, false)?

> But at least you agree that there's a chance that the device will be waken up.

Of course, if there is a pending resume to be executed, it must honor
that resume request and then turn off the device before removing the
iommu, IMHO.

>>> Also, I still think that something like this is needed:
>> ...
>>> +static struct clk cam_fck = {
>>> +       .name           = "cam_fck",
>>> +       .ops            = &clkops_omap2_iclk_dflt,
>>> +       .parent         = &l3_ick,
>>> +       .enable_reg     = OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
>>
>> a cam_fck name to enable the ick?
>
> Yeap, according to the TRM. Take a look at 12.3 Camera ISP Integration
> Fig 12-50.

What I meant is that, you are using the CM_ICLKEN to enable a clock
named "cam_fck" which has l3_ick as a parent. And that is not
consistent with what that register is meant to do, which is:

4.14.1.10 CAM_CM Registers

CM_ICKLEN_CAM
0x0: CAM_L3_ICK and CAM_L4_ICLK are disabled
0x1: CAM_L3_ICK and CAM_L4_ICLK are enabled

So, I'm complaining about the name "cam_fck", for an interface clock
with parent l3_ick. However I don't know why on section 12.3 they
refer to CAM_FCK to a l3_ick child clock.

Cheers,

Omar
