From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 02/20] omapfb: Add support for
	MIPI-DCS compatible LCDs
Date: Tue, 9 Jun 2009 14:15:22 +0300
Message-ID: <20090609111522.GA29478@localhost>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com> <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com> <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com> <20090608004324.6c5ecf17.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31200 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbZFILQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 07:16:04 -0400
Content-Disposition: inline
In-Reply-To: <20090608004324.6c5ecf17.krzysztof.h1@poczta.fm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Antonino Daplas <adaplas@gmail.com>, Juha Yrjola <juha.yrjola@solidboot.com>, Imre Deak <imre.deak@solidboot.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Tony Lindgren <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Jun 08, 2009 at 12:43:24AM +0200, ext Krzysztof Helt wrote:
> On Thu,  4 Jun 2009 20:52:27 +0300
> Imre Deak <imre.deak@nokia.com> wrote:
>[...]
> > +
> > +#define to_mipid_device(p)		container_of(p, struct mipid_device, \
> > +						panel)
> > +struct mipid_device {
> > +	int		enabled;
> > +	int		model;
> 
> This one is only set and never read. A name is probably enough.

Ok, I'll remove model.

> 
> > +	int		revision;
> > +	u8		display_id[3];
> 
> This one should be a local variable.

Ok, I'll move it to the func where it's used.

> 
> > +	unsigned int	saved_bklight_level;
> > +	unsigned long	hw_guard_end;		/* next value of jiffies
> > +						   when we can issue the
> > +						   next sleep in/out command */
> > +	unsigned long	hw_guard_wait;		/* max guard time in jiffies */
> > +
> > +	struct omapfb_device	*fbdev;
> > +	struct spi_device	*spi;
> > +	struct mutex		mutex;
> > +	struct lcd_panel	panel;
> 
> How does it differ from fbdev->panel? Is it duplicated field?

fbdev->panel is a pointer to this device instance specific data. It's embedded here
so that we can get to struct mipid_device with the container_of macro when fbdev->panel
is passed to us.

> 
> I am sorry but I had not enough time to review the rest.

Thanks for the review, if there is nothing else I can post a new version with the
above changes.

--Imre

