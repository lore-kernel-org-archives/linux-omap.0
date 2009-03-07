From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: where is "struct constraint_id" defined?
Date: Sat, 7 Mar 2009 15:41:42 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FADBFBFE@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0903061309470.24092@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbZCGKL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Mar 2009 05:11:59 -0500
In-Reply-To: <alpine.DEB.2.00.0903061309470.24092@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "david.hagood@gmail.com" <david.hagood@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Saturday, March 07, 2009 1:55 AM
> To: david.hagood@gmail.com
> Cc: linux-omap@vger.kernel.org
> Subject: Re: where is "struct constraint_id" defined?
> 
> Hi David
> 
> On Thu, 5 Mar 2009, david.hagood@gmail.com wrote:
> 
> > I am trying to build the OMAP3 graphics kernel module against
> > 2.6.29-rc7-omap1 (from GIT), and have been running into 
> problems getting
> > it to build.
> > 
> > Two problems were pretty easy: the TI code was including 
> "asm/resource.h"
> > and "asm/semaphore.h" rather than "linux/resource.h" and
> > "linux/semaphore.h".
> > 
> > Having made those changes, it builds all the way through to the TI
> > supplied "sysutils_linux.c", which barfs with :
> > 
> > In file included from
> > 
> /space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/servic
es4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils.c:28:
> > 
> /space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/servic
es4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils_linux.c:154:
> > error: variable 'cnstr_id_vdd2' has initializer but incomplete type
> > 
> > (and many other errors).
> > 
> > The problem line of the code is:
> > 
> > static struct constraint_id cnstr_id_vdd2 = {
> > 
> > and I cannot find a definition of "struct constraint_id" 
> anywhere in the
> > kernel.
> > 
> > Has this been renamed, or moved, or am I looking in the wrong place?

That piece of code refers to the constraint f/w implementation which exists only
in the TI internal tree. 
As Paul suggested if you are using the mainline l-o remove all that code, else use the
latest l-o pm branch with a different set of API's to achieve the same.

> 
> Haven't seen the code in question, but it sounds like it's trying to 
> change OPP constraints on VDD2 (CORE), to allow SGX speed (and power 
> consumption) to be reduced when it is not in use.
> 
> If you're not using the PM branch of l-o, you can probably 
> just remove 
> all the references to this from the driver.  The SGX speed is 
> fixed at 
> whatever the bootloader configured.
> 
> If you're using the PM branch, you can constrain CORE OPPs 
> directly from 
> the driver via omap_pm_set_min_bus_tput().  Pass a function 
> pointer to 
> omap_pm_set_min_bus_tput() via the driver's platform_data 
> structure, then 
> call pdata->set_min_bus_tput() from the driver.  The current SRF 
> implementation of this uses r > 0 to mean "high speed, high power 
> consumption" and r == 0 to mean "low speed, low power consumption". 
> arch/arm/plat-omap/include/mach/omap-pm.h and 
> Documentation/arm/OMAP/omap_pm may be useful.
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 