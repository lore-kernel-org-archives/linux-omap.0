From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init()
 code
Date: Thu, 24 Feb 2011 01:49:50 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102240133550.6198@utopia.booyaka.com>
References: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102230015480.22636@utopia.booyaka.com> <4D651791.8000900@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-56157923-1298537390=:6198"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58427 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab1BXItv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 03:49:51 -0500
In-Reply-To: <4D651791.8000900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-56157923-1298537390=:6198
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Salut Beno=EEt,

On Wed, 23 Feb 2011, Cousson, Benoit wrote:

> This is indeed a little bit cleaner to init only the timer hwmod in the t=
imer
> code, but I'm still wondering it it worth the extra complexity.
>=20
> As soon as we have one hwmod to initialize, why cannot we initialize the =
whole
> list like before?

Tony has mentioned that he wishes to move any code unnecessary for early=20
initialization to late in the boot process.  This patch series was an=20
attempt to do that with the current usage of the hwmod code.

> If tomorrow we want to handle PRCM and control module using hwmod, like I=
'd
> like to do, we will have to init these hwmods early as well.
> Even earlier that init_early for the control module at least.

Yes, that makes sense to me.  I'd suggest that the best time to deal with=
=20
that is when the patches to handle PRCM and the SCM via hwmod are done. =20
Then we would have a clear example of the need to move that code earlier.

> And then we will have a bunch of different init paths from different=20
> parts of the boot sequence that might become tricky to handle.

If we're just initializing individual hwmods right before we use them in=20
the early boot process, I hope this won't become too big of a problem.
But perhaps you are foreseeing a problem which I am not?


- Paul
--155748971-56157923-1298537390=:6198--
