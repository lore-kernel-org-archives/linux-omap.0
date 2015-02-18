From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v3 0/6] Convert twl4030_madc_battery to IIO consumer and
 add DT aupport
Date: Wed, 18 Feb 2015 08:46:34 +0100
Message-ID: <CAAfyv36i0e4h7LTeuzxJFjFG9uXqUn+Gi2kmBtmHoo=f_Gj3Fg@mail.gmail.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47887 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbBRHqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2015 02:46:36 -0500
In-Reply-To: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, GTA04 owners <gta04-owner@goldelico.com>, Marek Belisko <marek@goldelico.com>

Ping.

On Wed, Feb 4, 2015 at 11:14 PM, Marek Belisko <marek@goldelico.com> wrote:
> This patches adding support for twl4030_madc_battery to use twl4030_madc iio framework + DT support.
> Patches was tested on gta04 board. twl4030_madc_battery driver is converted in
> first patch to iio consumer and in next patches is added support for devicetree
> + some small fixes for module autoloading.
>
> Changes from V2:
> - fix property names
> - add MODULE_DEVICE_TABLE and MODULE_ALIAS
>
> Changes from V1:
> - use iio_read_channel_processed instead iio_read_channel_processed
> - convert probe to use devm_ as part of adding error handling for iio
> - free iio channels on error and on module removal
>
> [1] - https://lkml.org/lkml/2014/2/26/482dd
>
> Marek Belisko (6):
>   power: twl4030-madc-battery: Convert to iio consumer.
>   power: twl4030_madc_battery: Add device tree support
>   Documentation: DT: Document twl4030-madc-battery bindings
>   ARM: dts: omap3-gta04: Add battery support
>   power: twl4030_madc_battery: Add of_twl4030_madc_match to
>     MODULE_DEVICE_TABLE
>   power: twl4030_madc_battery: Add missing MODULE_ALIAS
>
>  .../bindings/power_supply/twl4030_madc_battery.txt |  43 +++++
>  arch/arm/boot/dts/omap3-gta04.dtsi                 |  30 ++++
>  drivers/power/twl4030_madc_battery.c               | 183 +++++++++++++++++----
>  3 files changed, 221 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>
> --
> 1.9.1
>



-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
