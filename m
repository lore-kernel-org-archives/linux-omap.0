From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
Date: Wed, 9 May 2012 08:59:49 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1BF14@DBDE01.ent.ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
	<1336506724-5494-4-git-send-email-hvaibhav@ti.com> <87397ajo32.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab2EIJAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 05:00:46 -0400
In-Reply-To: <87397ajo32.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 09, 2012 at 04:08:09, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > The function __omap2_set_globals() can be common across all
> > platforms/architectures, even in case of omap4, internally it
> > calls same set of functions as in __omap2_set_globals() function
> > (except for sdrc).
> 
> OK so far.
> 
> > This patch adds new config flag SOC_HAS_OMAP2_SDRC to handle sdrc,
> > so that we can reuse same function across omap2/3/4...
> 
> But what happens when a single kernel is built that has support for an
> SoC with an SDRC (OMAP4) and one that doesn't (AM33xx)?
> 

As such Nothing...I looking into this direction while implementing.

In that case, sdrc.c file will be compiled in and execution will jump to
omap2_set_globals_sdrc(). But inside this function, we are already checking 
whether the omap2_globals->sdrc and omap2_globals->sms for NULL and then use 
it.

And function omap2_sdrc_init() is also depends on machine, so in case of
Am33xx, it won't get into sdrc execution at all. And in case of omap4, it 
will.

> In that case this new SOC_HAS_OMAP2_SDRC will be set, and
> set_globals_sdrc() will be called even for the SoCs without SDRC.
> 
> So, rather than add a new Kconfig option for this, I would rather see 
> you using the existing runtime feature check for the SDRC: omap_has_sdrc()
> 

There is NO difference between runtime feature check Vs this patch, refer to the function implementation,

void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
{
	if (omap2_globals->sdrc)
		omap2_sdrc_base = omap2_globals->sdrc;
	if (omap2_globals->sms)
		omap2_sms_base = omap2_globals->sms;
}

The initialization happens after checking for NULL, so even if you execute it or not, the variable are set to NULL in case of am33xx.

So I don't find any difference between runtime and this patch.

Thanks,
Vaibhav
