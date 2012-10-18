From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Thu, 18 Oct 2012 06:03:16 +0200
Message-ID: <CAMP44s1TGky2zxC4vb4CFHD-uuKu=vSFZccoQz2JFAShxbiuRA@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<1350003977-32744-5-git-send-email-omar.luna@linaro.org>
	<CAMP44s2LTGPnXQuetVLV1tA8w90gUtoJ5coucBUZsbqb3vFnng@mail.gmail.com>
	<CALLhW=5k=tAXo_5ri2WgetRgju9rC_Wm-o9-pfHSNqpe6FU5qQ@mail.gmail.com>
	<CAMP44s3wTYTFgSw7r+77zb0fxMSjo1R69Zx0nyM6Hgy2h=Gggw@mail.gmail.com>
	<CALLhW=6_0Rnp7-gNhCexUVzxam54KhoqAF6e8eiH5yo-wKBxzQ@mail.gmail.com>
	<CAMP44s0LSJhyG89mwJERHW0SsQrU+J4CC6=xhMUR=MSw0dxj-A@mail.gmail.com>
	<CALLhW=5W2Tkv0sHhsabV9d4hFqQw57f=55HvcPBfAoG1eqLrqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CALLhW=5W2Tkv0sHhsabV9d4hFqQw57f=55HvcPBfAoG1eqLrqA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 18, 2012 at 1:51 AM, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> On 15 October 2012 22:23, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>> On probe this patch does pm_runtime_enable, however this doesn't mean
>>> the device is turned ON or resumed or kept ON all the time.
>>
>> In fact it's the other way around; pm_runtime_enable turns off the
>> power (if it's ON).
>
> pm_runtime_enable just decrements the disable_depth counter. Doesn't
> turn off anything by itself.

pm_runtime_enable turns on power management, without it the device
remains in whatever state it booted.

>> device_del
>>  device_pm_remove
>>   pm_runtime_remove
>>    __pm_runtime_disable <- HERE
>
> I'm not entirely convinced _iommu_ follows this path, it doesn't
> create any devices nor register them... whereas mailbox does create
> devices and mailbox does follow this path for the devices created
> which are child devices.
>
> So this path won't take care of the omap-iommu device pm_runtime_disable.

Are you sure? What code-path calls omap_iommu_remove then?

Anyway, it was just an observation. I've seen other code do this.

-- 
Felipe Contreras
