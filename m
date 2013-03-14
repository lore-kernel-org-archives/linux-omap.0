From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 0/3] ARM: OMAP2+: Add GPMC DT support for Ethernet child
Date: Thu, 14 Mar 2013 16:09:19 +0100
Message-ID: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:46294 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3CNPJg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 11:09:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hello Jon,

As discussed before [1], this patch-set adds DT support for ethernet
controllers connected to a TI GPMC by making gpmc_probe_nor_child()
a generic function and reusing it to initialize "ethernet" child
devices nodes too. It also adds documentation about the DT binding.

The patch-set is based on top of your omap-gpmc-for-v3.10 branch [2]
and is composed of the following patches:

[PATCH 1/3] ARM: OMAP2+: return -ENODEV if GPMC child device
[PATCH 2/3] ARM: OMAP2+: rename gpmc_probe_nor_child() to gpmc_probe_generic_child()
[PATCH 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet child

This was tested on an TI OMAP3 DM3735 based board (IGEPv2)

Thanks a lot and best regards,
Javier

[1]: https://patchwork.kernel.org/patch/2245111/
[2]: https://github.com/jonhunter/linux/tree/omap-gpmc-for-v3.10
