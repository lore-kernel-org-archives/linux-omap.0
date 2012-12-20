From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check"
 bug
Date: Thu, 20 Dec 2012 04:20:04 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab2LTEUS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 23:20:18 -0500
In-Reply-To: <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

On Wed, Dec 19, 2012 at 07:43:50, Paul Walmsley wrote:
> On Tue, 18 Dec 2012, Hebbar Gururaja wrote:
> 
> > From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> > 
> > omap4_cminst_wait_module_ready() checks if register offset is NULL.
> > 
> > int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> > 				   u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, CLKCTRL register offset for different clock domains
> > are not uniformly placed. An example of this would be the RTC clock
> > domain with CLKCTRL offset at 0x00.
> > In such cases the module ready check is skipped which leads to a data
> > abort during boot-up when RTC registers is accessed.
> 
> We've got a few hwmods on OMAP44xx that don't have clkctrl_offs registers 
> listed in the hwmod data, and which are not marked with HWMOD_NO_IDLEST.  
> What's going to happen in those cases?

Hmm. This is a special case to me. Let me go back and do some review.
Will be back with some more details.

> 
> 
> - Paul
> 


Regards, 
Gururaja
