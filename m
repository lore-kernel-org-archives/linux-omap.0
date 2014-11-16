From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v12 11/15] arm: omap1: Migrate debug_ll macros to use
 8250.S
Date: Sun, 16 Nov 2014 02:29:56 +0200
Message-ID: <20141116002956.GA13220@fuloong-minipc.musicnaut.iki.fi>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
 <1414148076-12685-12-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414148076-12685-12-git-send-email-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Arnd Bergmann <arnd@arndb.de>, Paul Bolle <pebolle@tiscali.nl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Oct 24, 2014 at 11:54:32AM +0100, Daniel Thompson wrote:
> +	config DEBUG_OMAP1UART1
> +		bool "Kernel low-level debugging via OMAP1 UART1"
> +		depends on ARCH_OMAP1
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on OMAP1 based platforms (expect OMAP730) on the UART1.
[...]
> +		  on OMAP1 based platforms (expect OMAP730) on the UART2.
[...]
> +		  on OMAP1 based platforms (expect OMAP730) on the UART3.
                                            ^^^^^^

Spelling again wrong. I think it was already corrected in v11?

A.
