From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: Request for OMAPDSS testing
Date: Thu, 6 Jun 2013 23:43:42 +0300
Message-ID: <20130606204342.GB3507@blackmetal.musicnaut.iki.fi>
References: <51AD99F5.7060506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:46797 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3FFUnu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 16:43:50 -0400
Content-Disposition: inline
In-Reply-To: <51AD99F5.7060506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Tue, Jun 04, 2013 at 10:40:37AM +0300, Tomi Valkeinen wrote:
> I've made some big changes on the omapdss device model, which involves
> converting all the panel drivers. I've got only a bunch of boards, so I
> hope some of you can perhaps do some minimal tests on some other boards.
> 
> I've got: Beagle (old one), Panda, 4430SDP, Overo with LCD43.
> 
> The code can be found from the below git branch. It's based on 3.10-rc1.
> 
> git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
> 
> All you need to do to get things working is to enable the new panel
> drivers from kernel config, under Device drivers/Graphics support/OMAP2+
> Display Subsystem support/OMAP Display Device Drivers/

I tested Nokia N900 by pulling your tree and doing the following .config
changes:

	# CONFIG_PANEL_ACX565AKM is not set

	CONFIG_PANEL_SONY_ACX565AKM=y

The frame buffer console seems to work OK.

A.
