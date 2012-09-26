From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 17/21] ARM: OMAP4: TWL: enable high speed mode for
 PMIC communication
Date: Wed, 26 Sep 2012 15:06:28 +0300
Message-ID: <1348661188.1956.1.camel@sokoban>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
	 <1348590833-12335-18-git-send-email-t-kristo@ti.com>
	 <5062E95C.6050903@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39298 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2IZMGe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 08:06:34 -0400
In-Reply-To: <5062E95C.6050903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-09-26 at 14:39 +0300, Peter Ujfalusi wrote:
> Hi Tero,
> 
> On 09/25/2012 07:33 PM, Tero Kristo wrote:
> > With the new parameters, I2C can now be put to high speed mode for
> > better performance.
> 
> We have twl6040 on the same bus. have you tried this with audio enabled?
> twl6040 is in standard mode (up to 100 kbps) after power up...

No, I don't have capability to try out audio. Can you give it a shot and
see what happens? Otherwise we probably just have to drop this patch out
for now.

-Tero

> 
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_twl.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> > index 611cb63..7ff9667 100644
> > --- a/arch/arm/mach-omap2/omap_twl.c
> > +++ b/arch/arm/mach-omap2/omap_twl.c
> > @@ -218,6 +218,7 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
> >  	.i2c_slave_addr		= OMAP4_SRI2C_SLAVE_ADDR,
> >  	.volt_reg_addr		= OMAP4_VDD_CORE_SR_VOLT_REG,
> >  	.cmd_reg_addr		= OMAP4_VDD_CORE_SR_CMD_REG,
> > +	.i2c_high_speed		= true,
> >  	.i2c_pad_load		= 3,
> >  	.vsel_to_uv		= twl6030_vsel_to_uv,
> >  	.uv_to_vsel		= twl6030_uv_to_vsel,
> > 
> 
> 


