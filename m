From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/13] clocksource: add common mmio clocksource
Date: Thu, 12 May 2011 10:03:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1105121001590.2794@ionos>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk> <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52893 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1ELID6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 04:03:58 -0400
In-Reply-To: <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Alessandro Rubini <rubini@unipv.it>, Colin Cross <ccross@android.com>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, "Hans J. Koch" <hjk@hansjkoch.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@st.com>, Wan ZongShun <mcuos.com@gmail.com>

On Tue, 10 May 2011, Russell King - ARM Linux wrote:

> Add a generic mmio clocksource, covering both 32-bit and 16-bit register
> access sizes, for up or down counters.  This can be used to easily
> create clocksources for simple counter-based implementations.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Colin Cross <ccross@android.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Erik Gilling <konkers@android.com>
> Cc: "Hans J. Koch" <hjk@hansjkoch.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: linux-omap@vger.kernel.org
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Please take this through the ARM tree. It's not conflicting with
anything in my tree.

