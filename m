From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Wed, 24 Nov 2010 14:52:27 +0530
Message-ID: <dfe358793629e4b10d1a5007fb273164@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com><87r5edp3so.fsf@deeprootsystems.com><8ef3de873d51409a38f19becb0d339cb@mail.gmail.com>
 <87pqtveq1e.fsf@deeprootsystems.com> efb598510f2d2522872f58145c03910d@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58748 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149Ab0KXJWf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 04:22:35 -0500
Received: by mail-qw0-f41.google.com with SMTP id 8so1053541qwj.14
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 01:22:34 -0800 (PST)
In-Reply-To: efb598510f2d2522872f58145c03910d@mail.gmail.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

(Sorry. You will see two replies from me on your email)
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Wednesday, November 24, 2010 11:04 AM
> To: 'Kevin Hilman'
> Cc: Nishanth Menon; 'linux-omap'; 'Jean Pihet'; Vishwanath Sripathy;
> 'Tony'
> Subject: RE: [PATCH 00/13] OMAP3: OFF mode fixes
>
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Kevin Hilman
> > Sent: Wednesday, November 24, 2010 2:06 AM
> > To: Santosh Shilimkar
> > Cc: Nishanth Menon; linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
> > Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
> >
[...]
> > > And we should treat ROM code as a hardware. Secure services
> > > don't give  you garrulity of saving per each secure module. To
> > > get CPU OFF working on secure device, secure RAM must be saved.
> > > So I still think it is CPU specific code and pretty much relevant
> > > to CPU IDLE OFF state considering ROM code.
> > > Ofcourse this not related to GP device because we never enter Secure
> > > world again after the boot-up.
> > > So moving this code to a separate file is fine but it still related
> > > to CPU.
> >
> > Sure, it's still *related* to the CPU, but what I am arguing is that
it
> > should not be related to CPU *idle*.
> >
> > My undersanding is this (please correct me):
> >
> > Secure RAM context only needs to be saved/updated when something in it
> > changes changes (e.g. secure driver usage.)  Therefore, any
> > driver/device usage that has a side effect of changing secure RAM
should
> > be responsible for updating secure RAM.
> >
> This assumption holds true largely but not completely. There are more
> Secure APIs which are outside of any secure driver usage which can also
> alter the state of secure RAM. OMAP4, we have more APIs apart from
secure
> RAM where the secure HW registers, firewalls, cache controllers,
interrupt
> controllers are managed using secure APIs. All of this is must for
correct
> CPU OFF functioning.
>
> > The approach taken in $SUBJECT series is basically: since we don't
know
> > who is using/changing secure RAM, we better save it (or have the
option
> > to) during every off-mode transition.  This approach is what I do not
> > like.  It's pushing work (and intellegence) that should be in the
> > drivers into the PM core where it does not belong.
> >
> The problem is because the secure RAM is not portioned per device basis
> but managed as a whole. If we had per secure device portioning then the
> respective device drivers saving it's context would have worked
perfectly.
> And the fact is it's not the secure device driver context, but it's a
> Secure software context which runs in parallel with HLOS on HS devices.
>
> > Rather, I want to follow the same approach we follow for every other
> > device driver.  Drivers must assume they can lose context.  Therefore
> > it's up to them to save it.
> >
> > IOW, the drivers that *change* secure RAM should be responsible for
> > ensuring that any of the changes they make are saved.
> >
> As I mentioned above its not just the driver context but the whole
> secure software context. I will check with ROM team if it can be made
> more granular for future OMAPs so that we can have the usual strategy
> of respective components taking care of there save/restore. This will
> also save huge latency we incure while saving whole RAM on every MPU
> OFF transition.
>
I had a discussion with ROM team and they conformed that the secure
context can get changed with protected applications (PA for FW, secure
keys) as well as with secure drivers like crypto, aes etc.

This can be centralized and some APIs can be provided by the secure
middleware to know whether the context needs to be save or not.
Secure middleware manages all the secure driver interfaces as well
as PA's. This is the centralized place where all state knowledge is
available. This component also can take care of doing a secure context
save job based on needs. The only concern from them was that
which security middleware to be used is not fixed and its
upto customers to decide. Few of them develop this on there own.

So with clarity now, I concur with your idea of moving out the secure
context save from CPUIDLE code.
The only problem I see is how do we support multiple security
middleware's with a common infrastructure.

Regards
Santosh
