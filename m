From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP1: drop AMS_DELTA_FIQ config option
Date: Tue, 16 Nov 2010 13:18:38 -0800
Message-ID: <20101116211838.GI9264@atomide.com>
References: <201011060256.00485.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672Ab0KPVSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 16:18:52 -0500
Content-Disposition: inline
In-Reply-To: <201011060256.00485.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101105 18:48]:
> This patches removes a config option that was used to select a FIQ 
> handler to be build for Amstrad Delta, as required by the on-board serio 
> interface driver. Not having any problem reports received since it was 
> introduced in 2.6.35, the FIQ handler can now be built and initialized by 
> default, thus reqiring no extra config option.

Thanks, I'll queue this for 2.6.38 merge window.

Tony
