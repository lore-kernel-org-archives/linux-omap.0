From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP1: ams-delta: refactor late_init()
Date: Mon, 2 Jul 2018 05:55:54 -0700
Message-ID: <20180702125554.GW112168@atomide.com>
References: <20180527135548.7904-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180527135548.7904-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180527 06:58]:
> Before the board level GPIO handling is converted from GPIO numbers to
> GPIO descriptors, split late_init() into functional blocks and move
> them to separate functions.
> 
> While being at it, drop machine type check from late_init() - the
> function is now called from the board init_late callback so there is
> no need for yet another applicability check.

Applying both into omap-for-v4.19/omap1 thanks.

Tony
