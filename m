From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove legacy device creation for McPDM
 and DMIC
Date: Wed, 21 Aug 2013 00:52:47 -0700
Message-ID: <20130821075247.GX7656@atomide.com>
References: <1373551488-3816-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57269 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3HUHwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 03:52:49 -0400
Content-Disposition: inline
In-Reply-To: <1373551488-3816-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130711 07:11]:
> McPDM and DMIC only available on OMAP4/5 which no longer boots in legacy
> mode.
> The code to create the devices in legacy mode can be removed.

Thanks applying to omap-for-3.12/fixes-non-critical.

Regards,

Tony
