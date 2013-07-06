From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: debugging options (was: Re: [PATCH 1/6] ARM: OMAP2+: Remove
	board-4430sdp.c)
Date: Sun, 7 Jul 2013 00:37:08 +0100
Message-ID: <20130706233708.GW21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk> <201307062336.49066.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35920 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab3GFXh0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jul 2013 19:37:26 -0400
Content-Disposition: inline
In-Reply-To: <201307062336.49066.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org

Apologies for the topic hijack.

On Sat, Jul 06, 2013 at 11:36:48PM +0200, Arnd Bergmann wrote:
> Sorry, I missed that this was going on, and I absolutely agree with your
> sentiment. From what I can tell from the git log, Tegra was the first
> to have the separate choice statement, after it just move its
> options from mach-tegra/Kconfig into the Kconfig.debug. OMAP followed
> with the same method and I think from there people just copied it.
> 
> I can understand why one wants to have some more structure in the list,
> given that i.MX alone has 37 options for UART addresses, but we first
> need to have a consistent method of configuring the addresses.

I don't have an option with an option after the choice or a set of
options afterwards asking for details about the selected option -
that is logical.

For example, if we were to reduce the 8250-uart based stuff down to
a single "8250-compatible uart" option, and then ask for the address,
register shift and register access size.

... and of course by this time I now have a patch set which does
exactly that... and it can do more by getting rid of that 8250_32.S
file as well with another config option.  The patch below tries
hard not to break anything or lose information as to the details of
the 8250 UART in any platform which they're already known to the
kernel, but they can be trivially overridden.  Eventually (maybe
tomorrow), I expect a load of the choice config statements in
arch/arm/Kconfig.debug to go away, replaced just with a generic
"Kernel low-level debugging messages via 8250 UART" option.

 arch/arm/Kconfig.debug                             |   92 ++++++++++++++++++--
 arch/arm/include/asm/hardware/debug-8250.S         |   29 ------
 arch/arm/include/debug/8250.S                      |   36 ++++++++
 arch/arm/include/debug/mvebu.S                     |   30 -------
 arch/arm/include/debug/nspire.S                    |    9 +--
 arch/arm/include/debug/pxa.S                       |   33 -------
 arch/arm/include/debug/rockchip.S                  |   42 ---------
 arch/arm/include/debug/sunxi.S                     |   27 ------
 arch/arm/mach-dove/include/mach/debug-macro.S      |   19 ----
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |   22 -----
 .../arm/mach-footbridge/include/mach/debug-macro.S |   15 ---
 arch/arm/mach-gemini/include/mach/debug-macro.S    |   21 -----
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |   24 -----
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |   21 -----
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |   22 -----
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |   26 ------
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |   19 ----
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |   29 ------
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |   19 ----
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |   21 -----
 arch/arm/mach-rpc/include/mach/debug-macro.S       |   23 -----
 21 files changed, 121 insertions(+), 458 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/debug-8250.S
 create mode 100644 arch/arm/include/debug/8250.S
 delete mode 100644 arch/arm/include/debug/mvebu.S
 delete mode 100644 arch/arm/include/debug/pxa.S
 delete mode 100644 arch/arm/include/debug/rockchip.S
 delete mode 100644 arch/arm/include/debug/sunxi.S
 delete mode 100644 arch/arm/mach-dove/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-gemini/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-iop32x/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-iop33x/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-orion5x/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-rpc/include/mach/debug-macro.S

