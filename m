From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Wed, 9 May 2012 16:37:46 -0700
Message-ID: <20120509233745.GZ5088@atomide.com>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
 <20120509221447.GY5088@atomide.com>
 <CA+Bv8Xa+1RJ5QTn=vO4GSw1VtUZc3xX0J5qBVshvV5Dj+9uZVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51978 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758810Ab2EIXhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 19:37:48 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8Xa+1RJ5QTn=vO4GSw1VtUZc3xX0J5qBVshvV5Dj+9uZVA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Russ Dill <Russ.Dill@ti.com> [120509 15:53]:
> On Wed, May 9, 2012 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Russ Dill <Russ.Dill@ti.com> [120509 15:12]:
> >> The Beagleboard xM gpio used for TFP410 powerdown is connected through
> >> an I2C attached chip which means setting the GPIO can sleep. Code that
> >> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.
> >
> > What's the error without this patch? Or just no display?
> >
> > Just wondering if it's safe to merge Tomi's clean up series to
> > arm-soc tree..
> 
> The only platform that has a problem is Beagleboard xM, and that is
> only after 'ARM: OMAP: Cleanup Beagleboard DVI reset gpio' is applied.
> Since the context actually can sleep, the only consequence is a
> WARN_ON statement.
> 
> So yes, it should be safe.

Well since I have not actually merged it with other branches yet, I'll wait
for Tomi to apply that and repull his for-l-o-3.5 branch.

Tony
