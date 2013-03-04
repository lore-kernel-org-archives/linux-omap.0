From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: 3.8 -> 3.9-rc1 upgrade: old configs broken
Date: Tue, 5 Mar 2013 01:22:52 +0200
Message-ID: <20130304232252.GA14552@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:57344 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373Ab3CDXWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 18:22:55 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

Hi,

How should I upgrade my .config files when upgrading to 3.9-rc1?

So far I have been doing it like this:

	cp <old config from previous kernel release> .config
	make ARCH=arm oldnoconfig
	<compile>

But now I see that none of my boards boot up... Except OMAP1 (well, after
fixing the build issues). I believe this is because ARCH_MULTIPLATFORM
changes. I can always redo my configs with menuconfig, it's a PITA job...

So I guess .config files are not supposed to be upwards compatible?

A.
