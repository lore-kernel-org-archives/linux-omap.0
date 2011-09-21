From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Wed, 21 Sep 2011 09:06:47 +0200
Message-ID: <1836081.h7sKlomlak@wuerfel>
References: <20110917014623.GC2937@atomide.com> <201109202346.11393.arnd@arndb.de> <20110920223311.GK2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50621 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1IUHHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 03:07:34 -0400
In-Reply-To: <20110920223311.GK2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tuesday 20 September 2011 15:33:12 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [110920 14:12]:
> > On Tuesday 20 September 2011, Arnd Bergmann wrote:
> > > 
> > > One more thing: my randconfig tests are running now and
> > > have spit out a new error after merging lost of stuff
> > > today:
> 
> Good to hear you got "arndconfig" running :)
> 
> Do you think we could also add support for something
> like this:
> 
> $ echo CONFIG_ARCH_OMAP=y > .config
> $ make randconfig
> 
> or
> 
> $ make --force=CONFIG_ARCH_OMAP randconfig
> 
> Where randconfig would keep the forced CONFIG_ARCH_OMAP
> static while randomly selecting the others?
> 
> This would allow targeted randconfig for each patch more
> or less..

The mechanism I use is setting KCONFIG_ALLCONFIG= to a file
that has the options I want to have set to a specific value.

If you don't do that, randconfig will take the default option
for each 'choice' statement, which means we build for the
ARCH_VERSATILE platform.

See the script I'm using at the end of this mail. It should
be easy for you to pick out the parts you need.

> > It seems that you replace the #ifdef in the board-flash.c file
> > with a similar #ifdef in the header that replaces this with an
> > empty inline function when the object is not built.
> 
> Oops. I'll do a fix for that. Those should be now inline
> functions in the header.
> 
> As various other omap branches are based on the cleanup I'd
> rather not go mess with the original patch unless you insist.

Totally fine with me. This is just a corner case anyway, since most
configurations will have flash enabled I guess.

	Arnd

8<---
#!/bin/bash

export ARCH=arm
export PATH=/usr/bin:/bin
export CROSS_COMPILE=arm-linux-gnueabihf-
export PARALLEL=-j6
export CCACHE_DISABLE=1
export O=$PWD/obj-tmp

gen_allconfig()
{
        declare -a MACH
	MACH[1]=OMAP
	MACH[2]=EXYNOS4
	MACH[3]=U8500
	MACH[4]=VEXPRESS
	MACH[5]=MXC
	MACH[6]=MSM
	MACH[7]=PXA
	MACH[8]=MMP
	MACH[9]=DOVE
	MACH[10]=KIRKWOOD
	MACH[11]=ZYNQ
	MACH[12]=PRIMA2
	MACH[13]=TEGRA
	MACH[14]=SHMOBILE

        declare -a MXC
        MXC[1]=MX3
        MXC[2]=MX503
        MXC[3]=MX51

        declare -a AT91
        AT91[1]=ARCH_AT91RM9200
        AT91[2]=ARCH_AT91SAM9260
        AT91[3]=ARCH_AT91SAM9261
        AT91[4]=ARCH_AT91SAM9G10
        AT91[5]=ARCH_AT91SAM9263
        AT91[6]=ARCH_AT91SAM9RL
        AT91[7]=ARCH_AT91SAM9G20
        AT91[8]=ARCH_AT91SAM9G45
        AT91[9]=ARCH_AT91CAP9
        AT91[10]=ARCH_AT91X40

	  # pick one ARCH_* option from the main choice statement
        echo "CONFIG_ARCH_${MACH[$[ $RANDOM % ${#MACH[@]} +1 ]]}=y"

	  # IMX and AT91 have another choice statement
        echo "CONFIG_ARCH_${MXC[$[ $RANDOM % ${#MXC[@]} +1 ]]}=y"
        echo "CONFIG_${MXC[$[ $RANDOM % ${#AT91[@]} +1 ]]}=y"

	  # These have to be fixed in order to avoid huge build breakage.
        echo "# CONFIG_XIP_KERNEL is not set"
        echo "# CONFIG_STAGING is not set"
        echo "CONFIG_MMU=y"
        echo "CONFIG_PREVENT_FIRMWARE_BUILD=y"

        # add a few choice options that don't normally get selected
        [ $[RANDOM % 2 ] == 1 ] || echo "CONFIG_PROFILE_ALL_BRANCHES=y"
        [ $[RANDOM % 2 ] == 1 ] || echo "CONFIG_SLAB=y"
        [ $[RANDOM % 2 ] == 1 ] || echo "CONFIG_PREEMPT=y"
}

prepare()
{
        mkdir -p ${O}
        make O=${O} clean
        gen_allconfig > ${O}/allconfig
        make O=${O} KCONFIG_ALLCONFIG=${O}/allconfig randconfig
}

mkdir -p out
prepare
for i in `seq -w 9999` ; do
        if ! make O=${O} -k -s ${PARALLEL} CFLAGS_KERNEL+=-Wno-uninitialized KALLSYMS_EXTRA_PASS=1 2> out/warnings-$i ; then
                make O=${O} -k -s CFLAGS_KERNEL+=-Wno-uninitialized KALLSYMS_EXTRA_PASS=1 2> out/errors-$i
                cp ${O}/.config out/config-broken-$i
        else
                cp ${O}/.config out/config-ok-$i
        fi
        prepare
done
