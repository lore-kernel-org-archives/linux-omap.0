From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v3 0/7] ARM: OMAP2+: AM33XX: Enable few drivers in
 omap2plus_defconfig
Date: Thu, 3 Jan 2013 07:54:38 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAD6FD3@DBDE01.ent.ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
 <CAOesGMj0yO5JxkDAeN1negip5dvwX9Y3syoU4JPsKnVJ0GucdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41301 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326Ab3ACHyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 02:54:46 -0500
In-Reply-To: <CAOesGMj0yO5JxkDAeN1negip5dvwX9Y3syoU4JPsKnVJ0GucdQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 03, 2013 at 01:49:57, Olof Johansson wrote:
> Hi,
> 
> On Wed, Jan 2, 2013 at 2:27 AM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > This patch series enable tps65910, lis3lv02d accelerometer, tsl2550
> > ambient light sensor, matrix keypad, tmp275 temperature sensor, gpio
> > leds and D_CAN drivers in omap2plus_defconfig.
> >
> > These are the peripherals present in AM33XX family of devices.
> >
> > Changes from v2:
> >         - Incorporated Tony's comments on v2
> >           * Enabled as modules instead of kernel built-in drivers.
> >         - Dropped 1st patch because it was accepted.
> >
> > Changes from v1:
> >         - Incorporated martinez javier's comments on v1
> >           * Enabled few more triggers in omap2plus_defconfig
> >         - Included Igor's patch, which modifies the omap2plus
> >           defconfig for AM33XX devices.
> >
> > AnilKumar Ch (7):
> >   ARM: OMAP2+: omap2plus_defconfig: Add tps65910 support
> >   ARM: OMAP2+: omap2plus_defconfig: Add lis3lv02d support
> >   ARM: OMAP2+: omap2plus_defconfig: Add tsl2550 support
> >   ARM: OMAP2+: omap2plus_defconfig: Add matrix-keypad support
> >   ARM: OMAP2+: omap2plus_defconfig: Add tmp275 sensor support
> >   ARM: OMAP2+: omap2plus_defconfig: Add leds-gpio support
> >   ARM: OMAP2+: omap2plus_defconfig: Add D_CAN support
> 
> Doing this as 7 separate patches seems excessive to me. Just do it as
> one single patch instead.
> 

Hi Olof,

I will send v4 by merging all the patches into single patch.

Thanks
AnilKumar
