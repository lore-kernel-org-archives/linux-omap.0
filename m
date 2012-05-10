From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Thu, 10 May 2012 09:16:04 -0700
Message-ID: <20120510161604.GC21851@atomide.com>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
 <20120509221447.GY5088@atomide.com>
 <CA+Bv8Xa+1RJ5QTn=vO4GSw1VtUZc3xX0J5qBVshvV5Dj+9uZVA@mail.gmail.com>
 <20120509233745.GZ5088@atomide.com>
 <1336632790.5182.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11040 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758236Ab2EJQQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 12:16:06 -0400
Content-Disposition: inline
In-Reply-To: <1336632790.5182.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120509 23:56]:
> On Wed, 2012-05-09 at 16:37 -0700, Tony Lindgren wrote:
> > * Russ Dill <Russ.Dill@ti.com> [120509 15:53]:
> > > On Wed, May 9, 2012 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > > * Russ Dill <Russ.Dill@ti.com> [120509 15:12]:
> > > >> The Beagleboard xM gpio used for TFP410 powerdown is connected through
> > > >> an I2C attached chip which means setting the GPIO can sleep. Code that
> > > >> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.
> > > >
> > > > What's the error without this patch? Or just no display?
> > > >
> > > > Just wondering if it's safe to merge Tomi's clean up series to
> > > > arm-soc tree..
> > > 
> > > The only platform that has a problem is Beagleboard xM, and that is
> > > only after 'ARM: OMAP: Cleanup Beagleboard DVI reset gpio' is applied.
> > > Since the context actually can sleep, the only consequence is a
> > > WARN_ON statement.
> > > 
> > > So yes, it should be safe.
> > 
> > Well since I have not actually merged it with other branches yet, I'll wait
> > for Tomi to apply that and repull his for-l-o-3.5 branch.
> 
> You can pull for-l-o-3.5 as it is now, there's no need to change it.
> This _cansleep change is a separate dss specific change.
> 
> So to summarize:
> 
> Currently the powerdown GPIO for tfp410 is handled in the board files
> (and called reset gpio), with gpio_set_value(). My cleanup series moves
> this to the tfp410 driver.
> 
> BB-xM needs to use gpio_set_value_cansleep() in tfp410 to function
> properly, so the tfp410 driver needs to be changed, as this patch does.
> I will take this patch to the dss tree.
> 
> So it's safe to pull my cleanup series, but if I understood correctly,
> applying Russ's "[PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset
> gpio" will cause WARN_ONs on BB-xM until this patch to tfp410 is also
> applied.
> 
> But it doesn't sound too serious, so I think it's safe to apply the
> "cleanup beagleboard dvi" patch also. The warning will go away when both
> l-o and dss trees are pulled in the merge window.

OK thanks will use for-l-o-3.5 as it is now then.

Tony
