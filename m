From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.12-rc1: no longer compiles for Nokia n900 (omap based),
 display no longer works
Date: Thu, 19 Sep 2013 21:47:04 +0300
Message-ID: <20130919184703.GE30568@blackmetal.musicnaut.iki.fi>
References: <20130919093002.GA23806@amd.pavel.ucw.cz>
 <20130919094402.GA27253@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:41706 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3ISSrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Sep 2013 14:47:11 -0400
Content-Disposition: inline
In-Reply-To: <20130919094402.GA27253@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, catalin.marinas@arm.com

Hi,

On Thu, Sep 19, 2013 at 11:44:02AM +0200, Pavel Machek wrote:
> something in 3.12-rc1 broke display :-(. (dmesg diff attached at the
> end, maybe someone knows...)

3.12-rc1 for N900 compiles and works (also display) here with binutils
2.23.2.

> + omapfb omapfb: no displays

[...]

> - acx565akm spi1.2: omapfb: acx565akm rev 12 LCD detected

I think this is because the panel driver has changed, and the old one
was deleted. You need to change your kernel configuration with something
like below:

-CONFIG_PANEL_ACX565AKM=y
+CONFIG_DISPLAY_PANEL_SONY_ACX565AKM=y

A.
