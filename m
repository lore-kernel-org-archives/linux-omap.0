From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 18:31:24 +0530
Message-ID: <AANLkTi=m1o2Fsw1OvCmZWJxmok2KCtCZp3F4aM7KmPch@mail.gmail.com>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
	<20110203095845.GK23561@legolas.emea.dhcp.ti.com>
	<AANLkTi=J5dJ4N4_57fh0_HKmqfyo6C_tMs3BrnXHWQjq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49156 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756388Ab1BCNBZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 08:01:25 -0500
In-Reply-To: <AANLkTi=J5dJ4N4_57fh0_HKmqfyo6C_tMs3BrnXHWQjq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, linux-input@vger.kernel.org, balbi@ti.com

On Thu, Feb 3, 2011 at 3:34 PM, Varadarajan, Charulatha <charu@ti.com> =
wrote:
> Sourav,
>
> On Thu, Feb 3, 2011 at 15:28, Felipe Balbi <balbi@ti.com> wrote:
>> On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
>>> The ads7846 driver requests a gpio to detect pendown events,
>>> but does not configure its direction. Configure this gpio
>>> as an input after requesting it.
>>>
>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>> ---
>>> changes between v2 and v1: Added return error support in v2.
>>>
>>> drivers/input/touchscreen/ads7846.c | =A0 =A07 +++++++
>>> 1 files changed, 7 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/to=
uchscreen/ads7846.c
>>> index 036f245..f30768b 100644
>>> --- a/drivers/input/touchscreen/ads7846.c
>>> +++ b/drivers/input/touchscreen/ads7846.c
>>> @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(str=
uct spi_device *spi, struct ads784
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>> =A0 =A0 =A0 }
>>>
>>> + =A0 =A0 err =3D gpio_direction_input(pdata->gpio_pendown);
>>> + =A0 =A0 if (err) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "failed to configure p=
endown GPIO input direction %d\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_pendown);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> and now you miss a gpio_free().
>
> My question to your previous version is still unanswered.
> Would it be relevant to add gpio_set_debounce() for this
> gpio?
>
 I was also wondering that.I too think that just a request and then an
 configuring direction would do.But,I am not so sure about this one.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
