From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 5/5] omap dts changes for v3.18 merge window
Date: Thu, 18 Sep 2014 13:15:08 -0700
Message-ID: <20140918201507.GO14505@atomide.com>
References: <pull-1410478051-378788>
 <pull-1410478051-378788-5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28113 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756987AbaIRUPY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 16:15:24 -0400
Content-Disposition: inline
In-Reply-To: <pull-1410478051-378788-5>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140911 16:29]:
> The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:
> 
>   Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/dt-for-v3.18
> 
> for you to fetch changes up to d27704d1ec2f9ba06247b402c58a6f2febecef78:
> 
>   ARM: dts: OMAP2+: Add sub mailboxes device node information (2014-09-11 11:46:30 -0700)
> 
> ----------------------------------------------------------------
> Changes for .dts files for omaps for v3.18 merge window:
> 
> - Updates for gta04 to add gta04a3 model
> - Add support for Tehnexion TAO3530 boards
> - Regulator names for beaglebone
> - Pinctrl related updates for omap5, dra7 and am437
> - Model name fix for sbc-t54
> - Enable mailbox for various omaps

This can cause a minor merge conflict, here's the
merge resolution for reference.

Regards,

Tony

--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@@ -226,7 -240,9 +226,9 @@@ MACHINE_EN
  #endif
  
  #ifdef CONFIG_SOC_DRA7XX
 -static const char *dra74x_boards_compat[] __initconst = {
 +static const char *const dra74x_boards_compat[] __initconst = {
+ 	"ti,am5728",
+ 	"ti,am5726",
  	"ti,dra742",
  	"ti,dra7",
  	NULL,
@@@ -245,7 -261,9 +247,9 @@@ DT_MACHINE_START(DRA74X_DT, "Generic DR
  	.restart	= omap44xx_restart,
  MACHINE_END
  
 -static const char *dra72x_boards_compat[] __initconst = {
 +static const char *const dra72x_boards_compat[] __initconst = {
+ 	"ti,am5718",
+ 	"ti,am5716",
  	"ti,dra722",
  	NULL,
  };
