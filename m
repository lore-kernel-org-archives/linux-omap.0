From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Sat, 20 Nov 2010 15:32:32 +0530
Message-ID: <ef750caa9d50a66e559e586103292c48@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com><1290131698-6194-9-git-send-email-nm@ti.com><87eiahckba.fsf@deeprootsystems.com><9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com><4CE6B2D4.1030201@ti.com><7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com><877hg9ayox.fsf@deeprootsystems.com>
 <4CE6DB9E.9000708@ti.com><87y68p3uee.fsf@deeprootsystems.com>
 <4CE6E5CE.7010502@ti.com> <87sjyx2f73.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47753 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333Ab0KTKCf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Nov 2010 05:02:35 -0500
Received: by qwd7 with SMTP id 7so685466qwd.40
        for <linux-omap@vger.kernel.org>; Sat, 20 Nov 2010 02:02:34 -0800 (PST)
In-Reply-To: <87sjyx2f73.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Saturday, November 20, 2010 2:40 AM
> To: Nishanth Menon
> Cc: Santosh Shilimkar; linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
> Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure
> RAM
>
> Nishanth Menon <nm@ti.com> writes:
>
> > Kevin Hilman had written, on 11/19/2010 02:55 PM, the following:
> > [...]
> >> Now, based on what you say below, it seems like there is no way to
> >> guarantee that SMIs don't do this, so I guess we have no choice but
to
> >> protect them all.
> > In that way, I do like the patch from Santosh - with the relevant
> > changes we will need to incorporate. Do keep in mind that SMI is a
> > secure service - In theory, there could be(and to my knowledge, are)
> > custom secure services to do all kind of other things that are not
> > power management related[1] -
>
> All the more reason that this secure mode code should be moved out of
> the core idle path into its own driver.
>
I also think this is better idea.
