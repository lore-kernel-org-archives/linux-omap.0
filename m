From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 21:32:13 -0800
Message-ID: <20120208053213.GB20885@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120206181314.GQ1426@atomide.com>
 <20120207101057.GR1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61674 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab2BHFcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 00:32:16 -0500
Content-Disposition: inline
In-Reply-To: <20120207101057.GR1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120207 01:39]:
> On Mon, Feb 06, 2012 at 10:13:15AM -0800, Tony Lindgren wrote:
> > FYI, I'm now seeing the same warning as Igor posted with
> > omap2plus_defconfig using the same compiler as Igor:
> > 
> > gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) 
> > 
> > Still no other warnings though.
> 
> If you're not getting the twl4030_power_init() you still need to
> investigate why.  For example, are you sure you're building with
> CONFIG_TWL4030_POWER enabled?

Yes it's enabled in omap2plus_defconfig. Same results with one
of your defconfigs. Below is the output from compiler above.
 
> Secondly, check what you're actually getting:
> 
> $ arm-linux-objdump -t ../build/omap4/drivers/mfd/twl4030-power.o | grep twl4030_power_init
> 000000c0 g     F .init.text     0000066c twl4030_power_init

00000650 g     F .init.text     000001a0 twl4030_power_init

> $ arm-linux-objdump -r ../build/omap4/drivers/mfd/twl-core.o | grep 'twl4030_power_init\|^RELOC'
> RELOCATION RECORDS FOR [.text]:
> RELOCATION RECORDS FOR [.init.text]:
> RELOCATION RECORDS FOR [.exit.text]:
> RELOCATION RECORDS FOR [.devinit.text]:
> 00000258 R_ARM_PC24        twl4030_power_init

RELOCATION RECORDS FOR [.text]:
RELOCATION RECORDS FOR [.init.text]:
RELOCATION RECORDS FOR [.exit.text]:
RELOCATION RECORDS FOR [.devinit.text]:
000001c8 R_ARM_CALL        twl4030_power_init
RELOCATION RECORDS FOR [.ARM.exidx]:
RELOCATION RECORDS FOR [.ARM.exidx.init.text]:
RELOCATION RECORDS FOR [.ARM.exidx.exit.text]:
RELOCATION RECORDS FOR [.ARM.exidx.devinit.text]:
RELOCATION RECORDS FOR [___kcrctab+twl_i2c_write]:
RELOCATION RECORDS FOR [___ksymtab+twl_i2c_write_u8]:
RELOCATION RECORDS FOR [___ksymtab+twl_i2c_write]:
RELOCATION RECORDS FOR [___ksymtab+twl_rev]:
RELOCATION RECORDS FOR [___ksymtab_gpl+twl_get_version]:
RELOCATION RECORDS FOR [___kcrctab_gpl+twl_get_type]:
RELOCATION RECORDS FOR [___ksymtab+twl_i2c_read]:
RELOCATION RECORDS FOR [___ksymtab_gpl+twl_get_type]:
RELOCATION RECORDS FOR [___kcrctab+twl_rev]:
RELOCATION RECORDS FOR [___kcrctab+twl_i2c_write_u8]:
RELOCATION RECORDS FOR [___kcrctab+twl_i2c_read_u8]:
RELOCATION RECORDS FOR [___ksymtab+twl_i2c_read_u8]:
RELOCATION RECORDS FOR [___kcrctab+twl_i2c_read]:
RELOCATION RECORDS FOR [___kcrctab_gpl+twl_get_version]:
RELOCATION RECORDS FOR [.data]:
RELOCATION RECORDS FOR [.initcall4.init]:
RELOCATION RECORDS FOR [.exitcall.exit]:
RELOCATION RECORDS FOR [.debug_info]:
RELOCATION RECORDS FOR [.debug_line]:
RELOCATION RECORDS FOR [.debug_frame]:
RELOCATION RECORDS FOR [.debug_loc]:
RELOCATION RECORDS FOR [.debug_pubnames]:
RELOCATION RECORDS FOR [.debug_aranges]:
RELOCATION RECORDS FOR [.debug_ranges]:

> and from this we can see that the compiler is doing what they're told
> wrt the sections the code is being placed into, and secondly that the
> section mismatch tool is working correctly.
> 
> So, if you have all that, but you're still not getting this mismatch
> warning:
> 
>     WARNING: drivers/mfd/built-in.o(.devinit.text+0x258): Section mismatch in reference from the function twl_probe() to the function .init.text:twl4030_power_init()
>     The function __devinit twl_probe() references
>     a function __init twl4030_power_init().
>     If twl4030_power_init is only used by twl_probe then
>     annotate twl4030_power_init with a matching annotation.
> 
> then, quite simply, your build setup is broken and can't be relied
> upon to give proper warnings.

Right, no luck yet getting crosstool-ng built plain gcc working..
Yesterday ftp.gnu.org was down and the script is using that. Have
to continue with that when I get a chance.
 
> As I mentioned previously, there's no way that the compiler could
> optimize this to get rid of this warning as the function definition is
> in a completely separate file to where it's being called.

Yes it seems that there's something wrong..

Tony
