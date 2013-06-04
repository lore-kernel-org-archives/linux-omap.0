From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/11] i2c: omap: enhance pinctrl support
Date: Tue, 4 Jun 2013 09:23:24 +0200
Message-ID: <CACRpkdaTHsHzu1dyOBoNn77+U5r5oJ0ueUv=W8g41Nb0X1qtTg@mail.gmail.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
	<1369995191-20855-12-git-send-email-gururaja.hebbar@ti.com>
	<87bo7r10s9.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:56826 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759884Ab3FDHXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jun 2013 03:23:24 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so8626601obb.25
        for <linux-omap@vger.kernel.org>; Tue, 04 Jun 2013 00:23:24 -0700 (PDT)
In-Reply-To: <87bo7r10s9.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Hebbar Gururaja <gururaja.hebbar@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, sudhakar.raj@ti.com, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Fri, May 31, 2013 at 8:07 PM, Kevin Hilman <khilman@linaro.org> wrote:

> But that brings up a bigger question about whether or not we should be
> doing the rest of this (idle/sleep) pin management in the drivers or in
> the driver core as well.  I would much prefer it be handled by the
> driver core.

Yes. See my suggestion in 2/11.

> In fact, since these are all PM related events, it should probably be
> handled by the PM core and seems pretty straight forward to do so.

I can see a clean interface with three simple functions toward
<pinctrl/consumer.h> for switching between the default, idle and
sleep states, but you may see even further...

Yours,
Linus Walleij
