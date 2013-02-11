From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v3 9/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Mon, 11 Feb 2013 05:10:36 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED12D23@DBDE01.ent.ti.com>
References: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
 <1359458108-8489-10-git-send-email-vaibhav.bedia@ti.com>
 <alpine.DEB.2.00.1302081415540.11464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46723 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab3BKFKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Feb 2013 00:10:46 -0500
In-Reply-To: <alpine.DEB.2.00.1302081415540.11464@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Paul,

On Fri, Feb 08, 2013 at 19:47:04, Paul Walmsley wrote:
> Hi Vaibhav,
> 
> a comment on this one:
> 
> On Tue, 29 Jan 2013, Vaibhav Bedia wrote:
> 
> > Add minimal APIs for writing to the IPC and the M3_TXEV registers
> > in the Control module. These will be used in a subsequent patch which
> > adds suspend-resume support for AM33XX.
> > 
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> > ---
> > v3: Add Peter's Acked-by
> > v2: No change
> > 
> >  arch/arm/mach-omap2/control.c | 20 ++++++++++++++++++++
> >  arch/arm/mach-omap2/control.h | 41 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> > index 2adb268..c5d54ae 100644
> > --- a/arch/arm/mach-omap2/control.c
> > +++ b/arch/arm/mach-omap2/control.c
> > @@ -604,3 +604,23 @@ int omap3_ctrl_save_padconf(void)
> >  }
> >  
> >  #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
> > +
> > +#if defined(CONFIG_SOC_AM33XX) && defined(CONFIG_PM)
> > +void am33xx_txev_eoi(void)
> > +{
> > +	omap_ctrl_writel(AM33XX_M3_TXEV_ACK, AM33XX_CONTROL_M3_TXEV_EOI);
> > +}
> > +
> > +void am33xx_txev_enable(void)
> > +{
> > +	omap_ctrl_writel(AM33XX_M3_TXEV_ENABLE, AM33XX_CONTROL_M3_TXEV_EOI);
> > +}
> > +
> > +void am33xx_wkup_m3_ipc_cmd(struct am33xx_ipc_data *data)
> > +{
> > +	omap_ctrl_writel(data->resume_addr, AM33XX_CONTROL_IPC_MSG_REG0);
> > +	omap_ctrl_writel(data->sleep_mode, AM33XX_CONTROL_IPC_MSG_REG1);
> > +	omap_ctrl_writel(data->param1, AM33XX_CONTROL_IPC_MSG_REG2);
> > +	omap_ctrl_writel(data->param2, AM33XX_CONTROL_IPC_MSG_REG3);
> > +}
> 
> Could you please add some kerneldoc-style comments to these functions so 
> others can understand what they're intended to do, any side-effects they 
> have, any prerequisites, etc.?
> 

Sure. Will do that in the next version and post it separately.

Thanks,
Vaibhav
