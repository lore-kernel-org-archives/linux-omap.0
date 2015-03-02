From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] OMAP: DSS: DPI: disable vt-switch on suspend/resume.
Date: Mon, 2 Mar 2015 22:03:49 +0100
Message-ID: <20150302210349.GE13270@amd>
References: <20150225203708.0eb2fa96@notabene.brown>
 <54ED9DF8.8030105@ti.com>
 <20150226092646.7e20df30@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226092646.7e20df30@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-omap@vger.kernel.org

Hi!

> > Looking at the drivers/tty/vt/vt_ioctl.c, it sounds to me that we should
> > always do pm_set_vt_switch(0), as omapdss restores everything just fine
> > on resume. Although it makes me wonder how it works if there are two
> > display controllers, one needing the switch and the other not...
> 
> I wondered that too.  It would seem to make more sense for
> pm_set_vt_switch(0) to be the default, that drivers which need the textmode
> switch should call (1).  But I suspect there are "historical reasons" for the
> current situation.

Well... historically, we did not have drivers for graphics cards --
kernel did not know how to handle it, only X knew. For cards that do
not have kernel driver, only X one, we need to switch vts.

For cards that have proper driver, we should be able to survive
without VT switch.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
