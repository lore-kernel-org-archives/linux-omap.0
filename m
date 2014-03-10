From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: tps65910: RTC: dts: enable irq
Date: Mon, 10 Mar 2014 14:58:08 +0100
Message-ID: <CAGm1_kt3PYXydJrQZ5--+j0TbqWUSWs+52zagsz1M=6t7rigqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:43504 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbaCJN63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 09:58:29 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so7338258pad.28
        for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2014 06:58:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: mpa@pengutronix.de, linux-omap@vger.kernel.org

I want to use tps65910 as RTC. On my board its IRQ pin is connected to
the GPMC_BE1N on am335x. How can I configure this in device tree
(kernel 3.14)? As far as I can see, it is not really covered in
Documentation/devicetree/bindings/mfd/tps65910.txt.

Regards,
Yegor
