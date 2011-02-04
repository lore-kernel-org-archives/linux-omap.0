From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
 pendown_gpio
Date: Fri, 04 Feb 2011 17:37:29 +0200
Message-ID: <4D4C1D39.5080208@compulab.co.il>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com> <20110203165405.GB12802@core.coreip.homeip.net> <20110203171953.GA13997@core.coreip.homeip.net> <20110204133250.GB2070@m-desktop> <20110204140847.GA3178@pengutronix.de> <20110204141618.GE2070@m-desktop> <4D4C116D.4080408@compulab.co.il> <20110204151532.GF2070@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50399 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab1BDPho (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 10:37:44 -0500
In-Reply-To: <20110204151532.GF2070@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, balbi@ti.com, charu@ti.com, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

Hi,

On 02/04/11 17:15, G, Manjunath Kondaiah wrote:

> On Fri, Feb 04, 2011 at 04:47:09PM +0200, Igor Grinberg wrote:
>> On 02/04/11 16:16, G, Manjunath Kondaiah wrote:
>>> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
>>>> On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah wrote:
>>>>> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>>>>>> Something like below should do I think.
>>>>> Patch looks good but it applies only on top of previous patch:
>>>>> https://patchwork.kernel.org/patch/529941/
>>>>>
>>>>> Why to have two patches for this fix?
>>>> http://www.spinics.net/lists/linux-omap/msg45167.html
>>> My point here is: 
>>> 1. The first patch only replaces gpio_request with gpio_request_one
>>> 2. Rest of the things are handled in 2nd patch posted by dmitry
>>>
>>> What is harm in merging both the patches? I don't think it affects
>>> readability.
>> Because the changes introduced by the patches are from different nature.
>> As stated in the link above, one is a functional change (gpio setup change)
>> and second is fixing the imbalance in request - free calls.
>> The impact is not readability, but bad bisect-ability.
> ok. But the patch2(dmitry's patch) is doing more than what it is mentioned in
> patch description. It checks for validity of gpio, comment correction
> etc which needs to be updated in the patch description.

gpio validity is a part of request - free balance fix, comment change is
just a coding style fix - really minor.

Personally, I think Dmitry's description of the patch is just fine,
but if you insist on making it somehow better, then suggest it to Dmitry.


-- 
Regards,
Igor.

