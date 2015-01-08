From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable misc options for
 BeagleBoard-X15 platform
Date: Thu, 8 Jan 2015 15:49:11 -0600
Message-ID: <CAGo_u6p-6EuZR8JC2Z=o1t9EgXKQnH6R9mYrfLxrsD7sYXdAxg@mail.gmail.com>
References: <1420751680-21230-1-git-send-email-nm@ti.com>
	<20150108212538.GU31926@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51215 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbbAHVtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 16:49:12 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so11940144iec.2
        for <linux-omap@vger.kernel.org>; Thu, 08 Jan 2015 13:49:11 -0800 (PST)
In-Reply-To: <20150108212538.GU31926@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 8, 2015 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Jan 08, 2015 at 03:14:40PM -0600, Nishanth Menon wrote:
>> @@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=y
>>  CONFIG_DEBUG_GPIO=y
>>  CONFIG_GPIO_SYSFS=y
>>  CONFIG_GPIO_TWL4030=y
>> +CONFIG_GPIO_PALMAS=y
>
> other than the power button, do you have anything else attached to a
> palmas GPIO ? We might not need this for boot.
we dont, but setting it to 'm'
"warning: symbol value 'm' invalid for GPIO_PALMAS"

Regards,
Nishanth Menon
