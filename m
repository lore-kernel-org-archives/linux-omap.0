From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/2] OMAP4: fix temporary hacks that break multi-omap PM
Date: Thu, 11 Mar 2010 10:42:05 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C46F1602@dbde02.ent.ti.com>
References: <1268241391-26312-1-git-send-email-khilman@deeprootsystems.com>
 <1268241391-26312-3-git-send-email-khilman@deeprootsystems.com>
 <20100310214231.GO2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48247 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab0CKFMN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 00:12:13 -0500
In-Reply-To: <20100310214231.GO2900@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, March 11, 2010 3:13 AM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh
> Subject: Re: [PATCH 2/2] OMAP4: fix temporary hacks that break multi-omap PM
> 
> * Kevin Hilman <khilman@deeprootsystems.com> [100310 09:16]:
> > When building for multi-omap, and OMAP4 is enabled, CONFIG_ARCH_OMAP4
> > will be true and prevent included code from building/running for
> > OMAP2/3 as well.
> >
> > This problem exists in io.c where some hwmod/PM/SDRC init code is
> > prevented from running even on OMAP2/3 when OMAP4 is included in a
> > multi-OMAP build.
> >
> > A quick glance suggests that this #ifndef is no longer needed in most
> > of the cases.  In the remaining cases, the function is wrapped with
> > "if (cpu_is_omap24xx() || cpu_is_omap34xx())" which will be optimized
> > out for OMAP4-only builds.
> >
> > Note that this is only a short-term fix.  Longer-term, OMAP4
> > needs to create init functions for SDRC and hwmod late-init.
> 
> Good to get rid of the temporary hacks. Santosh, maybe grep
> to see if there are other hacks left that can be now removed?
> 
Tony,
We have almost cleaned up all the hacks in platform code 
except the one around ongoing hwmod work.

Will check if I have missed anything.

Regards,
Santosh
