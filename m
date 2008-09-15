From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
Date: Mon, 15 Sep 2008 15:36:47 +0300
Message-ID: <1221482207.6312.69.camel@tubuntu>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C4347CE3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57879 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbYIOMhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 08:37:48 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4347CE3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shah, Hardik" <hardik.shah@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

Hi,

On Mon, 2008-09-15 at 17:22 +0530, ext Shah, Hardik wrote:
> 
> DSS library gives the flexibility to change to add the as many overlay managers or as many encoder on the overlay manager.

Is an encoder here the same as an output from DISPC? So OMAP2 and 3 have
two encoders, the tv-out and lcd out?

> > Also I still don't quite know how to present displays to user space.
> > Currently my omapfb just uses the first display, and that's it. I think
> > in the end the user (be it X server, or perhaps some entity over it),
> > needs to have some understanding of what OMAP offers and how it can use
> > the displays. And there probably needs to be some product spesific
> > configuration regarding this in userspace.
> > 
> Most of the open source applications are not aware of the hardware capabilities.  So it should be transparently handled by the low level drivers/libraries.

That is true, and that's why the default mode should be something
"normal". However, if there are two LCDs on the device, someone has to
understand that only one of them can be updated with DISPC (and thus can
have the overlays), and the other is just a plain framebuffer. 

An application doesn't probably have to understand this, but some
display manager entity has. So this is only needed for HW that is
something else than the normal one LCD device.

Tomi


