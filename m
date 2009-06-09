From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Tue, 09 Jun 2009 12:29:59 +0300 (EEST)
Message-ID: <20090609.122959.115911409.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2F73A252@dlee03.ent.ti.com>
	<20090609.100205.189719255.Hiroshi.DOYU@nokia.com>
	<94a0d4530906090216q29491dd0g803ef197a9247673@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17607 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbZFIJaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 05:30:11 -0400
In-Reply-To: <94a0d4530906090216q29491dd0g803ef197a9247673@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: h-kanigeri2@ti.com, omar.ramirez@ti.com, ameya.palande@nokia.com, linux-omap@vger.kernel.org

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Tue, 9 Jun 2009 11:16:52 +0200

> On Tue, Jun 9, 2009 at 10:02 AM, Hiroshi DOYU<Hiroshi.DOYU@nokia.com> wrote:
> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> > Subject: RE: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
> > Date: Mon, 8 Jun 2009 22:49:21 +0200
> >
> >> Hi Doyu-san,
> >>
> >> Regarding
> >>
> >> > http://marc.info/?l=linux-omap&m=124201773423892&w=2
> >> > I think that the first one should be merged into d.o-z.org now, but
> >> > for the second one about 128 byte alignment. let me know your
> >> > thought/plan on it.
> >>
> >> -- I think you sent this patch as a probable fix for the slab
> >> corruption that was observed in Bridge driver, but then we found
> >> that slab corruption was due to some other issue in Bridge driver
> >> and not due to the cache alignment.
> >>
> >> Irrespective of above point, I think it is good to enforce the cache
> >> alignment check, but I think the check should be in Proc Map
> >> function and to start with the check should be under a flag so as
> >> not to affect some MM applications that use padding to get over the
> >> alignment issue.
> >
> > I think that having configurable option may be reasonable practically,
> > at the moment.
> >
> > But how about the longer term solution? Do you have any plan on how to
> > deal with this? (ex: TI's OMX layer and some other userland client) Do
> > you continue the userland buffer padding solution for the futer
> > release?
> 
> I don't know about TI's OMX layer, but I'm working on some direct
> GStreamer wrappers that already do the proper alignment.

I expect that it will bring huge performance benfit.

> My plan currently is to keep working on gst-dsp until we have all the
> elements we need. After that's done we will be able to turn on the
> check in the kernel.
> 
> Then, if I have time I might port the changes to TI's omx il.

Both would be necessary for real products.

> 
> Cheers.
> 
> -- 
> Felipe Contreras
