From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: GPIO chip select support in McSPI
Date: Mon, 14 Mar 2011 21:29:51 -0600
Message-ID: <20110315032951.GA5600@angua.secretlab.ca>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
 <1297635034-24504-1-git-send-email-bgamari.foss@gmail.com>
 <20110302215026.GA22854@angua.secretlab.ca>
 <87sjv517yd.fsf@gmail.com>
 <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
 <87ipvmx2ok.fsf@gmail.com>
 <20110314192536.GF16096@angua.secretlab.ca>
 <877hc1t95k.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48596 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1COD3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 23:29:55 -0400
Received: by gwaa18 with SMTP id a18so68027gwa.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 20:29:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877hc1t95k.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sf.net

On Mon, Mar 14, 2011 at 10:22:31PM -0400, Ben Gamari wrote:
> On Mon, 14 Mar 2011 13:25:36 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> > I see two solutions:
> > 1) platform code registers a bus notifier so that it gets called back
> > before the device gets bound to a driver.  Then it can augment the
> > platform data.
> > 
> This sounds like it might be a bit involved and I'm not terribly
> familiar with these facets of the driver model. This would probably be
> the more flexible approach but I think I'll stick with the simpler
> option.
> 
> > 2) add an api to arch/arm/mach-omap2/devices.c for providing a cs
> > table before the device gets registered (must be called before
> > arch_initcall() time).
> > 
> This is along the lines of what I was thinking. Any thoughts on how to
> get function called before arch_initcall()?

You can call it from .init_machine()

g.

> 
> - Ben
