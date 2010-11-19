From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Fri, 19 Nov 2010 22:48:09 +0530
Message-ID: <9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com><1290131698-6194-9-git-send-email-nm@ti.com>
 <87eiahckba.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40480 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755309Ab0KSRSN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 12:18:13 -0500
Received: by mail-qw0-f53.google.com with SMTP id 7so207325qwf.40
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:18:13 -0800 (PST)
In-Reply-To: <87eiahckba.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, November 19, 2010 10:39 PM
> To: Nishanth Menon
> Cc: linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
> Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure
> RAM
>
> Nishanth Menon <nm@ti.com> writes:
>
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >
> > Deny MPU idle before save secure ram and allow it after save secure
RAM.
> > We want to deny MPU going to low power state because, there is a short
> > time window where a wakeup event would happen around the time the MPU
> > is going to idle. Since the first thing ROM code does after WFI is to
> > read INTCPS register, we could reach a situation where the INTCPS is
> > in idle, but the read is sent to it. That would produce a data abord
> > during the save of secure ram, which will hang the system. we need
> > to prevent clock transitions as well during this timeframe.
>
> This changelog needs to be a bit clearer about exacly why MPU would be
> going to a low power state during a secure-mode call.  IIUC, it's
> because the ROM code might do a WFI.  Since it's completely
> non-intuitive (and broken, at least to me) that the ROM code would do a
> WFI, this should be stated explicitly in the changelog, and probably in
> the code too.
>
> Also, this approach only solves this problem for this particular
> secure-mode call.  Presumably there are other secure-mode calls that
> might WFI as well, and will have the same problem. As I'm not familiar
> with secure ROM or PPAs, so I don't know if this is true or not.  If it
> is, then somethen more general should be done.
>
> Also, do we care about other powerdomains (besides MPU) going idle
> during a secure mode call?
>
> Because of those issues, some other proposals have been floated for this
> problem.  In particular, explicitly setting some of the powerdomain next
> states (at least MPU & CORE) to ON when we're not in the normal idle
> path so that would also prevent this problem.
>
> I guess we need some more details on which secure mode calls can trigger
> this problem.  If this is an isolated case, I'm OK with this fix.  If
> it's more general, I'd like to see a more general fix.
>
On the related topic I posted a patch some time back.
http://www.spinics.net/lists/linux-omap/msg37907.html
I guess Kevin is referring to the above patch.

Regards,
Santosh
