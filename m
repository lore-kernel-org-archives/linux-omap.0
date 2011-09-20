From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Tue, 20 Sep 2011 23:46:11 +0200
Message-ID: <201109202346.11393.arnd@arndb.de>
References: <20110917014623.GC2937@atomide.com> <201109202334.43213.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53759 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1ITVqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 17:46:16 -0400
In-Reply-To: <201109202334.43213.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 20 September 2011, Arnd Bergmann wrote:
> On Saturday 17 September 2011, Tony Lindgren wrote:
> > Hi Arnd,
> > 
> > Please pull the first part of omap cleanup from:
> > 
> > git://github.com/tmlind/linux.git cleanup
> > 
> > This series cleans up early_init functions and removes
> > CHIP_IS macro usage. This makes it easier to have SoC
> > specific init functions so adding support for new omap
> > variants does not require patching all over the place.
> 
> One more thing: my randconfig tests are running now and
> have spit out a new error after merging lost of stuff
> today:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap_zoom_init':
> /home/arnd/linux-arm/arch/arm/mach-omap2/board-zoom.c:117: undefined reference to `board_nand_init'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Target `_all' not remade because of errors.
> make: *** [sub-make] Error 2
> make: Target `_all' not remade because of errors.

Found it: the offending patch is:

      omap2+: Use Kconfig symbol in Makefile instead of obj-y


It seems that you replace the #ifdef in the board-flash.c file
with a similar #ifdef in the header that replaces this with an
empty inline function when the object is not built.

	Arnd
