From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH v2] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 13:16:19 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC0054@dbde03.ent.ti.com>
References: <1311033103-15854-1-git-send-email-vikram.pandita@ti.com>
 <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC000B@dbde03.ent.ti.com>
 <CAFm5wm1kruM0WCoAsC7Ps09TsaCUA6G6NBT24q0QY6-_B9AAog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44506 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab1GSHq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 03:46:29 -0400
In-Reply-To: <CAFm5wm1kruM0WCoAsC7Ps09TsaCUA6G6NBT24q0QY6-_B9AAog@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

Pandita, Vikram wrote:
> On Mon, Jul 18, 2011 at 11:22 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> >> From: Vikram Pandita <vikram.pandita@ti.com>
> >>
> >> This patch enables the DMA mode1 RX support.
> >> This feature is enabled based on the short_not_ok flag passed from
> >> gadget drivers.
> >>
> >> This will result in a thruput performance gain of around
> >> 40% for USB mass-storage/mtp use cases.
> >>
> >> Based on Original work by
> >> Anand Gadiyar <gadiyar@ti.com> on 2.6.35 kernel
> >>
> >> Change-Id: I9b3a7cae73b63e86128d2caf4cdd67ab77556e75
> >> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> >> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >
> > I think the change-id should not be included in upstream
> > submissions - it may not be useful to someone looking at
> > the changelog. So you probably should drop it.
> 
> yes will drop that. This comes from gerrit commit hook that does not
> have a meaning for upstream.
> 
> >
> > Could you please retain my authorship and sign off from the
> > original patch, since I did pretty much all the original work
> > on writing this patch
> 
> That is given and clearly mentioned in the commit message.
> I will change the authorship with no issues, but would have been nice
> if you could have taken this upstream.

Yes, I ought to have followed up more. But this was at a time when
we were promised a competing implementation from Nokia would be
merged that would get mode1 working for all use cases. A patch
series was posted to the mailing lists around Dec 2009 with
promises off-list to repost with comments addressed - that
has never happened so far.


But you can't just change authorship when the entire functional code
is the same. (It doesn't matter much to me - I'm not as active on
MUSB as I used to be; it's just the principle of the thing).

> We have been carrying this optimisation around in product kernels for
> a long time now and we keep redoing on each migration,
> with the downside of sometimes loosing the authorship.
> 
> > (and if I remember correctly several
> > attempts to get this merged upstream)? I don't see any
> > functional changes from my original patch.
> 
> Wonder what were the reasons for not getting accepted?
> Can you re-ignite the discussion why it cannot be taken in then?

You've already re-ignited this discussion. I haven't tested the patch
with the current kernel (and will do so soon), but if it does still
work and there are no objections, it ought to be merged.

- Anand
