From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V2] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Fri, 29 Nov 2013 13:57:33 +0200
Message-ID: <CANOLnON07VLQ-xrB7qLuk1yCJiOESH_NbfSAozWnE4gjEK93sQ@mail.gmail.com>
References: <EE4E4767751A8B40949306E403F4DDD80322D479@sv03ultra002.ultratronik.de>
	<529851AE.7090300@andin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44771 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab3K2L5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 06:57:34 -0500
Received: by mail-ob0-f182.google.com with SMTP id wp4so9999630obc.13
        for <linux-omap@vger.kernel.org>; Fri, 29 Nov 2013 03:57:33 -0800 (PST)
In-Reply-To: <529851AE.7090300@andin.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Naumann <dev@andin.de>
Cc: Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 29, 2013 at 10:34 AM, Andreas Naumann <dev@andin.de> wrote:
>> Nice find, I think I'm also affected by this. However this crashes on
>> OMAP3530 pandora because you now access INTERFSEL before interface
>> clock is enabled.. This is not a problem on DM37xx because it uses
>> different interconnects. You should probably use "context_valid"
>> variable in omap2430_glue or similar to decide to write to register or
>> not.
>>
>> Grazvydas
>
>
> You mean introducing a "context_value"? I'm not sure if i want to add more
> code.

What I meant is to have a flag that would be set after
omap2430_runtime_suspend() is called, and only write to INTERFSEL in
omap2430_runtime_resume() if that flag is set.

Drivers like drivers/tty/serial/omap-serial.c or
drivers/gpio/gpio-omap.c use get_context_loss_count() callbacks for
this, but it looks unnecessarily complicated.. Maybe Felipe has some
ideas on this?

> Do you think simple removing the first read is an option? So far we read
> back 0 anyway because the first write to INTERFSEL in resume() set it to
> uninitialized / 0 anyway.

It should be fine but I don't know if all OMAPs only have PHY
interface bits, there could be some that have some more bits there..
Yes current code is broken and writes 0 anyway, so any solution is
better, but ideally it should read-modify-write the register and only
change PHYSEL bits at probe.
