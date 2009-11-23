From: TAO HU <tghk48@motorola.com>
Subject: Re: DSS2 panel question
Date: Tue, 24 Nov 2009 01:41:27 +0800
Message-ID: <5f4a33680911230941l468730f1k51cc26e2d6431b0c@mail.gmail.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
	 <1258974287.2438.76.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:40878 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZKWRlX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 12:41:23 -0500
Received: from il06vts03.mot.com (il06vts03.mot.com [129.188.137.143])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id nANHfp90007670
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 10:41:51 -0700 (MST)
Received: from mail-pw0-f52.google.com (mail-pw0-f52.google.com [209.85.160.52])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id nANHfpbp007660
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 10:41:51 -0700 (MST)
Received: by pwj9 with SMTP id 9so4168326pwj.31
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 09:41:27 -0800 (PST)
In-Reply-To: <1258974287.2438.76.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Hi,

One idea as below

struct spi_dss_device {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct omap_dss_device dss_dev;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct spi_dss_dev_priv=A0 * spi_d=
ata;
} spi_dss_dev;


spi_dss_probe.c

spi_probe(spi_device * spi)
{
=A0=A0=A0 spi_dss_dev. spi_data =3D spi;
=A0=A0=A0 omap_dss_register_device((spi_ device *) &spi_dss_dev);

 }

 spi_dss_drv.c
 spi_dss_drv_probe(omap_dss_device * dev)
 {
 =A0=A0=A0=A0=A0=A0 my_spi_dss_dev =3D container_of(dev, struct spi_dss=
_device, dss_dev);
 =A0=A0=A0=A0=A0=A0 spi_data =3D my_spi_dss_dev;
 }

- Hu Tao

On Mon, Nov 23, 2009 at 7:04 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
>
> On Sat, 2009-11-21 at 16:16 +0100, ext Grazvydas Ignotas wrote:
> > Hello,
> >
> > I've been updating Pandora's panel for upstream-going DSS2, which n=
ow
> > uses device/device_driver model for panels. The thing is that the
> > panel we use is SPI controlled, so it needs to be set up as
> > spi_driver. From SPI probe function I can do
> > omap_dss_register_driver(), but how do I pass SPI data to
> > omap_dss_device cleanly? Surely some globals would help, but this i=
s
> > not a "clean" way I guess. There used to be panel-n800.c with simil=
ar
> > requirements, but it's not yet converted, right? Do you have any id=
eas
> > how this can be done?
>
> I don't have any good answer for this. For N900's panel there was a
> static global variable, if I remember right. Not very clean, as you
> said.
>
> =A0Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
