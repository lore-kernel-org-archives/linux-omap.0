From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: GPIO chip select support in McSPI
Date: Mon, 14 Mar 2011 22:22:31 -0400
Message-ID: <877hc1t95k.fsf@gmail.com>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7> <1297635034-24504-1-git-send-email-bgamari.foss@gmail.com> <20110302215026.GA22854@angua.secretlab.ca> <87sjv517yd.fsf@gmail.com> <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com> <87ipvmx2ok.fsf@gmail.com> <20110314192536.GF16096@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51912 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1COCWf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 22:22:35 -0400
Received: by qwk3 with SMTP id 3so106176qwk.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 19:22:34 -0700 (PDT)
In-Reply-To: <20110314192536.GF16096@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sf.net

On Mon, 14 Mar 2011 13:25:36 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> I see two solutions:
> 1) platform code registers a bus notifier so that it gets called back
> before the device gets bound to a driver.  Then it can augment the
> platform data.
> 
This sounds like it might be a bit involved and I'm not terribly
familiar with these facets of the driver model. This would probably be
the more flexible approach but I think I'll stick with the simpler
option.

> 2) add an api to arch/arm/mach-omap2/devices.c for providing a cs
> table before the device gets registered (must be called before
> arch_initcall() time).
> 
This is along the lines of what I was thinking. Any thoughts on how to
get function called before arch_initcall()?

- Ben
