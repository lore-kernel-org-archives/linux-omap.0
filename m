From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Wed, 24 Nov 2010 15:39:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37716 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab0KXKJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 05:09:54 -0500
In-Reply-To: <1290589057.13243.22.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, November 24, 2010 2:28 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> 
> On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote:
> > Hi,
> >
> > While supporting one of customer I came across one interesting issue and
> finding with WAITFORVSYNC ioctl -
> >
> > Problem Statement -
> > -------------------
> > With WAITFORVSYNC lots of tearing artifacts are visible on LCD output,
> but WAITFORGO works fine without any issues.
> >
> > Debugging/Findings -
> > --------------------
> >
> > Technically both, WAITFORVSYNC and WAITFORGO wait on VSYNC interrupt -
> but there is slight difference in their implementation/processing.
> 
> No, that's not quite right.
> 
> WAITFORVSYNC waits for the next vsync.
> 
[Hiremath, Vaibhav] Yes, certainly.

> WAITFORGO waits until the the config changes for the particular overlay
> have been applied to the HW, which may take multiple vsyncs if there are
> already pending config changes. Or, if there are no changes to be
> applied, it doesn't wait at all.
> 
[Hiremath, Vaibhav] Yes, completely agreed. But in the panning use-case where if we assume there will be always config change when you enter WAIFORGO ioctl it waits for next VSYNC, and as you mentioned it may wait for multiple vsyncs to make sure that config change gets applied to HW.

> > WAITFORGO ioctl ensures that dirty & shadow_dirty flags (software flag)
> are cleared, making sure that hardware state and software state always
> stays in sync. It makes 4 attempts to do so - inside loop it checks for
> dirty flags and call wait_for_vsync API. In ideal usecase scenario it
> should come out in single iteration.
<snip>

> > Suggestions/Recommendation -
> > --------------------------
> >
> > From User application point of view, user won't care about driver
> internal implementation. Application believes that WAITFORVSYNC will only
> return after displaying (DMAing) previous buffer and now with addition to
> FBIO_WAITFORVSYNC standard ioctl interface this is very well expected from
> user application as a standard behavior.
> >
> > I would recommend having WAITFORGO like implementation under
> WAITFORVSYNC, merging WAITFORGO with WAITFORVSYNC, and killing WAITFORGO
> (since we have FBIO_WAITFORVSYNC standard ioctl).
> > Also WAITFORGO ioctl is OMAP specific custom ioctl.
> 
> I have to say that I'm not quite sure what WAITFORVSYNC should do. 
[Hiremath, Vaibhav] Me neither.

> The
> name implies that it should wait for the next vsync, which is what it
> does for omapfb.
> 

> Changing it to WAITFORGO would alter the behaviour. Sometimes it would
> not wait at all, sometimes it could wait for multiple vsyncs.
[Hiremath, Vaibhav] I am quite not sure, whether it makes sense from application point of view to wait for vsync if config is not changed. What could be the use-case for such requirement, where application won't change anything but still would like to wait on vsync?

And as far as wait on multiple vsync is concerned, it does make sense to coat "WAITFORVSYNC ioctl makes sure that your change got applied to HW". 

I am not aware of other architectures, but I believe this is something OMAP specific stuff. And for other platforms, WAITFORVSYNC means changes applied to HW (why does apps care about whether it is vsync or anything else?).

Thanks,
Vaibhav

> 
> But I see the problem. Perhaps we should have a WAITFORVSYNC which would
> wait until the changes are applied, or the next VSYNC if there are no
> changes. That doesn't quite sound like what WAITFORVSYNC name implies,
> but it would perhaps be more right (from users point of view) than the
> current implementation.
> 
>  Tomi
> 

