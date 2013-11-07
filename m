From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 15:46:11 -0500
Message-ID: <CANacCWwpRGnTx_FzN0RjkYqPjmy7osbQEa-wJkr+S3Lv49oc8g@mail.gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
	<527BB307.7090401@ti.com>
	<527BBF8C.4060409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:60196 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab3KGUqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 15:46:12 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so1074139qee.9
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 12:46:11 -0800 (PST)
In-Reply-To: <527BBF8C.4060409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, joelf@ti.com, Gururaja Hebbar <gururaja.hebbar@ti.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Russ Dill <Russ.Dill@ti.com>

Hi Grygorii :)

On Thu, Nov 7, 2013 at 11:27 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 11/07/2013 05:34 PM, Nishanth Menon wrote:
>>
>> On 10/30/2013 03:21 PM, Daniel Mack wrote:
>> [...]
>>>
>>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
>>> index 8e1a024..f15cdb9 100644
>>> --- a/arch/arm/common/edma.c
>>> +++ b/arch/arm/common/edma.c
>>
>>
>> [...]
>>
>>> +static int edma_pm_suspend(struct device *dev)
>>> +{
>>> +       int j;
>>> +
>>> +       pm_runtime_get_sync(dev);
>>> +
>>
>> error checks?
>>>
>>> +       for (j = 0; j < arch_num_cc; j++) {
>>> +               struct edma *ecc = edma_cc[j];
>>> +
>>> +               disable_irq(ecc->irq_res_start);
>>> +               disable_irq(ecc->irq_res_end);
>>> +       }
>>> +
>>> +       pm_runtime_put_sync(dev);
>
>
> Also, it make no sense to call pm_runtime_putXXX() in suspend handlers
> - it will not work because PM core calls pm_runtime_get_noresume()
> from device_prepare().
>
> Now, for OMAP the edma Device will be finally disabled by OMAP device core
> at suspend_noirq stage (if it's connected to HW_mode).
> But, in other cases it need to be handled somehow :)
>

This PM stuff just gets more interesting ;)
