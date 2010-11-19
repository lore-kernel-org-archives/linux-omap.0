From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 22:58:36 +0530
Message-ID: <7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com><1290131698-6194-9-git-send-email-nm@ti.com>
 <87eiahckba.fsf@deeprootsystems.com> <9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
 <4CE6B2D4.1030201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57242 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755637Ab0KSR2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 12:28:38 -0500
Received: by qwh5 with SMTP id 5so1867119qwh.34
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:28:38 -0800 (PST)
In-Reply-To: <4CE6B2D4.1030201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Friday, November 19, 2010 10:55 PM
> To: Santosh Shilimkar
> Cc: Kevin Hilman; linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
> Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure
> RAM
>
> Santosh Shilimkar had written, on 11/19/2010 11:18 AM, the following:
> [..]
> >> I guess we need some more details on which secure mode calls can
> trigger
> >> this problem.  If this is an isolated case, I'm OK with this fix.  If
> >> it's more general, I'd like to see a more general fix.
> >>
> > On the related topic I posted a patch some time back.
> > http://www.spinics.net/lists/linux-omap/msg37907.html
> > I guess Kevin is referring to the above patch.
> I believe the fix we are attempting here is for a specific scenario
> which IMHO is different from the issue solved in the link above.

It will also solve the above issue indirectly.
