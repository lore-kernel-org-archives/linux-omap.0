From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] MUSB: Remove usb_musb_pm_init() call
Date: Mon, 24 Aug 2009 17:56:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CF4A@dbde02.ent.ti.com>
References: <1251115597-23096-1-git-send-email-gadiyar@ti.com>
 <87d46lqu2w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33263 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbZHXM0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:26:08 -0400
In-Reply-To: <87d46lqu2w.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > MUSB: Remove usb_musb_pm_init() call
> >
> > In usb_musb_pm_init, we attempt to access an MUSB register
> > when the i-clock may not be on, or the module is otherwise
> > not accessible.
> >
> > We need to either:
> > - enable the clock before this access, or
> > - remove this code and move it to the bootloader, or
> > - enable the clock in the bootloader
> >
> > If we enable the clock in the bootloader, we might as well
> > add the workaround in the bootloader itself. This code will
> > anyway be changed once hwmod is in place, so remove it for now
> >
> > This allows us to boot the kernel on certain OMAP3 boards with
> > a bootloader that doesn't enable this clock. Without this, we
> > will need to upgrade the bootloaders on these boards.
> >
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> 
> NAK.
> 
> The PM branch already has a fix from Jon Hunter[1] for this which enables
> the clock, and in the thread where we discussed this I mentioned I would
> carry it in the PM branch until the hwmod for OTG is ready.

Right, but at least merge this into master and mainline for now,
so that boards that used to boot up okay before can continue to do so now.

Not everybody is working on the pm branch.

- Anand
