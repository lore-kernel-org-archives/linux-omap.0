From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
Date: Fri, 8 Feb 2013 23:17:51 +0100
Message-ID: <CACRpkdbm2=+U7k=L61vwT8pZyox41N-cSBL7qj+6Byrh+8+V2Q@mail.gmail.com>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:43703 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947059Ab3BHWRw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 17:17:52 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so4762444iaa.22
        for <linux-omap@vger.kernel.org>; Fri, 08 Feb 2013 14:17:52 -0800 (PST)
In-Reply-To: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, spear-devel@list.st.com

On Thu, Feb 7, 2013 at 9:53 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> function to use it and covert all callers of
> twd_local_timer_of_register.

This is one good looking patch.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
