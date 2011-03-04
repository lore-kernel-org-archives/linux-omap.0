From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 2/4] OMAP3 I2C document why cpu type and not peripheral
 unit ID used to probe
Date: Fri, 04 Mar 2011 08:25:51 +0000
Message-ID: <4D70A20F.6070508@linaro.org>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135030.30648.14923.stgit@otae.warmcat.com> <4D700441.50206@ti.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55278 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1CDIZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 03:25:55 -0500
Received: by wwb22 with SMTP id 22so2413513wwb.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 00:25:54 -0800 (PST)
In-Reply-To: <4D700441.50206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>

On 03/03/2011 09:12 PM, Somebody in the thread at some point said:

Hi -

Thanks for your comments.

> The issue is that this revision field is not really documented in OMAP4
> TRM, so you should not rely on it. Moreover, as you already noticed, the
> revision number is not even accurate. OMAP3 and 4 are using a different
> programming model but this is not reflected in this field.

OK.

> Since that issue is quite common in many OMAP IPs, we introduced a SW
> field in hwmod_class that should reflect the change in IP programming
> model. For the moment it is a simple integer that we increment each time
> there is change in a programming model that will impact the driver.
>
> You can check how it was done for the timer for example:

Alright.  In I2C case the path is hwmod class -> platform data though 
since hwmod content directly is not used in the driver, but platform 
data is.

>> +
>> if (cpu_is_omap44xx())
>> dev->regs = (u8 *) omap4_reg_map;
>
> OK, this is not part of your patch, but any call to cpu_is are forbidden
> from the driver. As soon as you have the revision field from hwmod you
> can get rid of all that code.

Well, as you point out they are not forbidden enough since I was just 
working with what was already there.

However this hwmod scheme will cover it all AFAICS, so I will extend the 
patches to nuke all cpu_is... from the driver.

-Andy
