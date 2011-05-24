From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH V4] OMAP3+: SR Layer Cleanup
Date: Tue, 24 May 2011 13:52:37 +0200
Message-ID: <4DDB9C05.4090705@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>	<4DD67155.1030705@ti.com> <BANLkTi=ufSmtnEkyRFKOpbTAJkcUW1dXYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58237 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab1EXLwm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 07:52:42 -0400
In-Reply-To: <BANLkTi=ufSmtnEkyRFKOpbTAJkcUW1dXYg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

On 5/23/2011 6:40 AM, Gulati, Shweta wrote:
> Benoit,
>
> On Fri, May 20, 2011 at 7:19 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Shweta,
>>
>> On 5/13/2011 8:27 AM, Gulati, Shweta wrote:
>>>
>>> To set sr ntarget values  for all volt_domain,
>>> volt_table is retrieved by doing a look_up of 'vdd_name'
>>> field from omap_hwmod but voltage domain pointer does not
>>> belong to omap_hwmod and is not used anywhere else.
>>> As a part of voltage layer and SR Layer clean up volt
>>> pointer is removed from omap_hwmod and added in dev
>>> attributes of SR.
>>>
>>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>>
>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>> Acked by: Nishanth Menon<nm@ti.com>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> ---
>>>
>>> V4:
>>>    Fixed comments like checking for NULL pointers
>>>    and following conventions in naming the instances
>>>    recommended by Todd Poynor and Benoit Cousson.
>>
>> It looks like you missed at least two comments I did on the previous version
>> whereas you did agree to fix them.
> You told me to move smartrefex_xxxx_dev_attr above
> omap44xx_smartreflex_XXX_hwmod struct,

Just before the struct which is not the case.

> which is already in that order and the other thing you suggested was
> to move .dev_attr before .slaves,
> that I have not done explaining that, to follow the standard as in all
> defined hwmod struct .dev_attr are placed after .slaves.

Could you give some example in the OMAP4 data file?

In the generic form, you should have opt_clk attribute then dev_attr 
then .slaves.

Anyway, do not say you will fix something if you decide not to fix them 
after. Or in case of valid concern, please provide some explanation in 
the cover letter.

Regards,
Benoit

