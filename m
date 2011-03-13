From: Ben Gamari <bgamari.foss@gmail.com>
Subject: GPIO chip select support in McSPI
Date: Sun, 13 Mar 2011 15:04:11 -0400
Message-ID: <87ipvmx2ok.fsf@gmail.com>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7> <1297635034-24504-1-git-send-email-bgamari.foss@gmail.com> <20110302215026.GA22854@angua.secretlab.ca> <87sjv517yd.fsf@gmail.com> <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55569 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab1CMTEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Mar 2011 15:04:16 -0400
Received: by vws1 with SMTP id 1so1869623vws.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Mar 2011 12:04:15 -0700 (PDT)
In-Reply-To: <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>
Cc: spi-devel-general@lists.sf.net

I've included the OMAP list so that I can hopefully get some feedback
from folks more familiar with this code.

Background:

I've been working on adding support for GPIO chip select lines to the
McSPI driver. Grant has been working with me to try getting the
in-kernel interface right and we have finally converged on a solution
whereby a table of GPIO lines will be passed to the McSPI driver through
platform_device.device.platform_data. Unfortunately, as explained below,
there is no clear path to support this in the current McSPI
initialization code.


On Thu, 03 Mar 2011 14:42:07 -0700, Grant Likely <grant.likely@secretlab.ca> wrote:
> The spi_master platform device is registered somewhere in the
> inappropriate support code. You need to arrange to make sure the
> correct pdata is attached to it when it gets registered. There
> /should/ be a mechanism for doing so.
> 
> All spi devices already specify a cs number anyway. What you can do is
> use the cs number as the lookup index into the gpio table, and
> remember to reserve a cs# for the 'native' cs line.
> 
I've done as you suggested and added support to the McSPI driver by
passing a GPIO table through platform_data. A patch will be coming
shortly.

Unfortunately, I'm really not sure how to restructure the OMAP code to
pass this information along. Currently the McSPI devices are registered
in arch/arm/mach-omap2/devices.c (omap_init_mcspi). In order to make the
GPIO CS support configurable by board code, we need some way to change
the (currently static) platform_devices prior to registration. Does
anyone have any suggestions on how this code could be refactored to
allow for this with minimal code duplication? Obviously we could just
move the platform_devices into the board files but this seems like a lot
of code duplication to support functionality that few boards will use.

Thoughts?

- Ben
