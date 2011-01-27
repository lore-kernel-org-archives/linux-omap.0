From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: mux init with multiple signal paths.
Date: Thu, 27 Jan 2011 10:10:42 +0530
Message-ID: <c4a538857557cf1a8a969d99f3140580@mail.gmail.com>
References: <AANLkTim4hVxEsH3ZkwtEhrhQJ6TP==M5cFZra+oxzrh0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:37496 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752639Ab1A0El4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jan 2011 23:41:56 -0500
Received: by mail-wy0-f169.google.com with SMTP id 26so1816525wyj.0
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 20:41:55 -0800 (PST)
In-Reply-To: <AANLkTim4hVxEsH3ZkwtEhrhQJ6TP==M5cFZra+oxzrh0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silesh C V <saileshcv@gmail.com>, linux-omap@vger.kernel.org

Silesh C V wrote:
> Hi,
>
> What is the best way to mux signals which are available on
> multiple pins ?
> For example on omap4, gpio 103 can be muxed on
>
> 1.gpmc_ncs6.
> 2.sdmmc_dat1.
>

Specify the signal as pad.signal:
gpmc_ncs6.sdmmc_dat1

(where, pad is the signal name on mode0, and
signal is the signal name for the mode you are interested in).

> omap_mux_init_gpio and omap_mux_init_signal on these pins will now
> return with -EINVAL without modifying the mux register and the pin
> will be left in the state in which the x-loader/u-boot left it at. So
> is it true that the mux framework does not support muxing pins which
> have multiple paths and they have to muxed by accessing the registers
> directly ? Or am I missing something ?
>

The technique above works at least with omap_mux_init_signal.

I'm not so sure about omap_mux_init_gpio.

- Anand
