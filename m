From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [RFC PATCH 1/3] of/device: manage resources similar
 =?iso-8859-1?Q?to=0D?= platform_device_add
Date: Fri, 20 Mar 2015 11:29:54 +0000
Message-ID: <20150320112954.A3903C419C2@trevor.secretlab.ca>
References: <1420651854-17768-1-git-send-email-s-anna@ti.com>
	<1420651854-17768-2-git-send-email-s-anna@ti.com>
	<CAL_Jsq+79cnCiww6g8ejki0yT59-N8eucHC3QGMbsXG4DksWuQ@mail.gmail.com>
	<54B58D5D.5070508@ti.com>
	<CAL_JsqLW9PRktHntLquohH3x_bPgJrrn2Y2_8RYA_HnKhpTDHg@mail.gmail.com>
	<54B5A499.7060106@ti.com> <54C17087.7060003@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:34258 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbCTL36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 07:29:58 -0400
Received: by wegp1 with SMTP id p1so79726325weg.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2015 04:29:57 -0700 (PDT)
In-Reply-To: <54C17087.7060003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 22 Jan 2015 15:49:59 -0600
, Suman Anna <s-anna@ti.com>
 wrote:
> Hi Grant,
> 
> On 01/13/2015 05:04 PM, Suman Anna wrote:
> > On 01/13/2015 04:00 PM, Rob Herring wrote:
> >> On Tue, Jan 13, 2015 at 3:25 PM, Suman Anna <s-anna@ti.com> wrote:
> >>> Hi Rob,
> >>>
> >>> On 01/13/2015 02:38 PM, Rob Herring wrote:
> >>>> On Wed, Jan 7, 2015 at 11:30 AM, Suman Anna <s-anna@ti.com> wrote:
> >>>>> Drivers can use of_platform_populate() to create platform devices
> >>>>> for children of the device main node, and a complementary API
> >>>>> of_platform_depopulate() is provided to delete these child platform
> >>>>> devices. The of_platform_depopulate() leverages the platform API
> >>>>> for performing the cleanup of these devices.
> >>>>>
> >>>>> The platform device resources are managed differently between
> >>>>> of_device_add and platform_device_add, and this asymmetry causes
> >>>>> a kernel oops in platform_device_del during removal of the resources.
> >>>>> Manage the platform device resources similar to platform_device_add
> >>>>> to fix this kernel oops.
> >>>>
> >>>> This is a known issue and has been attempted to be fixed before (I
> >>>> believe there is a revert in mainline). The problem is there are known
> >>>> devicetrees which have overlapping resources and they will break with
> >>>> your change.
> >>>
> >>> Are you referring to 02bbde7849e6 (Revert "of: use
> >>> platform_device_add")?
> >>
> >> I believe that's the one.
> >>
> >>> That one seems to be in registration path, and
> >>> this crash is in the unregistration path. If so, to fix the crash,
> >>> should we be skipping the release_resource() for now in
> >>> platform_device_del for DT nodes, or replace platform_device_unregister
> >>> with of_device_unregister in of_platform_device_destroy()?
> >>
> >> IIRC, the problem is inserting a resource twice on add from 2
> >> different nodes, not the removal path. Perhaps we could make a
> >> collision non-fatal for in the DT case.
> > 
> > We may be talking two different things here, I understand that this
> > patch would create an issue with inserting a resource twice in the
> > devicetrees with overlapping resources (just like the commit that was
> > reverted above), but the crash is on devices with resources whose
> > parent, child, sibling pointers have never been initialized (the
> > of_device_add path does not touch these at all), and get dereferenced in
> > platform_device_del()->release_resource(). See the following that has a
> > better explanation [1].
> > 
> > regards
> > Suman
> > 
> > [1]
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274412.html
> > 
> > 
> >> Grant may have some ideas on
> >> what's needed here.
> 
> Ping, any suggestions here? Do we ought to replace
> platform_device_unregister() with of_device_unregister() similar to the
> approach taken in 02bbde7849e6 (Revert "of: use platform_device_add")?

Hi Suman,

Yes, I think the solution to both problems is to create an
of_device_unregister() function. It's not the prettiest thing, but I
think it is for the best.

g.

