From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
Date: Fri, 14 Sep 2012 15:29:57 +0000
Message-ID: <201209141529.57295.arnd@arndb.de>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com> <201209141028.38185.arnd@arndb.de> <331ABD5ECB02734CA317220B2BBEABC13EA2F2B1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64407 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab2INPaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 11:30:09 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2F2B1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, Daniel Mack <zonque@gmail.com>

On Friday 14 September 2012, AnilKumar, Chimata wrote:
> Small question here, in my v2 version I have specified both
> the compatible names lis3lv02d and lis331dlh is it fine or
> only one is sufficient?
> 
> +static struct of_device_id lis3lv02d_i2c_dt_ids[] = {
> +       { .compatible = "st,lis3lv02d" },
> +       { .compatible = "st,lis331dlh" },
> +       {}
> +};
> 

That's ok. In most cases, people will need the data field to point to a
data structure with the differences between two chips, but not if they are
identical from the software side.
It's also fine if you just list one entry here and put both values as
"compatible" in the device tree, to signify that the device is backwards
compatible with the older variant.

	Arnd
