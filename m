From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP3 Touchbook: Fix MMC caps
Date: Thu, 24 Feb 2011 11:34:42 -0800
Message-ID: <20110224193441.GF20560@atomide.com>
References: <44de2f4c8b17d38df1d25b7236223247@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54765 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1BXTep (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 14:34:45 -0500
Content-Disposition: inline
In-Reply-To: <44de2f4c8b17d38df1d25b7236223247@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Radek =?utf-8?B?KE1ya3ZhKSBQaWxhxZk=?= <mrkva@mrkva.eu>
Cc: linux-omap@vger.kernel.org

* Radek (Mrkva) Pila=C5=99 <mrkva@mrkva.eu> [110224 10:02]:
> MMC controller cannot handle MMC_CAP_4_BIT_DATA nor
> MMC_CAP_8_BIT_DATA - the card won't be detected (tested with two
> SDHC cards, both Class6). Thus disabling.

Hmm it might be worth checking that the MMC data lines are muxed
correctly. Maybe make sure CONFIG_OMAP_MUX_DEBUG is set in
your .config and CONFIG_DEBUG_FS too. Then boot and and mount
debugfs with mount -tdebugfs debugfs /sys/kernel/debug.
Then you can do:

# grep -i mmc1 /sys/kernel/debug/omap_mux/* | grep dat

And check the settings. Changing the values could cause data
corruption, so use a temporary root file system!

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
