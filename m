From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: v4.1-rc1 & N900: annoying Nokia modem spam
Date: Sat, 2 May 2015 21:43:37 +0300
Message-ID: <20150502184337.GA575@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50438 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbEBSnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 May 2015 14:43:45 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org

Hi,

With v4.1-rc1, after loading nokia_modem I get the following endless
log spam until I load cmt_speech (for whatever reason it does not get
modprobed automatically with busybox modprobe):

	[   41.626983] nokia-modem n900-modem: Missing cmt-speech driver
	[   41.804565] nokia-modem n900-modem: GPIO lookup for consumer (null)
	[   41.804626] nokia-modem n900-modem: using device tree for GPIO lookup
	[   41.804687] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[0]' - status (0)
	[   41.804718] no flags found for (null)
	[   41.805023] nokia-modem n900-modem: GPIO lookup for consumer (null)
	[   41.805023] nokia-modem n900-modem: using device tree for GPIO lookup
	[   41.805145] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[1]' - status (0)
	[   41.805145] no flags found for (null)
	[   41.805389] nokia-modem n900-modem: GPIO lookup for consumer (null)
	[   41.805419] nokia-modem n900-modem: using device tree for GPIO lookup
	[   41.805541] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[2]' - status (0)
	[   41.805572] no flags found for (null)
	[   41.805816] nokia-modem n900-modem: GPIO lookup for consumer (null)
	[   41.805816] nokia-modem n900-modem: using device tree for GPIO lookup
	[   41.805969] of_get_named_gpiod_flags: parsed 'gpios' property of node '/ocp/ssi-controller@48058000/ssi-port@4805a000/hsi-client[3]' - status (0)
	[   41.805999] no flags found for (null)

Not nice.

Also, I now realize there is a forced nokia_modem Kconfig dependency
to cmt_speech. Before I was able to use data connection only, so why
now force this dependency to cmt_speech?

A.
