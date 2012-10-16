From: Tony Lindgren <tony@atomide.com>
Subject: Updated status of the removal of plat headers
Date: Tue, 16 Oct 2012 16:00:41 -0700
Message-ID: <20121016230040.GP15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755481Ab2JPXAo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 19:00:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jon Hunter <jon-hunter@ti.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi all,

Here's a quick status update on the removal of remaining
#include <plat/*.h> files. Most files are now fixed up, and
we only have the following remaining:

cpu.h		wrapper only left, will be removed as soon as drivers are fixed

dmtimer.h	Jon is fixing this

mailbox.h	Omar, are you fixing this?

omap-serial.h	this will be dealt with mostly by Russell

prcm.h		Paul has posted patches for this, missing move of the header

sdrc.h		Paul has posted patches for this, missing move of the header

timex.h		Igor is looking into this

usb.h		Felipe, Kishon & Keshawa, are you fixing this?

vram.h		Tomi is fixing this

vrfb.h		Tomi is fixing this

I have not yet posted my omap-for-v3.8/cleanup-headers branch as I'm
waiting for a minimal tty branch from Greg for the 8250 changes, and
acks for the menelaus and iommu changes.

Regards,

Tony
