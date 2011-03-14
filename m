From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: GPIO chip select support in McSPI
Date: Mon, 14 Mar 2011 13:25:36 -0600
Message-ID: <20110314192536.GF16096@angua.secretlab.ca>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
 <1297635034-24504-1-git-send-email-bgamari.foss@gmail.com>
 <20110302215026.GA22854@angua.secretlab.ca>
 <87sjv517yd.fsf@gmail.com>
 <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
 <87ipvmx2ok.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45860 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab1CNTZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 15:25:40 -0400
Received: by qyk7 with SMTP id 7so1737095qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 12:25:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87ipvmx2ok.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sf.net

On Sun, Mar 13, 2011 at 03:04:11PM -0400, Ben Gamari wrote:
> I've included the OMAP list so that I can hopefully get some feedback
> from folks more familiar with this code.
> 
> Background:
> 
> I've been working on adding support for GPIO chip select lines to the
> McSPI driver. Grant has been working with me to try getting the
> in-kernel interface right and we have finally converged on a solution
> whereby a table of GPIO lines will be passed to the McSPI driver through
> platform_device.device.platform_data. Unfortunately, as explained below,
> there is no clear path to support this in the current McSPI
> initialization code.
> 
> 
> On Thu, 03 Mar 2011 14:42:07 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> > The spi_master platform device is registered somewhere in the
> > inappropriate support code. You need to arrange to make sure the
> > correct pdata is attached to it when it gets registered. There
> > /should/ be a mechanism for doing so.
> > 
> > All spi devices already specify a cs number anyway. What you can do is
> > use the cs number as the lookup index into the gpio table, and
> > remember to reserve a cs# for the 'native' cs line.
> > 
> I've done as you suggested and added support to the McSPI driver by
> passing a GPIO table through platform_data. A patch will be coming
> shortly.
> 
> Unfortunately, I'm really not sure how to restructure the OMAP code to
> pass this information along. Currently the McSPI devices are registered
> in arch/arm/mach-omap2/devices.c (omap_init_mcspi). In order to make the
> GPIO CS support configurable by board code, we need some way to change
> the (currently static) platform_devices prior to registration. Does
> anyone have any suggestions on how this code could be refactored to
> allow for this with minimal code duplication? Obviously we could just
> move the platform_devices into the board files but this seems like a lot
> of code duplication to support functionality that few boards will use.

I see two solutions:
1) platform code registers a bus notifier so that it gets called back
before the device gets bound to a driver.  Then it can augment the
platform data.
2) add an api to arch/arm/mach-omap2/devices.c for providing a cs
table before the device gets registered (must be called before
arch_initcall() time).

g.
