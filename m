From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 10:10:57 +0000
Message-ID: <20120207101057.GR1275@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <20120206181314.GQ1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52448 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab2BGKLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 05:11:05 -0500
Content-Disposition: inline
In-Reply-To: <20120206181314.GQ1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Mon, Feb 06, 2012 at 10:13:15AM -0800, Tony Lindgren wrote:
> FYI, I'm now seeing the same warning as Igor posted with
> omap2plus_defconfig using the same compiler as Igor:
> 
> gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) 
> 
> Still no other warnings though.

If you're not getting the twl4030_power_init() you still need to
investigate why.  For example, are you sure you're building with
CONFIG_TWL4030_POWER enabled?

Secondly, check what you're actually getting:

$ arm-linux-objdump -t ../build/omap4/drivers/mfd/twl4030-power.o | grep twl4030_power_init
000000c0 g     F .init.text     0000066c twl4030_power_init
$ arm-linux-objdump -r ../build/omap4/drivers/mfd/twl-core.o | grep 'twl4030_power_init\|^RELOC'
RELOCATION RECORDS FOR [.text]:
RELOCATION RECORDS FOR [.init.text]:
RELOCATION RECORDS FOR [.exit.text]:
RELOCATION RECORDS FOR [.devinit.text]:
00000258 R_ARM_PC24        twl4030_power_init

and from this we can see that the compiler is doing what they're told
wrt the sections the code is being placed into, and secondly that the
section mismatch tool is working correctly.

So, if you have all that, but you're still not getting this mismatch
warning:

    WARNING: drivers/mfd/built-in.o(.devinit.text+0x258): Section mismatch in reference from the function twl_probe() to the function .init.text:twl4030_power_init()
    The function __devinit twl_probe() references
    a function __init twl4030_power_init().
    If twl4030_power_init is only used by twl_probe then
    annotate twl4030_power_init with a matching annotation.

then, quite simply, your build setup is broken and can't be relied
upon to give proper warnings.

As I mentioned previously, there's no way that the compiler could
optimize this to get rid of this warning as the function definition is
in a completely separate file to where it's being called.

