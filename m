From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Tue, 21 Dec 2010 23:24:29 -0800
Message-ID: <AANLkTi=uspZY9ibQrJSti8UT1v5NHSHdzv+Y_Jsam9yu@mail.gmail.com>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57716 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0LVHYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 02:24:30 -0500
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alessandro Rubini <rubini@unipv.it>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Eric Miao <eric.y.miao@gmail.com>, Erik Gilling <konkers@android.com>, "Hans J. Koch" <hjk@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Kevin Hilman <khilman@deeprootsystems.com>, Krzysztof Halasa <khc@pm.waw.pl>, Kukjin Kim <kgene.kim@samsung.com>, Lennert Buytenhek <kernel@wantstofly.org>, Jiandong Zheng <jdzheng@broadcom.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Sascha Hauer <kernel@pengutronix.de>, Scott Branden <sbranden@broadcom.com>, STEricsson <STEricsson_nomadik_linux@list.st.com>, Tony Lindgren <tony@at>

On Fri, Dec 17, 2010 at 3:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted. =A0There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
>
> Still looking for acks or tested-by's for these patches.

Tegra (see comment to that specific patch for a needed fixup):

Tested-by: Olof Johansson <olof@lixom.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
