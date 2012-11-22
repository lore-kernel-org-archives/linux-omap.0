From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/2] OMAP: DSS: panel-n8x0: register the DSS driver after
 SPI probe
Date: Thu, 22 Nov 2012 17:56:32 +0200
Message-ID: <20121122155632.GB13187@blackmetal.musicnaut.iki.fi>
References: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi>
 <1353527332-5216-2-git-send-email-aaro.koskinen@iki.fi>
 <50AE1831.90308@ti.com>
 <20121122151728.GA13187@blackmetal.musicnaut.iki.fi>
 <50AE4306.60203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:42241 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab2KVTBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 14:01:12 -0500
Content-Disposition: inline
In-Reply-To: <50AE4306.60203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Nov 22, 2012 at 05:21:42PM +0200, Tomi Valkeinen wrote:
> On 2012-11-22 17:17, Aaro Koskinen wrote:
> > On Thu, Nov 22, 2012 at 02:18:57PM +0200, Tomi Valkeinen wrote:
> >> On 2012-11-21 21:48, Aaro Koskinen wrote:
> >>> Register the DSS driver after SPI probe. This simplifies the
> >>> initialization. This is similar to what is being done e.g.
> >>> in panel-acx565akm.
> >>
> >> Is this a fix? The description sounds like it's just a cleanup.
> > 
> > Yes, it's a cleanup. I should have sent it separately, sorry.
> 
> Ok. Did you actually manage to test it?

Yes, the patch works but there are still issues and I can't get the
display yet alive:

[    4.081390] n8x0_panel display0: invalid s1d1374x revision 00
[    4.087738] omapfb omapfb: Failed to enable display 'lcd'
[    4.093475] omapfb omapfb: failed to initialize default display

For some reason all the blizzard_read_reg()s return just zeroes. I have
set up the panel_reset and ctrl_pwrdown GPIOs (30, 15) according to the
Maemo kernel, but maybe there's still more initializations I need to do
from the board file...

> I haven't tested N800 for ages, as I don't have a serial console for
> my N800, and last times I've tried I didn't manage to get it to boot.

It works. I use busybox/dropbear/USB networking to get a "console".

A.
