From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 02/20] omapfb: Add support for
 MIPI-DCS compatible LCDs
Date: Sun, 14 Jun 2009 23:48:45 +0200
Message-ID: <20090614234845.d7200c2c.krzysztof.h1@poczta.fm>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
	<fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
	<e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
	<20090608004324.6c5ecf17.krzysztof.h1@poczta.fm>
	<20090609111522.GA29478@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:16445 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447AbZFNVlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Jun 2009 17:41:04 -0400
In-Reply-To: <20090609111522.GA29478@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Deak <imre.deak@nokia.com>
Cc: Antonino Daplas <adaplas@gmail.com>, Juha Yrjola <juha.yrjola@solidboot.com>, Imre Deak <imre.deak@solidboot.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Tony Lindgren <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 9 Jun 2009 14:15:22 +0300
Imre Deak <imre.deak@nokia.com> wrote:

> Hi,
> 
> On Mon, Jun 08, 2009 at 12:43:24AM +0200, ext Krzysztof Helt wrote:
> > On Thu,  4 Jun 2009 20:52:27 +0300
> > Imre Deak <imre.deak@nokia.com> wrote:
> >[...]
> > > +
> > > +#define to_mipid_device(p)		container_of(p, struct mipid_device, \
> > > +						panel)
> > > +struct mipid_device {
> > > +	int		enabled;
> > > +	int		model;
> > 
> > This one is only set and never read. A name is probably enough.
> 
> Ok, I'll remove model.
> 
> > 
> > > +	int		revision;
> > > +	u8		display_id[3];
> > 
> > This one should be a local variable.
> 
> Ok, I'll move it to the func where it's used.
> 
> > 
> > > +	unsigned int	saved_bklight_level;
> > > +	unsigned long	hw_guard_end;		/* next value of jiffies
> > > +						   when we can issue the
> > > +						   next sleep in/out command */
> > > +	unsigned long	hw_guard_wait;		/* max guard time in jiffies */
> > > +
> > > +	struct omapfb_device	*fbdev;
> > > +	struct spi_device	*spi;
> > > +	struct mutex		mutex;
> > > +	struct lcd_panel	panel;
> > 
> > How does it differ from fbdev->panel? Is it duplicated field?
> 
> fbdev->panel is a pointer to this device instance specific data. It's embedded here
> so that we can get to struct mipid_device with the container_of macro when fbdev->panel
> is passed to us.
> 
> > 
> > I am sorry but I had not enough time to review the rest.
> 
> Thanks for the review, if there is nothing else I can post a new version with the
> above changes.
> 

Please post the series after I review your last patch. It should not take longer than two days.

Regards,
Krzysztof

----------------------------------------------------------------------
Przekaz dalej wiadomosc: Zawsze warto oszczedzac. Teraz 5,5%!
Sprawdz > http://link.interia.pl/f21b1

