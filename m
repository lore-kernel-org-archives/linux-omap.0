From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/8] Board file of Always Innovating OMAP3-based Touch
 Book
Date: Tue, 8 Dec 2009 21:49:18 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043721059D@dbde02.ent.ti.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <19F8576C6E063C45BE387C64729E739404370D6FAB@dbde02.ent.ti.com>
 <20091207214907.GK24013@atomide.com>
 <792f5f410912071411i5ebfec90n419a38ca4245e694@mail.gmail.com>
 <20091207231904.GO24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52520 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbZLHQTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 11:19:18 -0500
In-Reply-To: <20091207231904.GO24013@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>
Cc: Gregoire Gentil <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, December 08, 2009 4:49 AM
> To: Tim Yamin
> Cc: Hiremath, Vaibhav; Gregoire Gentil; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/8] Board file of Always Innovating OMAP3-based
> Touch Book
> 
> * Tim Yamin <plasmaroo@gmail.com> [091207 14:10]:
> > 2009/12/7 Tony Lindgren <tony@atomide.com>:
> > >> One more thing just came in my mind, have you thought of using
> standard backlight class driver???
> > >
> > > I'll add this without the backlight code so we get the basic
> > > support into mainline while using the backlight class driver
> > > issue is being discussed.
> >
> > But the board file *is* implementing the standard backlight class,
> > i.e. the interface in linux/backlight.h... perhaps I'm
> > misunderstanding the intention here?
> 
> Hmm, yeah. Hiremath care to clarify what you had in mind
> with that standard backlight class driver comment?
> 
[Hiremath, Vaibhav] I was referring to generic_bl driver? Actually when I had submitted the similar patch for OMAP3EVM, I had received similar comment to use generic_bl interface.

In your case, you just need to do something - 


static void touchbook_set_backlight(int intensity)
{
....
}
static struct generic_bl_info touchbook_bl_platform_data = {
	.name			= " touchbook-bklight",
	.max_intensity		= 100,
	.default_intensity	= 50,
	.limit_mask		= 0,
	.set_bl_intensity	= touchbook_set_backlight,
	.kick_battery		= NULL,
};

static struct platform_device touchbook_bklight_device = {
	.name		= "generic-bl",
	.id		= -1,
	.dev		= {
		.platform_data	= & touchbook_bl_platform_data,
	},
};


Thanks,
Vaibhav

> Regards,
> 
> Tony
