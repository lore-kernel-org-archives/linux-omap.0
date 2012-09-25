From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: query on [PATCH 2/3] usb: otg: add device tree support to otg library
Date: Tue, 25 Sep 2012 16:21:39 +0530
Message-ID: <CAAe_U6+axH=ZkQLiuAfkhvmNFjUVvXag=MewhsA1T3bYFLgfpg@mail.gmail.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E9E8319@DBDE01.ent.ti.com>
	<50617138.2040507@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:52830 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755029Ab2IYKvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 06:51:40 -0400
Received: by vcbfo13 with SMTP id fo13so7429489vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 03:51:39 -0700 (PDT)
In-Reply-To: <50617138.2040507@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Sep 25, 2012 at 2:24 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Hi Afzal,
>
> On 09/25/2012 10:47 AM, Mohammed, Afzal wrote:
>> This is a query regarding patch,
>> "usb: otg: add device tree support to otg library" [1]
>>
>> It seems there is so far no consensus on this change.
>
> After I have posted this patch, Kishon had posted a better solution [2].
> We discussed the patch, but he has not posted any updates since then.
>
>> Do you have ideas to proceed on this ? is there something
>> that I can help you to proceed on this ?
>
> I'm interested in to get these patches into the kernel soon. Kishon any
> news on this patch?
>
>> Something like this would be required for USB support
>> on beagle bone (AM335X), which has 2 phy's of same type.
>>
>> Or is the plan to use generic phy framework instead ?
>
> Yes, Kishon's patches look more generic than mine.
Will post the next version by this week.

Thanks
Kishon
