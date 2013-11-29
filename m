From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 01/12 diet] ARM: OMAP2+: Remove legacy omap3 board-*.c
 files and make mach-omap2 DT only for booting
Date: Fri, 29 Nov 2013 10:00:38 +0100
Message-ID: <CABxcv==5X91DTnUCOjZTpjKCVQzHquvL7o4+q0DsJ=LM80DORQ@mail.gmail.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
	<20131126011744.GA26766@atomide.com>
	<CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:40552 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3K2JAk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 04:00:40 -0500
Received: by mail-we0-f176.google.com with SMTP id w62so3387488wes.35
        for <linux-omap@vger.kernel.org>; Fri, 29 Nov 2013 01:00:38 -0800 (PST)
In-Reply-To: <CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Grazvydas,

On Fri, Nov 29, 2013 at 12:57 AM, Grazvydas Ignotas <notasas@gmail.com>=
 wrote:
> On Tue, Nov 26, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> We can now boot all mach-omap2 related boards using appended device
>> tree by creating a related .dts file with pretty much the same
>> functionality as booted in the legacy platform data mode.
>
> Not really the same, quite some drivers are still missing, and it
> makes pandora unusable :( . For example, SDIO variation of wl1251,
> that one is non-probeable and used to be "detected" by using
> MMC_QUIRK_NONSTD_SDIO quirk (see pandora_wl1251_init_card() in
> board-omap3pandora.c). Also there are at least pandora-backlight,
> twl4030_keypad and panel drivers that are not converted yet.
>
> Can pdata-quirks.c be used for SDIO wl1251 at least, as I have no ide=
a
> how to express it using device tree?
>

Yes, pdata-quirks.c can be used to initialize any platform device that
does not have DT support yet and still needs platform data. Until we
add the proper bindings and get rid of it.

> --
> Gra=C5=BEvydas
> --

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
