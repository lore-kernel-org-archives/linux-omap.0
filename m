From: Michael Poole <mdpoole@troilus.org>
Subject: How to (get a struct device* to) map a DMA buffer for McBSP?
Date: Wed, 24 Nov 2010 17:32:38 -0500
Message-ID: <AANLkTimuvMArMjGqVAfHLyh-eE0f9Un03UMHZHyP=_N1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44639 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753305Ab0KXWcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 17:32:39 -0500
Received: by gwb20 with SMTP id 20so171486gwb.29
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 14:32:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am trying to write a device driver to stream data via a McBSP
module.  Most of it is a pretty thin layer, thanks to all the
framework in plat-omap/mcbsp.c and .../mcbsp.h.  However, I am getting
stuck on the read() and write() implementation -- in particular,
retrieving the device pointer for the DMA mapping functions.

To pick dma_map_single(dev, ptr, size, dir) as an example, the ARM
implementation of dma_map_single() looks like it requires dev != NULL.
 struct omap_mcbsp's "dev" field would be the natural thing to pass,
but the mcbsp_ptr array is not an exported symbol, and there is no
function declared in mcbsp.h that will expose either the omap_mcbsp
struct or the device struct inside it.

Is there a good way to get the right struct device* for the McBSP
module that this device driver is using?  Would a patch be accepted to
add a function that would return the struct device * given the McBSP
id (and if so, should it use EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL())?

Michael Poole
