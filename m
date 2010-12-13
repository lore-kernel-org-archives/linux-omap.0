From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/24] Update clocksource registration
Date: Mon, 13 Dec 2010 19:14:37 +0000
Message-ID: <20101213191437.GN8665@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41178 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab0LMTPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 14:15:34 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Alessandro Rubini <rubini@unipv.it>, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, "Hans J. Koch" <hjk@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Kevin Hilman <khilman@deeprootsystems.com>, Krzysztof Halasa <khc@pm.waw.pl>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Leo Chen <leochen@broadcom.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Sascha Hauer <kernel@pengutronix.de>, Scott Branden <sbranden@broadcom.com>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@st.com>, Wan ZongShun <mcuo>

John Stultz notes in his commit:

    clocksource: Add clocksource_register_hz/khz interface

    How to pick good mult/shift pairs has always been difficult to
    describe to folks writing clocksource drivers, since it requires
    careful tradeoffs in adjustment accuracy vs overflow limits.

    Now, with the clocks_calc_mult_shift function, its much
    easier. However, not many clocksources have converted to using that
    function, and there is still the issue of the max interval length
    assumption being made by each clocksource driver independently.

    So this patch simplifies the registration process by having
    clocksources be registered with a hz/khz value and the registration
    function taking care of setting mult/shift.

    This should take most of the confusion out of writing a clocksource
    driver.

    Additionally it also keeps the shift size tradeoff (more accuracy vs
    longer possible nohz times) centralized so the timekeeping core can
    keep track of the assumptions being made.

This patch series updates all ARM platforms clocksource registration
to use the new clocksource_register_hz()/clocksource_register_khz()
functions, simplifying the selection of the multiply/shift constants.
