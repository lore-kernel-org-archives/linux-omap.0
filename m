From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Tue, 16 Oct 2012 05:23:01 +0200
Message-ID: <CAMP44s0LSJhyG89mwJERHW0SsQrU+J4CC6=xhMUR=MSw0dxj-A@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<1350003977-32744-5-git-send-email-omar.luna@linaro.org>
	<CAMP44s2LTGPnXQuetVLV1tA8w90gUtoJ5coucBUZsbqb3vFnng@mail.gmail.com>
	<CALLhW=5k=tAXo_5ri2WgetRgju9rC_Wm-o9-pfHSNqpe6FU5qQ@mail.gmail.com>
	<CAMP44s3wTYTFgSw7r+77zb0fxMSjo1R69Zx0nyM6Hgy2h=Gggw@mail.gmail.com>
	<CALLhW=6_0Rnp7-gNhCexUVzxam54KhoqAF6e8eiH5yo-wKBxzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALLhW=6_0Rnp7-gNhCexUVzxam54KhoqAF6e8eiH5yo-wKBxzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Oct 16, 2012 at 3:29 AM, Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

>> After your patch, even if I don't use the camera, or the DSP, the
>> iommu devices will be enabled, and will be consuming energy *all the
>> time*. Which I don't think is what we want.
>
> Wrong, the iommu device will be enabled by pm_runtime_get_sync once
> you decide to attach with iommu_attach_device, if you do not use
> camera or the dsp, you won't turn ON the iommus.

I see, somehow I conflated the two functions.

> On probe this patch does pm_runtime_enable, however this doesn't mean
> the device is turned ON or resumed or kept ON all the time.

In fact it's the other way around; pm_runtime_enable turns off the
power (if it's ON).

>>>>> @@ -1009,7 +1001,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>>>>>         release_mem_region(res->start, resource_size(res));
>>>>>         iounmap(obj->regbase);
>>>>>
>>>>> -       clk_put(obj->clk);
>>>>> +       pm_runtime_disable(obj->dev);
>>>>
>>>> This will turn on the device unnecessarily, wasting power, and there's
>>>> no need for that, kfree will take care of that without resuming.
>>>
>>> Left aside the aesthetics of having balanced calls, the device will be
>>> enabled if there was a pending resume to be executed, otherwise it
>>> won't, kfree won't increment the disable_depth counter and I don't
>>> think that freeing the pointer is enough reason to ignore
>>> pm_runtime_disable.
>>
>> You are doing __pm_runtime_disable(dev, true), kfree will do
>> __pm_runtime_disable(dev, false), which is what we want. Both will
>> decrement the disable_depth.
>
> I'm quite confused here, could you please point me to the kfree snip
> that does __pm_runtime_disable(dev, false)?

Sorry, not kfree, but the device removal process:

device_del
 device_pm_remove
  pm_runtime_remove
   __pm_runtime_disable <- HERE
 bus_remove_device
  device_release_driver
   __device_release_driver
    .remove => platform_drv_remove
     .remove => omap_iommu_remove

Actually, it seems the pm is disabled _before_ omap_iommu_remove is
even called, so it's a no-op.

>> But at least you agree that there's a chance that the device will be waken up.
>
> Of course, if there is a pending resume to be executed, it must honor
> that resume request and then turn off the device before removing the
> iommu, IMHO.

Who will turn off the device afterwards?

>>>> Also, I still think that something like this is needed:
>>> ...
>>>> +static struct clk cam_fck = {
>>>> +       .name           = "cam_fck",
>>>> +       .ops            = &clkops_omap2_iclk_dflt,
>>>> +       .parent         = &l3_ick,
>>>> +       .enable_reg     = OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
>>>
>>> a cam_fck name to enable the ick?
>>
>> Yeap, according to the TRM. Take a look at 12.3 Camera ISP Integration
>> Fig 12-50.
>
> What I meant is that, you are using the CM_ICLKEN to enable a clock
> named "cam_fck" which has l3_ick as a parent. And that is not
> consistent with what that register is meant to do, which is:
>
> 4.14.1.10 CAM_CM Registers
>
> CM_ICKLEN_CAM
> 0x0: CAM_L3_ICK and CAM_L4_ICLK are disabled
> 0x1: CAM_L3_ICK and CAM_L4_ICLK are enabled
>
> So, I'm complaining about the name "cam_fck", for an interface clock
> with parent l3_ick. However I don't know why on section 12.3 they
> refer to CAM_FCK to a l3_ick child clock.

Because it's also used as a functional clock.  Anyway, I don't care
much about the name of the clock, what is clear is that there's a link
missing to the l3_ick.

Cheers.

-- 
Felipe Contreras
