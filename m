From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
Date: Wed, 26 Dec 2012 06:31:14 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6D45@DBDE01.ent.ti.com>
References: <20121209200108.3196.12452.stgit@dusk.lan>
 <20121209200327.3196.27686.stgit@dusk.lan>
 <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53711 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab2LZGbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 01:31:20 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>

On Wed, Dec 26, 2012 at 11:51:46, Bedia, Vaibhav wrote:
> Hi Paul,
> 
> On Mon, Dec 10, 2012 at 01:33:28, Paul Walmsley wrote:
> > There's no need to determine the current power state for powerdomains
> > that must be on while the kernel is running.  We mark these
> > powerdomains with a new flag, PWRDM_ACTIVE_WITH_KERNEL.  Any
> > powerdomain marked with that flag is reported as being in the ON power
> > state while the kernel is running.
> [...]
> > diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
> > index 869adb8..acb148a 100644
> > --- a/arch/arm/mach-omap2/powerdomains33xx_data.c
> > +++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
> > @@ -123,7 +123,8 @@ static struct powerdomain mpu_33xx_pwrdm = {
> >  	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
> >  	.pwrsts			= PWRSTS_OFF_RET_ON,
> >  	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
> > -	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
> > +	.flags			= (PWRDM_HAS_LOWPOWERSTATECHANGE |
> > +				   PWRDM_ACTIVE_WITH_KERNEL),
> 
> In case of AM33xx, this flag should be set for PER and WKUP pwrdms also.
> EMIF, L3, L4 etc come under PER so this domain can't transition on an active
> system. PRCM and Control module come under WKUP, so

... the kernel should not attempt to change the WKUP power domain state.

Regards,
Vaibhav 

