From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH v4] DSPBRIDGE: Fix to avoid possible recursive locking
Date: Thu, 18 Feb 2010 14:36:01 -0600
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0130EBC3B9@dlee02.ent.ti.com>
References: <1265925284-7536-1-git-send-email-deepak.chitriki@ti.com>
 <1265926841.26484.0.camel@chotu.research.nokia.com>
 <7A436F7769CA33409C6B44B358BFFF0C0130998163@dlee02.ent.ti.com>
 <4B7D8659.5030609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40469 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735Ab0BRUgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 15:36:09 -0500
In-Reply-To: <4B7D8659.5030609@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Guzman Lugo, Fernando" <x0095840@ti.com>


> -----Original Message-----
> From: Ramirez Luna, Omar
> Sent: Thursday, February 18, 2010 8:27 PM
> To: Menon, Nishanth
> Cc: Ameya Palande; Chitriki Rudramuni, Deepak; linux-omap; Guzman Lugo,
> Fernando
> Subject: Re: [PATCH v4] DSPBRIDGE: Fix to avoid possible recursive locking
> 
> On 2/17/2010 10:09 AM, Menon, Nishanth wrote:
> > Hi,
> >
> >> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> >> Sent: Friday, February 12, 2010 12:21 AM
> >> To: Chitriki Rudramuni, Deepak
> >> Cc: linux-omap; Ramirez Luna, Omar; Menon, Nishanth
> >> Subject: Re: [PATCH v4] DSPBRIDGE: Fix to avoid possible recursive
> locking
> >>
> >> On Thu, 2010-02-11 at 22:54 +0100, ext Deepak Chitriki wrote:
> >>> Removed NTFY_Notify() in WMD_MSG_Get() to avoid locking contention
> >>> as NTFY_Notify() is already invoked in InputMsg().
> >>>
> >>> Cc: Ameya Palande<ameya.palande@nokia.com>
> >>> Cc: Omar Ramirez Luna<omar.ramirez@ti.com>
> >>> Cc: Nishanth Menon<nm@ti.com>
> >>>
> >>> Signed-off-by: Deepak Chitriki<deepak.chitriki@ti.com>
> >>
> >> Acked-by: Ameya Palande<ameya.palande@nokia.com>
> >
> > Could this patch be pushed if there are no more comments?
> 
> Instead of pushing this patch I'll be reverting this one:
> 
> http://marc.info/?l=linux-omap&m=125694410627720&w=2
> 
> Explanation:
> 
> After reviewing the scenario it seems that the patch "fixing a flood of
> messages usecase" doesn't seem to be the proper way to fix it.
> 
> If the dsp sends 10 messages in a shot for the same client and bridge
> process them without interrupt, if the client is using
> DSPManager_WaitForEvents, InputMsg function will notify of all of them
> but "WaitForEvents" will only catch one notification, then client will
> call GetMsg ioctl and pick one message from the queue leaving 9 of them
> still there, whenever WaitForEvents is executed again there won't be a
> Notification if the dsp stopped sending messages to the same queue, so
> those 9 messages never will be retrieved because WaitForEvents will
> timeout.
> 
> The fix was only to re-notify the client that a message was still
> available in its queue and that it needs to pick it up, all of this
> during GetMsg, however this seems to be triggering a kernel warning
> because of nested spinlocks called for separate objects.
> 
> The reason to avoid pushing this patch is that it is leaving a part of
> the code introduced by the "flooding" fix.
> 
> Please let me know if anyone has comments.

So, do we have a clean complete fix? Why not leave the partial fix which we have in place and incorporate the clean fix on top of that?  I would prefer to have something here instead of nothing at all.. but that is just me.

> 
> - omar

Regards,
Nishanth Menon
