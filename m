From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] pinctrl: dra: dt-bindings: Fix output pull up/down
Date: Mon, 10 Nov 2014 14:29:52 -0800
Message-ID: <20141110222951.GY31454@atomide.com>
References: <1414752745-13696-1-git-send-email-rogerq@ti.com>
 <1415009392-6627-1-git-send-email-rogerq@ti.com>
 <545A5A05.6050500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16080 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaKJWag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 17:30:36 -0500
Content-Disposition: inline
In-Reply-To: <545A5A05.6050500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Nishanth Menon <nm@ti.com> [141105 09:12]:
> On 11/03/2014 04:09 AM, Roger Quadros wrote:
> > For PIN_OUTPUT_PULLUP and PIN_OUTPUT_PULLDOWN we must not set the
> > PULL_DIS bit which disables the PULLs.
> > 
> > PULL_ENA is a 0 and using it in an OR operation is a NOP, so don't
> > use it in the PIN_OUTPUT_PULLUP/DOWN macros.
> > 
> > Fixes: 23d9cec07c58 ("pinctrl: dra: dt-bindings: Fix pull enable/disable")
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  include/dt-bindings/pinctrl/dra.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
> > index 3d33794..7448edf 100644
> > --- a/include/dt-bindings/pinctrl/dra.h
> > +++ b/include/dt-bindings/pinctrl/dra.h
> > @@ -40,8 +40,8 @@
> >  
> >  /* Active pin states */
> >  #define PIN_OUTPUT		(0 | PULL_DIS)
> > -#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
> > -#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
> > +#define PIN_OUTPUT_PULLUP	(PULL_UP)
> > +#define PIN_OUTPUT_PULLDOWN	(0)
> >  #define PIN_INPUT		(INPUT_EN | PULL_DIS)
> >  #define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
> >  #define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
> > 
> 
> 
> There might be additional updates needed to DRA7 pinctrl sequencing
> requirements based on latest documentation:
> 
> http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf#page=4004&zoom=auto,0,274.1
> 
> But, that has nothing to do with the bug that is currently being fixed
> in this patch,.
> 
> So, for the record:
> Acked-by: Nishanth Menon <nm@ti.com>

OK applying into omap-for-v3.18/fixes thanks.

Tony
