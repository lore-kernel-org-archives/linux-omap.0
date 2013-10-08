From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Tue, 8 Oct 2013 14:11:08 -0700
Message-ID: <20131008211108.GQ8313@atomide.com>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61894 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab3JHVLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:11:13 -0400
Content-Disposition: inline
In-Reply-To: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131004 20:00]:
> IGEPv2 board has both an DVI and TFP410 video interfaces but
> DSS support for DeviceTree has not yet landed in mainline so
> is necessary to init the displays using legacy platform code.

Thanks, applying into omap-for-v3.13/quirk.

Regards,

Tony
