From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/19] Make clocksource name const
Date: Thu, 19 May 2011 09:19:44 +0200
Message-ID: <BANLkTin-N-=CcS0nDrNH1wmSWHtxg8gMVw@mail.gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1YI-0003DJ-BQ@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55570 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab1ESHTp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 03:19:45 -0400
Received: by iwn34 with SMTP id 34so1947004iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 00:19:44 -0700 (PDT)
In-Reply-To: <E1QM1YI-0003DJ-BQ@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-omap@vger.kernel.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, Alessandro Rubini <rubini@unipv.it>

2011/5/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> As nothing should be writing to the clocksource name string, make the
> clocksource name pointer const. =A0Build-tested on ARM Versatile Expr=
ess.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
