From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: DSS2 panel question
Date: Wed, 25 Nov 2009 12:53:49 +0200
Message-ID: <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
	 <1258974287.2438.76.camel@tubuntu.research.nokia.com>
	 <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62851 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933784AbZKYKxo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 05:53:44 -0500
Received: by ewy19 with SMTP id 19so242119ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 02:53:49 -0800 (PST)
In-Reply-To: <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, TAO HU <tghk48@motorola.com>

On Mon, Nov 23, 2009 at 7:41 PM, TAO HU <tghk48@motorola.com> wrote:
> Hi,
>
> One idea as below
>
> struct spi_dss_device {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct omap_dss_device dss_dev;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct spi_dss_dev_priv=A0 * spi=
_data;
> } spi_dss_dev;

Hm, omap_dss_register_device() takes omap_dss_driver, not
omap_dss_device. Anyway that wouldn't work if there were 2 instances
of same panel in one system I guess, as 2 different spi_data instances
would probe, when there is only one omap_dss_driver.

Instead I'm thinking to link omap_dss_device with spi in board file
itself by (ab)using platform_data:

static struct omap_dss_device pandora_lcd_device =3D {
=2E..
};

struct spi_board_info pandora_spi_board_info =3D {
  .bus_num =3D 1,
  ...
  .platform_data =3D pandora_lcd_device,
};

Then in panel driver:

int spi_probe(struct spi_device *spi)
{
  struct omap_dss_device *dssdev =3D spi->dev.platform_data;
  dev_set_drvdata(&dssdev->dev, spi);
}

static int lcd_probe(struct omap_dss_device *dssdev)
{
  struct spi_device *spi =3D dev_get_drvdata(&dssdev->dev);
}

Tomi, does that look reasonable to you?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
