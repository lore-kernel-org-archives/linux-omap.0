From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH] PWM: Add support for configuring polarity of PWM
Date: Tue, 24 Jul 2012 06:08:43 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9726A6@DBDE01.ent.ti.com>
References: <1342616053-7793-1-git-send-email-avinashphilip@ti.com>
 <20120723083032.GA12868@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E97189D@DBDE01.ent.ti.com>
 <20120723130825.GA21254@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971AE3@DBDE01.ent.ti.com>
 <20120723195249.GA7526@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40410 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755299Ab2GXGJt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 02:09:49 -0400
In-Reply-To: <20120723195249.GA7526@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

On Tue, Jul 24, 2012 at 01:22:49, Thierry Reding wrote:
> On Mon, Jul 23, 2012 at 03:05:26PM +0000, Philip, Avinash wrote:
> > On Mon, Jul 23, 2012 at 18:38:25, Thierry Reding wrote:
> > > On Mon, Jul 23, 2012 at 12:51:11PM +0000, Philip, Avinash wrote:
> > > > On Mon, Jul 23, 2012 at 14:00:32, Thierry Reding wrote:
> > > > > On Wed, Jul 18, 2012 at 06:24:13PM +0530, Philip, Avinash wrote:
> > > > > >  /*
> > > > > >   * pwm_enable - start a PWM output toggling
> > > > > >   */
> > > > > > @@ -37,6 +47,7 @@ struct pwm_chip;
> > > > > >  enum {
> > > > > >  	PWMF_REQUESTED = 1 << 0,
> > > > > >  	PWMF_ENABLED = 1 << 1,
> > > > > > +	PWMF_POLARITY_INVERSE = 1 << 2,
> > > > > 
> > > > > This should be named PWMF_POLARITY_INVERSED for consistency.
> > > > 
> > > > Ok I will correct it.
> > > > 
> > > > > I'm not sure that we really need this flag, though. It isn't used anywhere. But
> > > > > maybe you have a use-case in mind?
> > > > 
> > > > It can be used to find the polarity of the PWM at runtime.
> > > 
> > > Yes, but is there any use-case where this information would be required?
> > 
> > It's been added as a feature enhancement. May be it can ignore?
> 
> I think it can be removed for now. It can be added back if we ever
> really need it.

Ok. I will remove it.

Thanks
Avinash

> 
> Thierry
> 

