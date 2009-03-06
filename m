From: Paul Walmsley <paul@pwsan.com>
Subject: Re: where is "struct constraint_id" defined?
Date: Fri, 6 Mar 2009 13:25:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0903061309470.24092@utopia.booyaka.com>
References: <6e77f93b754e8ec34333f764a6a00c43.squirrel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53392 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbZCFUZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 15:25:31 -0500
In-Reply-To: <6e77f93b754e8ec34333f764a6a00c43.squirrel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david.hagood@gmail.com
Cc: linux-omap@vger.kernel.org

Hi David

On Thu, 5 Mar 2009, david.hagood@gmail.com wrote:

> I am trying to build the OMAP3 graphics kernel module against
> 2.6.29-rc7-omap1 (from GIT), and have been running into problems getting
> it to build.
> 
> Two problems were pretty easy: the TI code was including "asm/resource.h"
> and "asm/semaphore.h" rather than "linux/resource.h" and
> "linux/semaphore.h".
> 
> Having made those changes, it builds all the way through to the TI
> supplied "sysutils_linux.c", which barfs with :
> 
> In file included from
> /space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils.c:28:
> /space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils_linux.c:154:
> error: variable 'cnstr_id_vdd2' has initializer but incomplete type
> 
> (and many other errors).
> 
> The problem line of the code is:
> 
> static struct constraint_id cnstr_id_vdd2 = {
> 
> and I cannot find a definition of "struct constraint_id" anywhere in the
> kernel.
> 
> Has this been renamed, or moved, or am I looking in the wrong place?

Haven't seen the code in question, but it sounds like it's trying to 
change OPP constraints on VDD2 (CORE), to allow SGX speed (and power 
consumption) to be reduced when it is not in use.

If you're not using the PM branch of l-o, you can probably just remove 
all the references to this from the driver.  The SGX speed is fixed at 
whatever the bootloader configured.

If you're using the PM branch, you can constrain CORE OPPs directly from 
the driver via omap_pm_set_min_bus_tput().  Pass a function pointer to 
omap_pm_set_min_bus_tput() via the driver's platform_data structure, then 
call pdata->set_min_bus_tput() from the driver.  The current SRF 
implementation of this uses r > 0 to mean "high speed, high power 
consumption" and r == 0 to mean "low speed, low power consumption". 
arch/arm/plat-omap/include/mach/omap-pm.h and 
Documentation/arm/OMAP/omap_pm may be useful.


- Paul
