From: Omar Ramirez Luna <omar.luna-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Wed, 17 Oct 2012 18:51:02 -0500
Message-ID: <CALLhW=5W2Tkv0sHhsabV9d4hFqQw57f=55HvcPBfAoG1eqLrqA@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<1350003977-32744-5-git-send-email-omar.luna@linaro.org>
	<CAMP44s2LTGPnXQuetVLV1tA8w90gUtoJ5coucBUZsbqb3vFnng@mail.gmail.com>
	<CALLhW=5k=tAXo_5ri2WgetRgju9rC_Wm-o9-pfHSNqpe6FU5qQ@mail.gmail.com>
	<CAMP44s3wTYTFgSw7r+77zb0fxMSjo1R69Zx0nyM6Hgy2h=Gggw@mail.gmail.com>
	<CALLhW=6_0Rnp7-gNhCexUVzxam54KhoqAF6e8eiH5yo-wKBxzQ@mail.gmail.com>
	<CAMP44s0LSJhyG89mwJERHW0SsQrU+J4CC6=xhMUR=MSw0dxj-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMP44s0LSJhyG89mwJERHW0SsQrU+J4CC6=xhMUR=MSw0dxj-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 15 October 2012 22:23, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On probe this patch does pm_runtime_enable, however this doesn't mean
>> the device is turned ON or resumed or kept ON all the time.
>
> In fact it's the other way around; pm_runtime_enable turns off the
> power (if it's ON).

pm_runtime_enable just decrements the disable_depth counter. Doesn't
turn off anything by itself.

>>>>>> @@ -1009,7 +1001,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>>>>>>         release_mem_region(res->start, resource_size(res));
>>>>>>         iounmap(obj->regbase);
>>>>>>
>>>>>> -       clk_put(obj->clk);
>>>>>> +       pm_runtime_disable(obj->dev);
>>>>>
>>>>> This will turn on the device unnecessarily, wasting power, and there's
>>>>> no need for that, kfree will take care of that without resuming.
>>>>
>>>> Left aside the aesthetics of having balanced calls, the device will be
>>>> enabled if there was a pending resume to be executed, otherwise it
>>>> won't, kfree won't increment the disable_depth counter and I don't
>>>> think that freeing the pointer is enough reason to ignore
>>>> pm_runtime_disable.
>>>
>>> You are doing __pm_runtime_disable(dev, true), kfree will do
>>> __pm_runtime_disable(dev, false), which is what we want. Both will
>>> decrement the disable_depth.
>>
>> I'm quite confused here, could you please point me to the kfree snip
>> that does __pm_runtime_disable(dev, false)?
>
> Sorry, not kfree, but the device removal process:
>
> device_del
>  device_pm_remove
>   pm_runtime_remove
>    __pm_runtime_disable <- HERE

I'm not entirely convinced _iommu_ follows this path, it doesn't
create any devices nor register them... whereas mailbox does create
devices and mailbox does follow this path for the devices created
which are child devices.

So this path won't take care of the omap-iommu device pm_runtime_disable.

>>> But at least you agree that there's a chance that the device will be waken up.
>>
>> Of course, if there is a pending resume to be executed, it must honor
>> that resume request and then turn off the device before removing the
>> iommu, IMHO.
>
> Who will turn off the device afterwards?

What I meant is that omap_iommu_detach should turn off the device
before removing the iommu.

Cheers,

Omar
