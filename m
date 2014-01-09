From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 06/18] ARM: dts: omap3-overo: Enable MMC2
Date: Thu, 9 Jan 2014 17:43:17 -0300
Message-ID: <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
	<1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43860 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaAIUnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 15:43:21 -0500
Received: by mail-wi0-f179.google.com with SMTP id z2so4013105wiv.0
        for <linux-omap@vger.kernel.org>; Thu, 09 Jan 2014 12:43:17 -0800 (PST)
In-Reply-To: <1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[adding Enric Balletbo to cc]

Hello Florian,

On Thu, Jan 9, 2014 at 1:48 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> MMC2 is used by the on-board WiFi module populated on some boards
> (based on Marvell Libertas 8688 SDIO).
>
> Note: currently WiFi only works on cold boot, as the module is not
> properly reset (missing binding for the GPIO reset).
>

Have you looked at commit 0e9fd777 ("ARM: dts: omap3-igep: Add support
for LBEE1USJYC WiFi connected to SDIO") ?

If I remember correctly the LBEE1USJYC Wifi/BT combo module is
basically a Marvell Libertas 8688 Wlan and Enric got soft reset
working too by adding a GPIO property to the regulator for the reset
GPIO.

Hope it helps,
Javier
