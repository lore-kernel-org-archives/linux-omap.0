From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Mon, 1 Oct 2012 10:55:11 +0200
Message-ID: <CACRpkdb2f18vwv9qXZkypPxM4UwyeTrDs4+JnpFtYRCzADzFPQ@mail.gmail.com>
References: <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
	<20120920220130.GN2449@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
	<20120920232114.GO2449@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
	<20120921185827.GC2454@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
	<20120921195717.GD2454@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
	<20120922201043.GE2934@linux.vnet.ibm.com>
	<20120922215923.GA13161@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120922215923.GA13161@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Paul Walmsley <paul@pwsan.com>, "Bruce, Becky" <bbruce@ti.com>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 22, 2012 at 11:59 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> rcu: Fix day-one dyntick-idle stall-warning bug

As mentioned in another thread this solves the same problem for ux500.
Reported/Tested-by: Linus Walleij <linus.walleij@linaro.org>

But now it appears that this commit didn't make it into v3.6 so
it definately needs to be tagged with Cc: stable@kernel.org
before it gets merged since the stall warnings are kinda scary.

Yours,
Linus Walleij
