From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] arm: configs: omap2plus_defconfig: enable USB bits which work
Date: Tue, 28 May 2013 11:18:13 -0700
Message-ID: <87hahnc6je.fsf@linaro.org>
References: <1368494600-18953-1-git-send-email-balbi@ti.com>
	<87ip2ly7p7.fsf@linaro.org> <519C7EB3.2040801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46462 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964914Ab3E1SSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 May 2013 14:18:17 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so8215360pab.7
        for <linux-omap@vger.kernel.org>; Tue, 28 May 2013 11:18:16 -0700 (PDT)
In-Reply-To: <519C7EB3.2040801@ti.com> (Roger Quadros's message of "Wed, 22
	May 2013 11:15:47 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, kevin.hilman@linaro.org, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Roger Quadros <rogerq@ti.com> writes:

> On 05/14/2013 05:09 PM, Kevin Hilman wrote:

[...]

>>> @@ -206,10 +207,18 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>>>  CONFIG_USB_DEVICEFS=y
>>>  CONFIG_USB_SUSPEND=y
>>>  CONFIG_USB_MON=y
>>> +CONFIG_USB_EHCI_HCD=y
>> 
>> NAK (on this particular change)
>> 
>> This cannot be enable by default yet as EHCI *still* breaks core
>> retention[1] (which has been broken since at least v3.5, almost a year
>> now.)
>
> True. Due to broken smart idle/wakeup, EHCI host has to rely on
> IO Daisy chaining mechanism for remote wakeup.
>
> So this can't be fixed till we have daisy chaining working with device tree
> boot. 

... and is anyone working on that?

Kevin
