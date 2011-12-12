From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: McSPI: Remove unused flag from struct
 omap2_mcspi_device_config
Date: Mon, 12 Dec 2011 15:21:37 -0800
Message-ID: <20111212232137.GL32251@atomide.com>
References: <1323681317-8447-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28776 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752712Ab1LLXVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 18:21:39 -0500
Content-Disposition: inline
In-Reply-To: <1323681317-8447-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [111212 00:45]:
> Flag single_channel in struct omap2_mcspi_device_config is not used
> by drivers/spi/spi-omap2-mcspi.c so we may remove it from include/plat/mcspi.h
> and affected board files.

Thanks applying into cleanup branch.

Regards,

Tony
