From: Joachim Eastwood <manabian@gmail.com>
Subject: OMAP DSS: panel-dpi and enable gpios
Date: Mon, 12 May 2014 19:58:47 +0200
Message-ID: <CAGhQ9VxDQaRzjCMm1RfxVmPt7Nk14ZTeS0-BmBfFDcxQNy__Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:61593 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaELR6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 13:58:48 -0400
Received: by mail-ve0-f177.google.com with SMTP id db11so9122755veb.8
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 10:58:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hello Tomi,

There seems to be a mismatch between your panel-dpi code and DT docs.

The docs state that enable-gpios is optinal but in panel-dpi.c you
have the following code
gpio = devm_gpiod_get(&pdev->dev, "enable");
if (IS_ERR(gpio)) {
    dev_err(&pdev->dev, "failed to parse enable gpio\n");
    return PTR_ERR(gpio);
} else {
    gpiod_direction_output(gpio, 0);
    ddata->enable_gpio = gpio;
}

Making probing fail on my DT since I don't use enable-gpios with
[ 0.976989] panel-dpi display.12: failed to parse enable gpio
[ 0.977050] panel-dpi: probe of display.12 failed with error -2

regards
Joachim Eastwood
