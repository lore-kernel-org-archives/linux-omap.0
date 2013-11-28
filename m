From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 01/12 diet] ARM: OMAP2+: Remove legacy omap3 board-*.c
 files and make mach-omap2 DT only for booting
Date: Fri, 29 Nov 2013 01:57:58 +0200
Message-ID: <CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
	<20131126011744.GA26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55110 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3K1X56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Nov 2013 18:57:58 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so9711891oag.16
        for <linux-omap@vger.kernel.org>; Thu, 28 Nov 2013 15:57:58 -0800 (PST)
In-Reply-To: <20131126011744.GA26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Nov 26, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> We can now boot all mach-omap2 related boards using appended device
> tree by creating a related .dts file with pretty much the same
> functionality as booted in the legacy platform data mode.

Not really the same, quite some drivers are still missing, and it
makes pandora unusable :( . For example, SDIO variation of wl1251,
that one is non-probeable and used to be "detected" by using
MMC_QUIRK_NONSTD_SDIO quirk (see pandora_wl1251_init_card() in
board-omap3pandora.c). Also there are at least pandora-backlight,
twl4030_keypad and panel drivers that are not converted yet.

Can pdata-quirks.c be used for SDIO wl1251 at least, as I have no idea
how to express it using device tree?

--
Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
