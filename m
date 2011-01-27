From: Silesh C V <saileshcv@gmail.com>
Subject: mux init with multiple signal paths.
Date: Thu, 27 Jan 2011 10:57:14 +0900
Message-ID: <AANLkTim4hVxEsH3ZkwtEhrhQJ6TP==M5cFZra+oxzrh0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59695 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab1A0B5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 20:57:15 -0500
Received: by iwn9 with SMTP id 9so1506795iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 17:57:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

What is the best way to mux signals which are available on multiple pins ?
For example on omap4, gpio 103 can be muxed on

1.gpmc_ncs6.
2.sdmmc_dat1.

omap_mux_init_gpio and omap_mux_init_signal on these pins will now
return with -EINVAL without modifying the mux register and the pin
will be left in the state in which the x-loader/u-boot left it at. So
is it true that the mux framework does not support muxing pins which
have multiple paths and they have to muxed by accessing the registers
directly ? Or am I missing something ?

Thanks for your time,
Silesh.
