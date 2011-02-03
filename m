From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 17:12:56 +0530
Message-ID: <AANLkTi=dkNkqtBiUm-BJKw+RS2wFZ_mTSc9PFW+MrP05@mail.gmail.com>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
	<20110203095845.GK23561@legolas.emea.dhcp.ti.com>
	<20110203100528.GA6508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34087 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751135Ab1BCLm6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 06:42:58 -0500
In-Reply-To: <20110203100528.GA6508@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, dmitry.torokhov@gmail.com, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Thu, Feb 3, 2011 at 3:40 PM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
> On Thu, Feb 03, 2011 at 11:58:45AM +0200, Felipe Balbi wrote:
>> On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
>> > The ads7846 driver requests a gpio to detect pendown events,
>> > but does not configure its direction. Configure this gpio
>> > as an input after requesting it.
>> >
>> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> > ---
>> > changes between v2 and v1: Added return error support in v2.
>> >
>> > drivers/input/touchscreen/ads7846.c | =A0 =A07 +++++++
>> > 1 files changed, 7 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/t=
ouchscreen/ads7846.c
>> > index 036f245..f30768b 100644
>> > --- a/drivers/input/touchscreen/ads7846.c
>> > +++ b/drivers/input/touchscreen/ads7846.c
>> > @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(st=
ruct spi_device *spi, struct ads784
>> > =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> > =A0 =A0 }
>> >
>> > + =A0 err =3D gpio_direction_input(pdata->gpio_pendown);
>> > + =A0 if (err) {
>> > + =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "failed to configure pend=
own GPIO input direction %d\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_pendown);
>> > + =A0 =A0 =A0 =A0 =A0 return err;
>>
>> and now you miss a gpio_free().
>
> Better use gpio_request_one()?

Totally agreed,using gpio_request_one seems to be the better option.
Will post a patch for it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
