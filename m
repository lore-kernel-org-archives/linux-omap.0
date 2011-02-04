From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure
 pendown_gpio
Date: Fri, 04 Feb 2011 16:47:09 +0200
Message-ID: <4D4C116D.4080408@compulab.co.il>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com> <20110203165405.GB12802@core.coreip.homeip.net> <20110203171953.GA13997@core.coreip.homeip.net> <20110204133250.GB2070@m-desktop> <20110204140847.GA3178@pengutronix.de> <20110204141618.GE2070@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50051 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab1BDOr0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 09:47:26 -0500
In-Reply-To: <20110204141618.GE2070@m-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, balbi@ti.com, charu@ti.com, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com



On 02/04/11 16:16, G, Manjunath Kondaiah wrote:

> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
>> On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah wrote:
>>> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>>>> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
>>>>> On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
>>>>>> The ads7846 driver requests a gpio but does not currently
>>>>>> configure it explicitly as an input. Use gpio_request_one
>>>>>> to request and configure it at one shot.
>>>>>>
>>>>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>>>>> Cc: Dmitry Torokhov <dtor@mail.ru>
>>>>> Will apply this one, the other one is a bit messy IMO, will have to
>>>>> think about it.
>>>>>
>>>> Something like below should do I think.
>>> Patch looks good but it applies only on top of previous patch:
>>> https://patchwork.kernel.org/patch/529941/
>>>
>>> Why to have two patches for this fix?
>> http://www.spinics.net/lists/linux-omap/msg45167.html
> My point here is: 
> 1. The first patch only replaces gpio_request with gpio_request_one
> 2. Rest of the things are handled in 2nd patch posted by dmitry
>
> What is harm in merging both the patches? I don't think it affects
> readability.

Because the changes introduced by the patches are from different nature.
As stated in the link above, one is a functional change (gpio setup change)
and second is fixing the imbalance in request - free calls.
The impact is not readability, but bad bisect-ability.


-- 
Regards,
Igor.

