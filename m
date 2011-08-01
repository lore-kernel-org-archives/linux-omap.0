From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple platform_device from omap_device
Date: Mon, 01 Aug 2011 08:42:14 -0700
Message-ID: <871ux5nnop.fsf@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-9-git-send-email-khilman@ti.com>
	<20110730120332.GA15539@n2100.arm.linux.org.uk>
	<20110731025807.GA24334@ponder.secretlab.ca>
	<20110731150540.GA3019@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39818 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753085Ab1HAPmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 11:42:19 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so3509470gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 08:42:18 -0700 (PDT)
In-Reply-To: <20110731150540.GA3019@n2100.arm.linux.org.uk> (Russell King's
	message of "Sun, 31 Jul 2011 16:05:40 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Jul 30, 2011 at 08:58:07PM -0600, Grant Likely wrote:
>> On Sat, Jul 30, 2011 at 01:03:32PM +0100, Russell King - ARM Linux wrote:
>> > On Thu, Jul 21, 2011 at 04:52:18PM -0700, Kevin Hilman wrote:
>> > > Rather than embedding a struct platform_device inside a struct
>> > > omap_device, decouple them, leaving only a pointer to the
>> > > platform_device inside the omap_device.
>> > > 
>> > > This patch uses devres to allocate and attach the omap_device to the
>> > > struct device, so finding an omap_device from a struct device means
>> > > using devres_find(), and the to_omap_device() helper function was
>> > > modified accordingly.
>> > > 
>> > > RFC/Hack alert:
>> > > 
>> > > Currently the driver core (drivers/base/dd.c) doesn't expect any
>> > > devres resources to exist before the driver's ->probe() is called.  In
>> > > this patch, I just comment out the warning, but we'll need to
>> > > understand why that limitation exists, and if it's a real limitation.
>> > > A first glance suggests that it's not really needed.  If this is a
>> > > true limitation, we'll need to find some way other than devres to
>> > > attach an omap_device to a struct device.
>> > > 
>> > > On OMAP, we will need an omap_device attached to a struct device
>> > > before probe because device HW may be disabled in probe and drivers
>> > > are expected to use runtime PM in ->probe() to activate the hardware
>> > > before access.  Because the runtime PM API calls use omap_device (via
>> > > our PM domain layer), we need omap_device attached to a
>> > > platform_device before probe.
>> > 
>> > This feels really wrong to overload devres with this.  devres purpose is
>> > to provide the device's _drivers_ with a way to allocate and free resources
>> > in such a way to avoid leaks on .remove or probe failure.  So I think that
>> > overloading it with something that has a different lifetime is completely
>> > wrong.
>> 
>> I disagree; extending devres to also handle device lifetime scoped
>> resources makes perfect sense. It is a clean extension, and struct device
>> is really getting rather huge.  I certainly prefer re-scoping devres
>> to adding more elements to struct device.
>
> The point is you're asking something which is designed to have a well
> defined lifetime of driver-bind...driver-unbind to do a lot more than
> that - extending its lifetime conditional on some flag to the entire
> device lifetime instead.
>
> Such extensions tend to be a disaster - and a recipe for confusion as
> people will no longer have a clear idea of the lifetime issues.  We
> already know that people absolutely struggle to understand lifed
> objects - we see it time and time again where people directly kfree
> stuff like platform devices without thinking about whether they're
> still in use.
>
> So no, extending devres is a _big_ mistake and is far from clean.
>
> Not only that, but if most of the platform devices are omap devices,
> (as it would be on OMAP), you'll consume more memory through having to
> have the additional management structs for the omap_device stuff than
> a simple pointer.
>
> As for struct device getting rather huge, last time I looked it contained
> a load of stuff which was there whether or not a platform used it.  Eg,
> you get 4 bytes wasted for an of_node whether you have DT support or not.
> If sizeof(struct device) really is a problem, then it needs the unused
> stuff ifdef'd away.  So I don't buy the "its getting rather huge" argument.
>
>> > We could add a new member to struct dev_archdata or pdev_archdata to carry
>> > a pointer to this data, which I think would be a far cleaner (and saner)
>> > way to deal with this.  In much the same way as we already have an of_node
>> > member in struct device.
>> 
>> Since this is just for omap_device, which by definition is arm-only, I
>> don't have any strong objection to using pdev_archdata. If it was
>> cross-architecture, then I'd argue strongly for the devres approach.
>
> Indeed, which is why I think putting it in the platform device archdata
> makes total sense, more sense than buggering up the clean devres lifetime
> rules that we have today.

OK, so I'll continue this approach using pdev_archdata, which would work
fine for me.  It's currently empty, so I'll just add a 'void *' if it's
OK with you Russell:

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..bb777cd 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -13,6 +13,7 @@ struct dev_archdata {
 };
 
 struct pdev_archdata {
+	void *p;
 };
 
 #endif
