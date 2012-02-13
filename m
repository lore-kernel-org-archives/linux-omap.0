From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Mon, 13 Feb 2012 13:17:53 -0800
Message-ID: <20120213211752.GG1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120206181314.GQ1426@atomide.com>
 <20120207101057.GR1275@n2100.arm.linux.org.uk>
 <20120208053213.GB20885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60085 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab2BMVR6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 16:17:58 -0500
Content-Disposition: inline
In-Reply-To: <20120208053213.GB20885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi,

* Tony Lindgren <tony@atomide.com> [120207 21:01]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120207 01:39]:
> > On Mon, Feb 06, 2012 at 10:13:15AM -0800, Tony Lindgren wrote:
> > > FYI, I'm now seeing the same warning as Igor posted with
> > > omap2plus_defconfig using the same compiler as Igor:
> > > 
> > > gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) 
> > > 
> > > Still no other warnings though.
> > 
> > If you're not getting the twl4030_power_init() you still need to
> > investigate why.  For example, are you sure you're building with
> > CONFIG_TWL4030_POWER enabled?
> 
> Yes it's enabled in omap2plus_defconfig. Same results with one
> of your defconfigs. Below is the output from compiler above.
>  
> > Secondly, check what you're actually getting:
> > 
> > $ arm-linux-objdump -t ../build/omap4/drivers/mfd/twl4030-power.o | grep twl4030_power_init
> > 000000c0 g     F .init.text     0000066c twl4030_power_init
> > 00000650 g     F .init.text     000001a0 twl4030_power_init
> 
> > $ arm-linux-objdump -r ../build/omap4/drivers/mfd/twl-core.o | grep 'twl4030_power_init\|^RELOC'
> > RELOCATION RECORDS FOR [.text]:
> > RELOCATION RECORDS FOR [.init.text]:
> > RELOCATION RECORDS FOR [.exit.text]:
> > RELOCATION RECORDS FOR [.devinit.text]:
> > 00000258 R_ARM_PC24        twl4030_power_init

I'll post a patch to fix this, it's caused by missing
handling in modpost.c.
 
> > then, quite simply, your build setup is broken and can't be relied
> > upon to give proper warnings.
> 
> Right, no luck yet getting crosstool-ng built plain gcc working..
> Yesterday ftp.gnu.org was down and the script is using that. Have
> to continue with that when I get a chance.

The gnu.org ftp issue was a firewall issue on my build box..

Got the compiler build going further with the following fix to
crosstool-ng in case others are having similar issues. Will send
that separately to crosstool-ng mailing list.

Regards,

Tony


--- a/scripts/build/debug/200-duma.sh	Thu Feb 02 22:43:18 2012 +0100
+++ b/scripts/build/debug/200-duma.sh	Mon Feb 13 12:36:06 2012 -0800
@@ -4,7 +4,7 @@
     # Downloading an non-existing file from sourceforge will give you an
     # HTML file containing an error message, instead of returning a 404.
     # Sigh...
-    CT_GetFile "duma_${CT_DUMA_VERSION}" .tar.gz http://mesh.dl.sourceforge.net/sourceforge/duma/
+    CT_GetFile "duma_${CT_DUMA_VERSION}" .tar.gz http://dfn.dl.sourceforge.net/sourceforge/duma/
     # Downloading from sourceforge may leave garbage, cleanup
     CT_DoExecLog ALL rm -f "${CT_TARBALLS_DIR}/showfiles.php"*
 }
--- a/scripts/build/debug/300-gdb.sh	Thu Feb 02 22:43:18 2012 +0100
+++ b/scripts/build/debug/300-gdb.sh	Mon Feb 13 12:36:06 2012 -0800
@@ -62,7 +62,7 @@
 
     if [ "${do_expat}" = "y" ]; then
         CT_GetFile "expat-${CT_DEBUG_GDB_EXPAT_VERSION}" .tar.gz    \
-                   http://mesh.dl.sourceforge.net/sourceforge/expat/expat/${CT_DEBUG_GDB_EXPAT_VERSION}
+                   http://dfn.dl.sourceforge.net/sourceforge/expat/expat/${CT_DEBUG_GDB_EXPAT_VERSION}
     fi
 }
 
--- a/scripts/build/debug/500-strace.sh	Thu Feb 02 22:43:18 2012 +0100
+++ b/scripts/build/debug/500-strace.sh	Mon Feb 13 12:36:06 2012 -0800
@@ -1,7 +1,7 @@
 # Build script for strace
 
 do_debug_strace_get() {
-    CT_GetFile "strace-${CT_STRACE_VERSION}" http://mesh.dl.sourceforge.net/sourceforge/strace/
+    CT_GetFile "strace-${CT_STRACE_VERSION}" http://dfn.dl.sourceforge.net/sourceforge/strace/
     # Downloading from sourceforge leaves garbage, cleanup
     CT_DoExecLog ALL rm -f "${CT_TARBALLS_DIR}/showfiles.php"*
 }
