From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: tidspbridge broken?
Date: Mon, 4 Oct 2010 18:33:33 +0300
Message-ID: <AANLkTi=hD1m0jC64KW7gHdywd=2GseX8gqNwPTHOh6s2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44368 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0JDPde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:33:34 -0400
Received: by bwz11 with SMTP id 11so3669194bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 08:33:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gregkh@suse.de, nm@ti.com, ohad@wizery.com, omar.ramirez@ti.com, x0095840@ti.com

Hi,

I was trying the iommu patches but I noticed the tidspbridge driver
doesn't work at all, I found two critical issues:

First, the platform device is missing, so there's no way the driver
can work. It seems to have been dropped from the migration to staging
which happened some time ago... I would have expected somebody to
notice a thing like this. I already have patches that fix this.

And second, since 2.6.35, ioremap() doesn't work on RAM, so this
driver cannot work anymore unless 309caa9 is reverted. I am reserving
the memory with memblock, but it still fails the ioremap(), and __va()
doesn't seem to work (don't know why).

Has anyone tried the driver on 2.6.36-rcX?

-- 
Felipe Contreras
