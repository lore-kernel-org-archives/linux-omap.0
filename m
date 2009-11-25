From: TAO HU <tghk48@motorola.com>
Subject: Re: DSS2 panel question
Date: Thu, 26 Nov 2009 01:44:31 +0800
Message-ID: <5f4a33680911250944t66ee6045wcf7f912d9f48f267@mail.gmail.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
	 <1258974287.2438.76.camel@tubuntu.research.nokia.com>
	 <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
	 <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:60736 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759397AbZKYRo1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 12:44:27 -0500
Received: from il06vts01.mot.com (il06vts01.mot.com [129.188.137.141])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id nAPHis2w005330
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 10:44:54 -0700 (MST)
Received: from mail-px0-f189.google.com (mail-px0-f189.google.com [209.85.216.189])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id nAPHdgjs004346
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 10:44:54 -0700 (MST)
Received: by mail-px0-f189.google.com with SMTP id 27so5620561pxi.25
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 09:44:31 -0800 (PST)
In-Reply-To: <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, TAO HU <taohu@motorola.com>

Hi, Grazvydas Ignotas

What did you mean "Hm, omap_dss_register_device() takes omap_dss_driver=
"?

Below is what I saw from the code
 int omap_dss_register_device(struct omap_dss_device *dssdev)

I assume the code I have is for DSS. Does DSS2 change the API?
BTW, what's the location for DSS2 code in linux-omap tree? Seems not
see it anywhere


- Hu Tao


On Wed, Nov 25, 2009 at 6:53 PM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> On Mon, Nov 23, 2009 at 7:41 PM, TAO HU <tghk48@motorola.com> wrote:
>> Hi,
>>
>> One idea as below
>>
>> struct spi_dss_device {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct omap_dss_device dss_dev;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct spi_dss_dev_priv=A0 * sp=
i_data;
>> } spi_dss_dev;
>
> Hm, omap_dss_register_device() takes omap_dss_driver, not
> omap_dss_device. Anyway that wouldn't work if there were 2 instances
> of same panel in one system I guess, as 2 different spi_data instance=
s
> would probe, when there is only one omap_dss_driver.
>
> Instead I'm thinking to link omap_dss_device with spi in board file
> itself by (ab)using platform_data:
>
> static struct omap_dss_device pandora_lcd_device =3D {
> ...
> };
>
> struct spi_board_info pandora_spi_board_info =3D {
> =A0.bus_num =3D 1,
> =A0...
> =A0.platform_data =3D pandora_lcd_device,
> };
>
> Then in panel driver:
>
> int spi_probe(struct spi_device *spi)
> {
> =A0struct omap_dss_device *dssdev =3D spi->dev.platform_data;
> =A0dev_set_drvdata(&dssdev->dev, spi);
> }
>
> static int lcd_probe(struct omap_dss_device *dssdev)
> {
> =A0struct spi_device *spi =3D dev_get_drvdata(&dssdev->dev);
> }
>
> Tomi, does that look reasonable to you?
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
