From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH] PWM: Add support for configuring polarity of PWM
Date: Tue, 24 Jul 2012 08:37:10 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E972880@DBDE01.ent.ti.com>
References: <1342616053-7793-1-git-send-email-avinashphilip@ti.com>
 <20120723083032.GA12868@avionic-0098.mockup.avionic-design.de>
 <500DB0CB.1000600@metafoo.de>
 <20120724065121.GA30417@avionic-0098.mockup.avionic-design.de>
 <500E5BED.6050401@metafoo.de>
 <20120724082624.GA4476@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120724082624.GA4476@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 24, 2012 at 13:56:24, Thierry Reding wrote:
> On Tue, Jul 24, 2012 at 10:25:17AM +0200, Lars-Peter Clausen wrote:
> > On 07/24/2012 08:51 AM, Thierry Reding wrote:
> > > 
> > > How about the following?
> > > 
> > > /**
> > >  * enum pwm_polarity - polarity of a PWM signal
> > >  * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
> > >  *   cycle, followed by a low signal for the remainder of the pulse
> > >  *   period
> > >  * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
> > >  *   cycle, followed by a high signal for the remainder of the pulse
> > >  *   period
> > >  */
> > > enum pwm_polarity {
> > > 	PWM_POLARITY_NORMAL,
> > > 	PWM_POLARITY_INVERSED,
> > > };
> > > 
> > 
> > Looks fine :)
> 
> Philip: can you fold this into your patch?

Sure. I will add.

Thanks
Avinash

> 
> Thierry
> 
