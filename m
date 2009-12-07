From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] Board file of Always Innovating OMAP3-based Touch
 Book
Date: Mon, 7 Dec 2009 13:49:07 -0800
Message-ID: <20091207214907.GK24013@atomide.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <19F8576C6E063C45BE387C64729E739404370D6FAB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54468 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbZLGVtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 16:49:04 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404370D6FAB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Gregoire Gentil <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tim Yamin <plasmaroo@gmail.com>

Hi,

* Hiremath, Vaibhav <hvaibhav@ti.com> [091119 20:19]:
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Gregoire Gentil
> > Sent: Thursday, November 19, 2009 10:48 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Gregoire Gentil; Tony Lindgren; Tim Yamin
> > Subject: [PATCH 2/8] Board file of Always Innovating OMAP3-based
> > Touch Book
> >
> >
> > Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3touchbook.c |  683
> > ++++++++++++++++++++++++++++
> >  1 files changed, 683 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c
> > b/arch/arm/mach-omap2/board-omap3touchbook.c
> > new file mode 100644
> > index 0000000..ad3ef6e
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-omap3touchbook.c

<snip>

> > +static int touchbook_backlight_brightness = 50;
> > +static struct omap_dm_timer *touchbook_backlight_pwm;
> > +
> > +static int touchbook_backlight_read(struct backlight_device *bd)
> > +{
> > +     return touchbook_backlight_brightness;
> > +}
> > +
> > +static int touchbook_backlight_update(struct backlight_device *bd)
> > +{
> > +     int value = bd->props.brightness;
> > +     touchbook_backlight_brightness = value;
> > +
> [Hiremath, Vaibhav] I think we can get rid of variable "value" here. You can directly initialize it to "touchbook_backlight_brightness".
> 
> One more thing just came in my mind, have you thought of using standard backlight class driver???

I'll add this without the backlight code so we get the basic
support into mainline while using the backlight class driver
issue is being discussed.

Tony
