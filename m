From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] Board file of Always Innovating OMAP3-based Touch
 Book
Date: Mon, 7 Dec 2009 15:19:04 -0800
Message-ID: <20091207231904.GO24013@atomide.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <19F8576C6E063C45BE387C64729E739404370D6FAB@dbde02.ent.ti.com>
 <20091207214907.GK24013@atomide.com>
 <792f5f410912071411i5ebfec90n419a38ca4245e694@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59216 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935663AbZLGXTC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 18:19:02 -0500
Content-Disposition: inline
In-Reply-To: <792f5f410912071411i5ebfec90n419a38ca4245e694@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Yamin <plasmaroo@gmail.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Gregoire Gentil <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tim Yamin <plasmaroo@gmail.com> [091207 14:10]:
> 2009/12/7 Tony Lindgren <tony@atomide.com>:
> >> One more thing just came in my mind, have you thought of using standard backlight class driver???
> >
> > I'll add this without the backlight code so we get the basic
> > support into mainline while using the backlight class driver
> > issue is being discussed.
> 
> But the board file *is* implementing the standard backlight class,
> i.e. the interface in linux/backlight.h... perhaps I'm
> misunderstanding the intention here?

Hmm, yeah. Hiremath care to clarify what you had in mind
with that standard backlight class driver comment?

Regards,

Tony
