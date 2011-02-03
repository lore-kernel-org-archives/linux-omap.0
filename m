From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in
 bootup
Date: Thu, 03 Feb 2011 13:12:32 +0200
Message-ID: <4D4A8DA0.1010806@compulab.co.il>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>	<4D4A7F13.8080502@compulab.co.il>	<4D4A80D3.2060407@compulab.co.il> <AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:39937 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756200Ab1BCLMi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 06:12:38 -0500
In-Reply-To: <AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: dmitry.torokhov@gmail.com, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com



On 02/03/11 13:00, Poddar, Sourav wrote:

> On Thu, Feb 3, 2011 at 3:47 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> if (pdata->get_pendown_state) {
>>        ts->get_pendown_state = pdata->get_pendown_state;
>>        ts->gpio_pendown = -1;
>>        return 0;
>> }
> Yes we can do so .I initialise it at a place where other variables
>  where initialised.
>
>>> Also, why don't we use -EINVAL for the invalid gpio number instead of -1 constant?
>>>
>  I used -1 because conditional check done in probe ads7846_probe function
>  used this value.
>
>   err_free_gpio:
>         if (ts->gpio_pendown != -1)
>                 gpio_free(ts->gpio_pendown);
>

Well I understand that and that's why in my proposal I used -1 also, but
I thought we can make it even better if we switch to -EINVAL
(though wanted to check if there are any reasonable objections)
and while you are at this, may be you are willing also to submit a patch for this?

-- 
Regards,
Igor.

