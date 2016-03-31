From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: Re: [PATCH v3 1/2] usb:dwc3: Enable support for 64-bit system
Date: Thu, 31 Mar 2016 14:34:46 +0700
Message-ID: <CAKrQpSt3Tm4Bu02ujgDnYu+29zA8VuWQ18o-TFMU1HJ970CkSA@mail.gmail.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
	<1457594332-7490-2-git-send-email-tqnguyen@apm.com>
	<87pouci03i.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pouci03i.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>
List-Id: linux-omap@vger.kernel.org

Hi Balbi,
If CONFIG_DMA_CMA=y, dma mask is set properly. The issue just happen
when CONFIG_DMA_CMA is not set. In this case, dma mask is not set and
we need this code to check if dma mask should be manually set to 32 or
64.

----
Thang

On Wed, Mar 30, 2016 at 8:09 PM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
> Hi,
>
> "Thang Q. Nguyen" <tqnguyen@apm.com> writes:
>> From: "Thang Q. Nguyen" <tqnguyen@apm.com>
>>
>> Add 64-bit DMA operation support to the USB DWC3 driver.
>> First attempt to set the coherent DMA mask for 64-bit DMA.
>> If that failed, attempt again with 32-bit DMA.
>>
>> Changes from v2:
>>       - None.
>>
>> Changes from v1:
>>       - Remove WARN_ON if dma_mask is NULL
>
> these changes lines should be between the tearline (---) and diffstat
> below.
>
>> Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
>> ---
>>  drivers/usb/dwc3/core.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index de5e01f..2479c24 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -831,6 +831,21 @@ static int dwc3_probe(struct platform_device *pdev)
>>       dwc->mem = mem;
>>       dwc->dev = dev;
>>
>> +     /* Try to set 64-bit DMA first */
>> +     if (!pdev->dev.dma_mask)
>> +             /* Platform did not initialize dma_mask */
>> +             ret = dma_coerce_mask_and_coherent(&pdev->dev,
>> +                                                DMA_BIT_MASK(64));
>> +     else
>> +             ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +
>> +     /* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
>> +     if (ret) {
>> +             ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> +             if (ret)
>> +                     return ret;
>> +     }
>
> Also, why is it so that you need this now ? glue layers are copying dma
> mask from parent device and that should be set properly. This really
> shouldn't be necessary in dwc3-core; it would mean that glue layer
> didn't set this device up properly.
>
> --
> balbi



-- 

Thang Q. Nguyen    | Staff SW Eng.

C: +849.7684.7606 | O: +848.3770.0640

F: +848.3770.0641  | tqnguyen@apm.com
