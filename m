From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 13/22] mfd: omap-usb-host: override number of ports
 from platform data
Date: Tue, 04 Dec 2012 16:32:03 +0400
Message-ID: <50BDED43.9050201@mvista.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-14-git-send-email-rogerq@ti.com> <50BB8C73.7060008@mvista.com> <50BCCC11.1030304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:65314 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab2LDMda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Dec 2012 07:33:30 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so3230067lag.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Dec 2012 04:33:29 -0800 (PST)
In-Reply-To: <50BCCC11.1030304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 03-12-2012 19:58, Roger Quadros wrote:

>> On 28-11-2012 18:49, Roger Quadros wrote:

>>> Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
>>> but they have different number of ports i.e. 2 and 3 respectively.
>>> So we can't rely on REVISION register for number of ports on OMAP5
>>> and depend on platform data (or device tree) instead.

>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> [...]

>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>>> index 87b574b..fda235a 100644
>>> --- a/drivers/mfd/omap-usb-host.c
>>> +++ b/drivers/mfd/omap-usb-host.c
>>> @@ -495,19 +495,27 @@ static int __devinit usbhs_omap_probe(struct
>>> platform_device *pdev)
>>>         */
>>>        pm_runtime_put_sync(dev);
>>>
>>> -    switch (omap->usbhs_rev) {
>>> -    case OMAP_USBHS_REV1:
>>> -        omap->nports = 3;
>>> -        break;
>>> -    case OMAP_USBHS_REV2:
>>> -        omap->nports = 2;
>>> -        break;
>>> -    default:
>>> -        omap->nports = OMAP3_HS_USB_PORTS;
>>> -        dev_dbg(dev,
>>> -          "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
>>> -           omap->usbhs_rev, omap->nports);
>>> -        break;
>>> +    /*
>>> +     * If platform data contains nports then use that
>>> +     * else make out number of ports from USBHS revision
>>> +     */
>>> +    if (pdata->nports) {
>>> +            omap->nports = pdata->nports;

>>     Overindented line?

> Sorry, I didn't get it. Did you mean extra tab/space?

    Extra tab, yes.

WBR, Sergei

