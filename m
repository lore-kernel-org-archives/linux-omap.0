From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v10 5/9] arm: omap1: Migrate debug_ll macros to use 8250.S
Date: Wed, 17 Sep 2014 01:58:10 +0300
Message-ID: <20140916225810.GA1273@drone.musicnaut.iki.fi>
References: <1410907588-19957-1-git-send-email-daniel.thompson@linaro.org>
 <1410907588-19957-6-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410907588-19957-6-git-send-email-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Arnd Bergmann <arnd@arndb.de>, Paul Bolle <pebolle@tiscali.nl>, patches@linaro.org, linaro-kernel@lists.linaro.org, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 16, 2014 at 11:46:24PM +0100, Daniel Thompson wrote:
> +	config DEBUG_OMAP1UART1
> +		bool "Kernel low-level debugging via OMAP1 UART1"
> +		depends on ARCH_OMAP1
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on OMAP1 based platforms (expect OMAP730) on the UART1.
                                            ^^^^^^

> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on OMAP1 based platforms (expect OMAP730) on the UART2.
                                            ^^^^^^

> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on OMAP1 based platforms (expect OMAP730) on the UART3.
                                            ^^^^^^

I already commented earlier, that "expect" here is probably a typo?

A.
