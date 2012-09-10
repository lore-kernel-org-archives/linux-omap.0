From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 10 Sep 2012 08:23:51 -0700
Message-ID: <CACRpkdZySZqf-gPoQLGgMZ_B9m+8+Jbr4b6aA+j_OFDCHc2cGg@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
	<331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
	<20120907110251.GA7968@glitch>
	<331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
	<20120907160025.GB14330@glitch>
	<CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com>
	<20120908234435.GA13519@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60998 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2IJPXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 11:23:53 -0400
Received: by wibhr14 with SMTP id hr14so2372602wib.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 08:23:52 -0700 (PDT)
In-Reply-To: <20120908234435.GA13519@glitch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.com>, Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@wwwdotorg.org>

On Sun, Sep 9, 2012 at 1:44 AM, Domenico Andreoli <cavokz@gmail.com> wrote:
> On Fri, Sep 07, 2012 at 11:57:59PM +0200, Linus Walleij wrote:
>>
>> If all you need to to is to multiplex the pins into GPIO mode,
>> then the gpio_get() call on this driver *can* call through to
>> pinctrl_request_gpio() which will in turn fall through to the
>> above pinmux driver calls (.gpio_request_enable, etc).
>
> So if the GPIO driver doesn't coordinate with the pinctrl driver, it's
> all left to the GPIO user to configure the pin before using it, right?

Yes, more or less, or should I say that certain aspects of pinctrl
are orthogonal to GPIO and the two mostly do not know of each
other due to a separation of concerns.

So the driver may need to tie things up and request its pinctrl
and GPIOs independently.

> I can understand the concerns of Tony, whether a pin must be requested
> or not before the gpio then depends on the GPIO driver implementation,
> which may or may not call through the pinctrl layer, isn't it?.

Yes that is a sematic limitation, indeed.

I think the best way of trying to eliminate that is to bring the two
subsystems closer (which is some long-term project) but in the
meantime we could propose a documentation fixup to make the
semantics clear, what about this:

>From a92d754367861cf564c09e0b15746e02f0a96f3f Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Sep 2012 17:22:00 +0200
Subject: [PATCH] pinctrl: document semantics vs GPIO

The semantics of the interactions between GPIO and pinctrl may be
unclear, e.g. which one do you request first? This amends the
documentation to make this clear.

Reported-by: Domenico Andreoli <cavokz@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/pinctrl.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index 1479aca..941e783 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -289,6 +289,29 @@ Interaction with the GPIO subsystem
 The GPIO drivers may want to perform operations of various types on the same
 physical pins that are also registered as pin controller pins.

+First and foremost, the two subsystems can be used as completely orthogonal,
+so say that your driver is fetching its resources like this:
+
+#include <linux/pinctrl/consumer.h>
+#include <linux/gpio.h>
+
+struct pinctrl *pinctrl;
+int gpio;
+
+pinctrl = devm_pinctrl_get_select_default(&dev);
+gpio = devm_gpio_request(&dev, 14, "foo");
+
+Here we first request a certain pin state and then request GPIO 14 to be
+used. If you're using the subsystems orthogonally like this, always get
+your pinctrl handle and select the desired pinctrl state BEFORE requesting
+the GPIO. This is a semantic convention to avoid situations that can be
+electrically unpleasant, you may certainly want to mux in and bias pins
+a certain way before the GPIO subsystems starts to deal with them.
+
+But there are also situations where it makes sense for the GPIO subsystem
+to communicate with with the pinctrl subsystem, using the latter as a
+back-end.
+
 Since the pin controller subsystem have its pinspace local to the pin
 controller we need a mapping so that the pin control subsystem can figure out
 which pin controller handles control of a certain GPIO pin. Since a single
@@ -359,6 +382,7 @@ will get an pin number into its handled number
range. Further it is also passed
 the range ID value, so that the pin controller knows which range it should
 deal with.

+
 PINMUX interfaces
 =================

-- 
1.7.11.3


Yours,
Linus Walleij
