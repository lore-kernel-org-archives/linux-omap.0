From: Pavel Machek <pavel@ucw.cz>
Subject: BCM2048 bluetooth connected over OMAP serial
Date: Wed, 10 Dec 2014 17:43:33 +0100
Message-ID: <20141210164333.GA3154@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34558 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbaLJQng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2014 11:43:36 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

Hi!

So, there's bluetooth chip that's connected to the SoC by UART and some
GPIOs. What would be right representation in the device tree?
Something like this?

	bluetooth {
                  compatible = "broadcom,bcm2048";
                  uart = <&uart2>;
                  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
                  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
	          bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
                  chip-type = <3>;
                  bt-sysclk = <2>;
                  reset-gpio-shared = <0>;
        };

Is there some way to prevent OMAP tty driver from binding to the
device and exporting the device to userspace?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
