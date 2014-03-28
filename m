From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 49/75] ARM: l2c: fix register naming
Date: Fri, 28 Mar 2014 09:01:49 -0700
Message-ID: <20140328160148.GE24308@atomide.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28046 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbaC1QCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2014 12:02:22 -0400
Content-Disposition: inline
In-Reply-To: <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <anton@enomsg.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Srinivas Kandagatla <srinivas.kandagatla@st.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, spear-devel@list.st.com, kernel@stlinux.com, linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> We have a mixture of different devices with different register layouts,
> but we group all the bits together in an opaque mess.  Split them out
> into those which are L2C-310 specific and ones which refer to earlier
> devices.  Provide full auxiliary control register definitions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
