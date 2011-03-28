From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Mon, 28 Mar 2011 10:15:52 -0500
Message-ID: <AANLkTimDCpHQ5yvYN+0mW7HyyovyXCdGOf8LPv5FapNh@mail.gmail.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
	<f12f050c3f7fe0b405fde475fcd62104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36303 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1C1PPy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 11:15:54 -0400
Received: by mail-ew0-f50.google.com with SMTP id 10so1315161ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 08:15:53 -0700 (PDT)
In-Reply-To: <f12f050c3f7fe0b405fde475fcd62104@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Sricharan R <r.sricharan@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

Hi,

On Mon, Mar 28, 2011 at 12:38 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> If an error occurs in the L3 on any other initiator than MPU,
>> the interrupt goes unhandled given that the 'base' register
>> was calculated with the initialized err_base value (which
>> coincidentally points to MPU) and not with the actual source
>> of the error.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> Patch looks good. Did you observe this with DSP initiator??

Yes, when loading a base image for the DSP, I got an: In-band Error
Error seen by IVA_SS  at address 0; after this fix.

I was planning to remove the duplicated "Error" print too.

> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, I'll add it in my next version when I make the changes
affecting only these lines.

Regards,

Omar
