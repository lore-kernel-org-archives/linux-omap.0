From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 4/9] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with
 the right flags
Date: Mon, 21 Jan 2013 05:27:16 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF09D6@DBDE01.ent.ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
 <1358493569-17142-5-git-send-email-vaibhav.bedia@ti.com>
 <50F94001.5050703@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46532 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3AUF1d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 00:27:33 -0500
In-Reply-To: <50F94001.5050703@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 18, 2013 at 17:58:49, Sergei Shtylyov wrote:
> Hello.
> 
> On 18-01-2013 11:19, Vaibhav Bedia wrote:
> 
> > Third Party Transfer Controller (TPTC0) needs to be idled and
> > put to standby under SW control. Add the appropriate flags in
> > the TPTC0 hwmod entry.
> 
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Change from RFC version:
> > 	Clarify TPTC in the changelog
> 
> >   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
> >   1 files changed, 1 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > index 8280f11..f2f408c 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > @@ -1823,6 +1823,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
> >   	.class		= &am33xx_tptc_hwmod_class,
> >   	.clkdm_name	= "l3_clkdm",
> >   	.mpu_irqs	= am33xx_tptc0_irqs,
> > +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
> 
>     Parens not needed here.
> 

Will drop it in v2.

Regards,
Vaibhav 

