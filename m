From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl-core: Fix accessibility of some twl4030 audio
 registers
Date: Tue, 18 Mar 2014 10:26:51 -0700
Message-ID: <20140318172650.GA307@atomide.com>
References: <20140310191250.34f1410e@tomas.local.tbs-biometrics.cz>
 <531EC981.8090806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11213 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107AbaCRR0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 13:26:55 -0400
Content-Disposition: inline
In-Reply-To: <531EC981.8090806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tomas Novotny <tomas@novotny.cz>, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140311 01:33]:
> On 03/10/2014 08:12 PM, Tomas Novotny wrote:
> > There are some unused registers in twl4030 at I2C address 0x49 and function
> > twl4030_49_nop_reg() is used to check accessibility of that registers. These
> > registers are written in decimal format but the values are correct in
> > hexadecimal format. (It can be checked few lines above the patched code -
> > these registers are marked as unused there.)
> > 
> > As a consequence three registers of audio submodule are treated as
> > inaccessible (preamplifier carkit right and both handsfree registers).
> > 
> > CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > ---
> >  drivers/mfd/twl-core.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index ed71832..e87140b 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -282,11 +282,11 @@ static struct reg_default twl4030_49_defaults[] = {
> >  static bool twl4030_49_nop_reg(struct device *dev, unsigned int reg)
> >  {
> >  	switch (reg) {
> > -	case 0:
> > -	case 3:
> > -	case 40:
> > -	case 41:
> > -	case 42:
> > +	case 0x00:
> > +	case 0x03:
> > +	case 0x40:
> > +	case 0x41:
> > +	case 0x42:
> 
> Uhm, I can not be that @#$%^& that I did this... I have no idea how I left out
> the "0x"
> 
> Thanks for spotting it!
> 
> Acked-by Peter Ujfalusi <peter.ujfalusi@ti.com>

Peter, if this does not make it to the -rc series, care to send this to
the stable for inclusion after it hits mainline?

This fixes twl4030 audio regression at least on boards using HandsfreeL
for audio.

Regards,

Tony
