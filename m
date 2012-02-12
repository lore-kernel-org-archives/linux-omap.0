From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 12 Feb 2012 10:41:32 +0000
Message-ID: <20120212104132.GA17557@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41808 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2BLKlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Feb 2012 05:41:40 -0500
Content-Disposition: inline
In-Reply-To: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Another issue (through lower priority) is this:

twl-common.c:(.init.text+0x2e48): undefined reference to `omap34xx_vddmpu_volt_data'
twl-common.c:(.init.text+0x2e4c): undefined reference to `omap34xx_vddcore_volt_data'
twl-common.c:(.init.text+0x2e5c): undefined reference to `omap36xx_vddmpu_volt_data'
twl-common.c:(.init.text+0x2e60): undefined reference to `omap36xx_vddcore_volt_data'
twl-common.c:(.init.text+0x2830): undefined reference to `omap44xx_vdd_mpu_volt_data'
twl-common.c:(.init.text+0x283c): undefined reference to `omap44xx_vdd_iva_volt_data'
twl-common.c:(.init.text+0x2844): undefined reference to `omap44xx_vdd_core_volt_data'

produced by the allnoconfig build.

The voltage domain code is always built into the kernel, but it references
the operating point code for the voltage tables.  The voltage tables are
only built in when PM_OPP is enabled.

So, this means that either the voltage tables must always be built in, or
the references need to be surrounded by #ifdef CONFIG_PM_OPP.  The former
can be done in two ways: either move those tables out of opp*.c, or get
rid of PM_OPP entirely as it must always be enabled.

The other allnoconfig issue is:

arch/arm/mach-omap2/built-in.o:(.data+0xa3d0): undefined reference to `omap_i2c_reset'

which looks like hwmod can't cope with the I2C_OMAP being disabled.

I don't propose these are fixed for v3.3, but they certainly should be
fixed for v3.4.
