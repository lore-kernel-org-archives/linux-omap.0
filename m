From: Paul Barker <paul@paulbarker.me.uk>
Subject: McBSP functions not exported
Date: Fri, 11 Jan 2013 11:48:46 +0000
Message-ID: <20130111114846.00005679@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:37373 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752409Ab3AKMnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 07:43:39 -0500
Received: from mail176.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 66242FF9211
	for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 13:02:09 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

I'm currently working on a driver to talk to an analog-to-digital
converter (specifically a Texas Instruments ADS1672) connected to the
McBSP port on a Beagleboard-xM. I'm currently building my driver module
against a 3.2 series kernel with Beagleboard patches and config from
https://github.com/beagleboard/kernel (branch beagleboard-3.2). I'd
like to keep up-to-date with the more recent kernels but my module
won't compile with them.

When the OMAP McBSP driver stack was merged into a single driver
(commit 45656b4 by Peter Ujfalusi, looks like it went into linux 3.3)
all the EXPORT_SYMBOL macros were removed so I can no longer call the
functions I was using from my external module. Alternatively I could
just be missing something really obvious, let me know if I am!

I'm just wondering what the best way forward is from here and I'm sure
I can't be the only person who was using the McBSP driver code in the
kernel to interface with external hardware. The two options I can think
of are either that I move my driver into the kernel source tree itself
or the McBSP driver functions are exported again so that they can be
used by external modules. It's easier to maintain an external module
than a series of patches against the kernel, unless a driver for an
analog-to-digital converter connected to the McBSP port is something
that would actually have a chance of being merged into the mainline
kernel. I could look at making this driver more generic once I have the
current hardware/driver combination working, so that it should work
with most analog-to-digital converters - I haven't found such a driver
in my previous googling.

If you have any advice on this or a pointer to a better place to ask
this question please let me know.

Thanks,

-- 
Paul Barker

paul@paulbarker.me.uk
http://www.paulbarker.me.uk/
