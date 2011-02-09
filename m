From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 03/13] OMAP: Implement Basic DVFS
Date: Wed, 9 Feb 2011 21:54:47 +0530
Message-ID: <0b1874d1e5cbf4292aaccccd14231fd1@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-4-git-send-email-vishwanath.bs@ti.com><87mxmcy51u.fsf@ti.com><da15cb476bc1779775448cc5dcd372f3@mail.gmail.com>
 <87sjvxdwrf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33987 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752586Ab1BIQY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 11:24:56 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so389067fxm.26
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 08:24:54 -0800 (PST)
In-Reply-To: <87sjvxdwrf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Wednesday, February 09, 2011 9:30 PM
> To: Vishwanath Sripathy
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Thara Gopinath
> Subject: Re: [PATCH 03/13] OMAP: Implement Basic DVFS
>
> Vishwanath Sripathy <vishwanath.bs@ti.com> writes:
>
> >> This needs a comment to, but I'm not sure I understand what's going
> on
> >> here.  What it seems like:
> >>
> >> if this device has no OPP for this voltage, just silently move on to
the
> >> next device?   doesn't seem quite right, but not sure I fully grok
the
> >> failure modes of omap_dvfs_find_voltage()
> >
> > Yes, your understanding is right. omap_dvfs_find_voltage will return
> error
> > if the device does not have an OPP table.
> > Typically devices should not register with a vdd (using
> > omap_dvfs_register_device) if it has no OPP table associated with it.
> So
> > ideally we should not hit this error case. But only exception so far
is SR
> > driver. SR hwmod has vdd_name field set so as to get voltagedomain
> > pointers. But SR does not have any opp table. So there is no harm in
> > ignoring the error and moving to next device.
>
> And what happens when other devices add voltage domains but don't
> have
> OPP tables?
If someone does not have a OPP table, that means it's not a scalable
device, so there is no need to scale that device.

Vishwa
>
> The point is that this error handling is 1) difficult to understand upon
> first (or fifth) read and 2) very fragile with other changes.
>
> Kevin
