From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V3] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Wed, 18 Dec 2013 13:28:26 +0200
Message-ID: <CANOLnOOCZU-5Wtqt-T419CypwoSB_kpDuGtPvJfGmi0LjVpY3A@mail.gmail.com>
References: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
	<20131217172233.GA29638@psi-dev26.jf.intel.com>
	<52B1519A.4030503@andin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:38324 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab3LRL21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 06:28:27 -0500
In-Reply-To: <52B1519A.4030503@andin.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Naumann <dev@andin.de>
Cc: David Cohen <david.a.cohen@linux.intel.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 18, 2013 at 9:41 AM, Andreas Naumann <dev@andin.de> wrote:
> Am 17.12.2013 18:22, schrieb David Cohen:
>
>> On Tue, Dec 17, 2013 at 05:48:33PM +0100, anaumann@ultratronik.de wrote:
>>>
>>> From: Andreas Naumann <anaumann@ultratronik.de>
>>>
>>> This is a hard to reproduce problem which leads to non-functional
>>> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
>>> e25bec160158abe86c276d7d206264afc3646281, which introduces save/restore
>>> of OTG_INTERFSEL over suspend.
>>> Since the resume function is also called early in driver init, it uses a
>>> non-initialized value (which is 0 and a non-supported setting in DM37xx
>>> for INTERFSEL). Shortly after the correct value is set. Apparently this
>>> works most time, but not always.
>>>
>>> Fix it by not writing the value on runtime resume if it has not been
>>> initialized yet.
>>>
>>> Signed-off-by: Andreas Naumann <anaumann@ultratronik.de>
>>> ---
>>> Even though I find the implementation a bit awkward this should fix
>>> the issue without breaking anything else. Hope everyone is happy
>>> with this.
>>>
>>>   drivers/usb/musb/omap2430.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>>> index 4315d35..fbe2c08 100644
>>> --- a/drivers/usb/musb/omap2430.c
>>> +++ b/drivers/usb/musb/omap2430.c
>>> @@ -48,6 +48,7 @@ struct omap2430_glue {
>>>         enum omap_musb_vbus_id_status status;
>>>         struct work_struct      omap_musb_mailbox_work;
>>>         struct device           *control_otghs;
>>> +       u8      initialized;
>>>   };
>>>   #define glue_to_musb(g)               platform_get_drvdata(g->musb)
>>>
>>> @@ -383,6 +384,7 @@ static int omap2430_musb_init(struct musb *musb)
>>>         }
>>>
>>>         musb_writel(musb->mregs, OTG_INTERFSEL, l);
>>> +       glue->initialized = 1;
>>>
>>>         pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
>>>                         "sysstatus 0x%x, intrfsel 0x%x, simenable
>>> 0x%x\n",
>>> @@ -509,6 +511,7 @@ static int omap2430_probe(struct platform_device
>>> *pdev)
>>>         glue->dev                       = &pdev->dev;
>>>         glue->musb                      = musb;
>>>         glue->status                    = OMAP_MUSB_UNKNOWN;
>>> +       glue->initialized       = 0;
>>
>>
>> You don't need to do this. 'glue' was already allocated with kzalloc().
>
>
> ok
>
>
>>
>>>
>>>         if (np) {
>>>                 pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata),
>>> GFP_KERNEL);
>>> @@ -646,7 +649,8 @@ static int omap2430_runtime_resume(struct device
>>> *dev)
>>>
>>>         if (musb) {
>>>                 omap2430_low_level_init(musb);
>>> -               musb_writel(musb->mregs, OTG_INTERFSEL,
>>> +               if(glue->initialized)
>>
>>
>> Are you sure this is thread safe?
>> If you're sending this patch it means runtime_resume can be called
>> before omap2430_must_init(), but how about at the same time?

No, the problem is that omap2430_runtime_resume() is called _during_
omap2430_must_init(), when pm_runtime_get_sync() is called. We can't
read the initial register value before pm_runtime_get_sync() returns
because the hardware is not powered up, and from pm_runtime_get_sync()
omap2430_runtime_resume() is called, where the cached register value
is needed.

>> You defined 'initialized' as u8 type, then read/write operations won't
>> be atomic in ARM.

We would only have problems if runtime_suspend() and runtime_resume()
are called at the same time, can this really happed?

Grazvydas
