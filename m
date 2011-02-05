From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure pendown_gpio
Date: Sat, 5 Feb 2011 12:29:58 +0530
Message-ID: <AANLkTimQS_dNcaeTqqR=7vqFcGi-CtmH_ynrPyt4p1uK@mail.gmail.com>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
	<20110203165405.GB12802@core.coreip.homeip.net>
	<20110203171953.GA13997@core.coreip.homeip.net>
	<20110204133250.GB2070@m-desktop>
	<20110204140847.GA3178@pengutronix.de>
	<20110204141618.GE2070@m-desktop>
	<4D4C116D.4080408@compulab.co.il>
	<AANLkTi=23s6jxGFVM9vUr3XopgPnSyfie2Ywj-PcKHSF@mail.gmail.com>
	<4D4C1B83.3020000@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51185 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751056Ab1BEHAC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Feb 2011 02:00:02 -0500
In-Reply-To: <4D4C1B83.3020000@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, balbi@ti.com, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Fri, Feb 4, 2011 at 9:00 PM, Igor Grinberg <grinberg@compulab.co.il>=
 wrote:
>
>
> On 02/04/11 17:11, Poddar, Sourav wrote:
>
>> On Fri, Feb 4, 2011 at 8:17 PM, Igor Grinberg <grinberg@compulab.co.=
il> wrote:
>>>
>>> On 02/04/11 16:16, G, Manjunath Kondaiah wrote:
>>>
>>>> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
>>>>> On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah w=
rote:
>>>>>> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>>>>>>> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote=
:
>>>>>>>> On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
>>>>>>>>> The ads7846 driver requests a gpio but does not currently
>>>>>>>>> configure it explicitly as an input. Use gpio_request_one
>>>>>>>>> to request and configure it at one shot.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>>>>>>>> Cc: Dmitry Torokhov <dtor@mail.ru>
>>>>>>>> Will apply this one, the other one is a bit messy IMO, will ha=
ve to
>>>>>>>> think about it.
>>>>>>>>
>>>>>>> Something like below should do I think.
>>>>>> Patch looks good but it applies only on top of previous patch:
>>>>>> https://patchwork.kernel.org/patch/529941/
>>>>>>
>>>>>> Why to have two patches for this fix?
>>>>> http://www.spinics.net/lists/linux-omap/msg45167.html
>>>> My point here is:
>>>> 1. The first patch only replaces gpio_request with gpio_request_on=
e
>>>> 2. Rest of the things are handled in 2nd patch posted by dmitry
>>>>
>>>> What is harm in merging both the patches? I don't think it affects
>>>> readability.
>>> Because the changes introduced by the patches are from different na=
ture.
>>> As stated in the link above, one is a functional change (gpio setup=
 change)
>>> and second is fixing the imbalance in request - free calls.
>>> The impact is not readability, but bad bisect-ability.
>> =A0 Dmitry's patch fixes both the problems(request/free and directio=
n)
>> =A0 in a single patch itself.Now there is no need of merging any pat=
ches.
>> =A0 Just that Dmitry's patch need to be rebased over the top of HEAD=
=2E (Currently,
>> =A0 its on top of my patch series).
>
> Well, here you have missed the point of direction:
> ...
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request_one(pdata->gpio_pe=
ndown, GPIOF_DIR_IN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ads7846_pendown");
>
> ...
>
> - =A0 =A0 =A0 err =3D gpio_request_one(pdata->gpio_pendown, GPIOF_DIR=
_IN,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "ads7846_pendown");
> ...
>
>
> It does not deal with direction, but only with request - free balance=
=2E
> The gpio direction is fixed by your patch.
>

gpio_request_one is a different API which calls  gpio_direction_input
for configuring the direction.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
