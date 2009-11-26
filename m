From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 panel question
Date: Thu, 26 Nov 2009 12:05:07 +0200
Message-ID: <1259229907.2438.247.camel@tubuntu.research.nokia.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
	 <1258974287.2438.76.camel@tubuntu.research.nokia.com>
	 <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
	 <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49555 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbZKZKFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 05:05:19 -0500
In-Reply-To: <6ed0b2680911250253h6a07fd41xeee6ca8fcb29f577@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, TAO HU <tghk48@motorola.com>

On Wed, 2009-11-25 at 11:53 +0100, ext Grazvydas Ignotas wrote:
> On Mon, Nov 23, 2009 at 7:41 PM, TAO HU <tghk48@motorola.com> wrote:
> > Hi,
> >
> > One idea as below
> >
> > struct spi_dss_device {
> >              struct omap_dss_device dss_dev;
> >              struct spi_dss_dev_priv  * spi_data;
> > } spi_dss_dev;
> 
> Hm, omap_dss_register_device() takes omap_dss_driver, not
> omap_dss_device. Anyway that wouldn't work if there were 2 instances
> of same panel in one system I guess, as 2 different spi_data instances
> would probe, when there is only one omap_dss_driver.
> 
> Instead I'm thinking to link omap_dss_device with spi in board file
> itself by (ab)using platform_data:
> 
> static struct omap_dss_device pandora_lcd_device = {
> ...
> };
> 
> struct spi_board_info pandora_spi_board_info = {
>   .bus_num = 1,
>   ...
>   .platform_data = pandora_lcd_device,
> };
> 
> Then in panel driver:
> 
> int spi_probe(struct spi_device *spi)
> {
>   struct omap_dss_device *dssdev = spi->dev.platform_data;
>   dev_set_drvdata(&dssdev->dev, spi);
> }
> 
> static int lcd_probe(struct omap_dss_device *dssdev)
> {
>   struct spi_device *spi = dev_get_drvdata(&dssdev->dev);
> }
> 
> Tomi, does that look reasonable to you?

Yes, the linking has to be done inside the board file somehow. I need to
try this at some point with N900's panel driver, but I think it looks
good.

I think you could also link it other way around, store the
spi_board_info inside the dss_device, but I don't immediately see that
this way is better than the other.

 Tomi


