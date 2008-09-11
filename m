From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] Load triton2 scripts.
Date: Wed, 10 Sep 2008 20:20:29 -0700
Message-ID: <5e088bd90809102020m6eec5a1er4ee5850cb4ce0e72@mail.gmail.com>
References: <1219660277-27178-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
	 <20080911000843.GZ21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:37934 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYIKDUa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 23:20:30 -0400
Received: by yx-out-2324.google.com with SMTP id 8so61475yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 10 Sep 2008 20:20:29 -0700 (PDT)
In-Reply-To: <20080911000843.GZ21163@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, linux-omap@vger.kernel.org, ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

On Wed, Sep 10, 2008 at 5:08 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [080825 03:28]:
>> From: ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>>
>> This patch loads the triton2 (twl4030) with scripts that will cut off VDD1
>> and VDD2 voltages when SYS_OFF_MODE signal is set.
>
> Pushing today. I guess we should remove the CONFIG_DISABLE_HFCLK at
> some point?

This patch causes a build error due to a missing define:

|   CC      drivers/i2c/chips/twl4030-power.o
| drivers/i2c/chips/twl4030-power.c:152: error: 'RES_TYPE_R7'
undeclared here (not in a function)


Steve
