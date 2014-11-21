From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v13 5/9] arm: omap1: Migrate debug_ll macros to use 8250.S
Date: Fri, 21 Nov 2014 15:39:59 -0800
Message-ID: <20141121233958.GB7046@atomide.com>
References: <1416235750-4766-1-git-send-email-daniel.thompson@linaro.org>
 <1416235750-4766-6-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416235750-4766-6-git-send-email-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Paul Bolle <pebolle@tiscali.nl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Daniel Thompson <daniel.thompson@linaro.org> [141117 06:53]:
> The omap1's debug-macro.S is similar to the generic 8250 code. Compared to
> the 8520 code the omap1 macro automatically determines what UART to use
> based on breadcrumbs left by the bootloader and automatically copes with
> the eccentric register layout on OMAP7XX.
> 
> This patch drops both these features and relies instead on the generic
> 8250 macros:
> 
> 1. Dropping support for the bootloader breadcrumbs is identical to the
>    way the migration was handled for OMAP2 (see 808b7e07464d...).
> 
> 2. Support for OMAP7XX still exists but it must be configured by hand
>    (DEBUG_OMAP7XXUART1/2/3) rather than handled at runtime.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Looks OK to me, probably best that these are queued all together so:

Acked-by: Tony Lindgren <tony@atomide.com>
