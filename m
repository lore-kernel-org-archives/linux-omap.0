From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3.1-rc3] gpio/omap: fix build error with certain OMAP1 configs
Date: Tue, 23 Aug 2011 10:11:47 -0700
Message-ID: <87sjoshx2k.fsf@ti.com>
References: <201108231342.25101.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201108231342.25101.jkrzyszt@tis.icnet.pl> (Janusz Krzysztofik's
	message of "Tue, 23 Aug 2011 13:42:24 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> writes:

> With commit f64ad1a0e21a, "gpio/omap: cleanup _set_gpio_wakeup(), remove 
> ifdefs", access to build time conditionally omitted 'suspend_wakeup' 
> member of the 'gpio_bank' structure has been placed unconditionally in 
> function _set_gpio_wakeup(), which is always built. This resulted in the 
> driver compilation broken for certain OMAP1, i.e., non-OMAP16xx, 
> configurations.
>
> Really required or not in previously excluded cases, define this 
> structure member unconditionally as a fix.
>
> Tested with a custom OMAP1510 only configuration.
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Verified that this fixes a build problem when building for OMAP1
(730/850 only)

Acked-by: Kevin Hilman <khilman@ti.com>

Grant, can you queue this as a fix for 3.1-rc?

Thanks,

Kevin
