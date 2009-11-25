From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: DSS2 panel question
Date: Wed, 25 Nov 2009 22:24:05 +0200
Message-ID: <6ed0b2680911251224tb7bef3h6957106543aec283@mail.gmail.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
	 <1258974287.2438.76.camel@tubuntu.research.nokia.com>
	 <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
	 <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
	 <5f4a33680911250944t66ee6045wcf7f912d9f48f267@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:29285 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935016AbZKYUYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 15:24:00 -0500
Received: by ey-out-2122.google.com with SMTP id 4so39148eyf.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 12:24:05 -0800 (PST)
In-Reply-To: <5f4a33680911250944t66ee6045wcf7f912d9f48f267@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, TAO HU <taohu@motorola.com>

On Wed, Nov 25, 2009 at 7:44 PM, TAO HU <tghk48@motorola.com> wrote:
> Hi, Grazvydas Ignotas
>
> What did you mean "Hm, omap_dss_register_device() takes omap_dss_driv=
er"?

Whoops, I meant omap_dss_register_driver()

> Below is what I saw from the code
> =A0int omap_dss_register_device(struct omap_dss_device *dssdev)
>
> I assume the code I have is for DSS. Does DSS2 change the API?

I was referring to version that is being submitted to mainline, and
panel drivers in particular, like:
http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dblo=
b;f=3Ddrivers/video/omap2/displays/panel-generic.c;h=3Deb48d1afd8008437=
458bb3fe87e351b5ce785c42;hb=3DHEAD

> BTW, what's the location for DSS2 code in linux-omap tree? Seems not
> see it anywhere

Tony is probably waiting for it to reach mainline and fall from there.

>
> - Hu Tao
>
>
> On Wed, Nov 25, 2009 at 6:53 PM, Grazvydas Ignotas <notasas@gmail.com=
> wrote:
>> On Mon, Nov 23, 2009 at 7:41 PM, TAO HU <tghk48@motorola.com> wrote:
>>> Hi,
>>>
>>> One idea as below
>>>
>>> struct spi_dss_device {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct omap_dss_device dss_dev=
;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct spi_dss_dev_priv=A0 * s=
pi_data;
>>> } spi_dss_dev;
>>
>> Hm, omap_dss_register_device() takes omap_dss_driver, not
>> omap_dss_device. Anyway that wouldn't work if there were 2 instances
>> of same panel in one system I guess, as 2 different spi_data instanc=
es
>> would probe, when there is only one omap_dss_driver.
>>
>> Instead I'm thinking to link omap_dss_device with spi in board file
>> itself by (ab)using platform_data:
>>
>> static struct omap_dss_device pandora_lcd_device =3D {
>> ...
>> };
>>
>> struct spi_board_info pandora_spi_board_info =3D {
>> =A0.bus_num =3D 1,
>> =A0...
>> =A0.platform_data =3D pandora_lcd_device,
>> };
>>
>> Then in panel driver:
>>
>> int spi_probe(struct spi_device *spi)
>> {
>> =A0struct omap_dss_device *dssdev =3D spi->dev.platform_data;
>> =A0dev_set_drvdata(&dssdev->dev, spi);
>> }
>>
>> static int lcd_probe(struct omap_dss_device *dssdev)
>> {
>> =A0struct spi_device *spi =3D dev_get_drvdata(&dssdev->dev);
>> }
>>
>> Tomi, does that look reasonable to you?
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
