From: Eliad Peller <eliad@wizery.com>
Subject: Re: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
Date: Sun, 15 Mar 2015 10:50:42 +0200
Message-ID: <CAB3XZEdFMQexA69JEuw=VnqsNOEkWAM0+oWWmt6DaN9+hZ+vdw@mail.gmail.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
	<1426162154-8716-7-git-send-email-eliad@wizery.com>
	<20150313151301.GJ5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34912 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbCOIun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2015 04:50:43 -0400
In-Reply-To: <20150313151301.GJ5264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Luciano Coelho <luca@coelho.fi>

On Fri, Mar 13, 2015 at 5:13 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Eliad Peller <eliad@wizery.com> [150312 05:10]:
>> Now that we have wlcore device-tree bindings in place
>> (for both wl12xx and wl18xx), remove the legacy
>> wl12xx_platform_data struct, and move its members
>> into the platform device data (that is passed to wlcore)
>>
>> Davinci 850 is the only platform that still set
>> the platform data in the legacy way (and doesn't
>> have DT bindings), so remove the relevant
>> code/Kconfig option from the board file (as suggested
>> by Sekhar Nori)
>>
>> Signed-off-by: Luciano Coelho <luca@coelho.fi>
>> Signed-off-by: Eliad Peller <eliad@wizery.com>
>> ---
>>  arch/arm/mach-davinci/Kconfig                  |  11 ---
>>  arch/arm/mach-davinci/board-da850-evm.c        | 113 --------------=
-----------
>>  drivers/net/wireless/ti/wilink_platform_data.c |  25 ------
>>  drivers/net/wireless/ti/wl12xx/main.c          |  19 ++---
>>  drivers/net/wireless/ti/wlcore/boot.c          |   1 -
>>  drivers/net/wireless/ti/wlcore/main.c          |   4 +-
>>  drivers/net/wireless/ti/wlcore/sdio.c          |  75 +++++---------=
--
>>  drivers/net/wireless/ti/wlcore/wlcore_i.h      |   8 +-
>>  include/linux/wl12xx.h                         |  25 ------
>>  9 files changed, 36 insertions(+), 245 deletions(-)
>
> I got a build error related to the SPI driver with this series, proba=
bly
> need to update this patch:
>
> drivers/net/wireless/ti/wlcore/spi.c: In function =E2=80=98wl1271_pro=
be=E2=80=99:
> drivers/net/wireless/ti/wlcore/spi.c:334:11: error: =E2=80=98struct w=
lcore_platdev_data=E2=80=99 has no member named =E2=80=98pdata=E2=80=99
>   pdev_data.pdata =3D dev_get_platdata(&spi->dev);
>            ^
> drivers/net/wireless/ti/wlcore/spi.c:335:16: error: =E2=80=98struct w=
lcore_platdev_data=E2=80=99 has no member named =E2=80=98pdata=E2=80=99
>   if (!pdev_data.pdata) {
>
yeah, i missed it :/

looks like there's no platform that defines platform data for it.
i'll replace the dev_get_platdata() with a function that only parses
the clock-frequency properties (the irq is taken in this case from the
spi_device).
(or maybe i should just drop it, as no one actually uses it?)

thanks,
Eliad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
