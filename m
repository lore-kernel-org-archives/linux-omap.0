From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Sat, 20 Nov 2010 15:34:52 +0530
Message-ID: <4215db98181e039c2b9e80dd7051d932@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-9-git-send-email-nm@ti.com>
	<87eiahckba.fsf@deeprootsystems.com>	<9f54a2ec7fc8c27fc57c2aac9bad5405@mail.gmail.com>
	<4CE6B2D4.1030201@ti.com>	<7ae7a7b138d09fc819e16f213e81d3bd@mail.gmail.com>
	<4CE6C714.50209@ti.com> <877hg96oa5.fsf@deeprootsystems.com>
	<4CE6E405.9020309@ti.com> <871v6h3tx1.fsf@deeprootsystems.com> <4CE6E8E4.9060602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55491 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581Ab0KTKFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Nov 2010 05:05:07 -0500
Received: by qyk38 with SMTP id 38so554574qyk.2
        for <linux-omap@vger.kernel.org>; Sat, 20 Nov 2010 02:05:06 -0800 (PST)
In-Reply-To: <4CE6E8E4.9060602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Saturday, November 20, 2010 2:45 AM
> To: Kevin Hilman
> Cc: Santosh Shilimkar; linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
> Subject: Re: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure
> RAM
>
> Kevin Hilman had written, on 11/19/2010 03:06 PM, the following:
> > Nishanth Menon <nm@ti.com> writes:
> >
> >> Kevin Hilman had written, on 11/19/2010 02:39 PM, the following:
> >> [...]
> >>> In addtion, the patch from Santosh needs to better describe what
other
> >>> problems it is solving, since it is clearly not fixing this
particular
> >>> secure mode entry.  Therefore, there must be others that are also
> doing
> >>> WFI.   That being said, instead of such a generic fix as is done by
> >>> Santosh's patch, maybe we need a common secure-mode entry point
which
> >>> does the necessary ROM code prep.
> >> Ideally speaking - save_secure_ram can hit latencies which are pretty
> >> bad.. eventually this logic should be moved outside the current
> >> boundaries in some manner - unfortunately, I cant at the moment think
> >> of a sane mechanism to do that given various proprietary and
> >> not-mainlined-but-public security drivers for OMAP3 out there
> >> :(. IMHO, the responsibility of secure storage should be with secure
> >> drivers, but, at the moment touching that topic is opening up a
> >> pandora's box :(
> >
> > Hmm, so the complexity and mess is pushed into the OMAP PM core...
> >
> > /me no likey
> /me neither :(
>
> >
> >>>> This specific patch controls the clock domain from auto idling
around
> >>>> the secure ram save. Apologies on the confusion - but if the [1]
> patch
> >>>> is fixing it, you can help me understand how it does it.
> >>> Now that I understand the clockdomain part, I'm seeing the problem
> >>> differently.  (side note: A better written changelog could have
> avoided
> >>> this confusion by being clear that it was *clockdomain* idle that
was
> >>> being added here and that it was in addition to the existing
> powerdomain
> >>> settings.)
> >>>
> >>> Technically, $SUBJECT patch could have replaced the set_next_pwrst
> with
> >>> the clkdm_deny_idle.  IOW, setting the pwrdm next state to is
> redundant
> >>> if you clkdm_deny_idle.
> >>>
> >>> I think this is the key to the confusion:
> >>>
> >>> 1) clkdm_deny_idle() implies the powerdomain stays on
> >>> 2) setting powerdomain to on, does NOT imply clkdm_deny_idle()
> >>>
> >>> Another way of saying it is that setting a powerdomain to on does
not
> >>> prevent it from going inactive.  It only prevents retention or off-
> mode.
> >> Agreed and I apologize for the confusion caused by the commit message
> >> -
> >> will it be sufficient for the purpose of this series to change the
> >> commit log to better describe the patch? - I will leave the power
> >> domain control to Santosh's /Tero's series instead.
> >>
> >> Is this acceptable option?
> >
> > That is a minimum requirement,  but...
> >
> > Based on the rest of this series, I am not at all comfortable with
> > managing this directly in the idle path.  The latencies you mentioned
> > above are only part of the reason.  I have been trying to remove this
> Keep in mind that the latency is incurred by the default settings in
> this series *only* for the very first off mode currently.
>
> > kind of device idle/PM management from the core idle path and I am not
> > enthused about adding stuff back.
> >
> > I would much rather see a separate, secure-mode driver, which for
> > starters only manages secure RAM.  It doesn't have to manage all of
> > security stuff,  but it will make a clearer (and cleaner)
> > separation between the idle path and secure RAM management.  If
> > implemented as a driver, it could be much more intelligent about
> > its save/restore and can behave just like any other driver that has to
> > manage context save/restore.  If the concern is about trying to have a
> > general purpose "secure driver", then just call it a secure RAM driver
> > or something to be clear it has a small, targetted scope.
> There are few other issues with this approach. secure ram save by itself
> is just a function. it's trigger should ideally be not just one security
> driver IMHO - there is AES, SHAM, and other ones that will need to
> implement runtime pm, context save and restore hooks -> E.g. Dimitry's
> series[1] is trying to introduce an opensource security driver solution
> for OMAP - this is just a start - it will be some time before these
> drivers are ready and merged to mainline followed by power management
> enablement - do we want to keep omap3 broken while a fix is available
> till then?
>
I read the thread again. Indeed the change log confused me as well.
The original patch as such is ok then. I thought you want to prevent
MPU PD not to transition and that you are achieving by not allowing
MPU clock domain idle.

Then your patch seems to be right fix.

Regards
Santosh
