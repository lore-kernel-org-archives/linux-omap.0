From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] Support for Variscite OM44 modules and boards
Date: Mon, 5 May 2014 17:15:30 -0700
Message-ID: <20140506001530.GL25949@atomide.com>
References: <1398971269-20515-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52156 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932509AbaEFAPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 20:15:37 -0400
Content-Disposition: inline
In-Reply-To: <1398971269-20515-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140501 12:08]:
> Hello,
> 
> This patch set adds support for Variscite OM44 series of system on modules and boards.
> 
> There weren't many comments on v1 of this patch set so I hope this can make it into 3.16.
> Changes since v2:
>  * Use OMAP IOPAD macros
> 
> Patch 1: Add support for the SoM itself and the reference carrier board. Together these make the VAR-STK-OM44 dev kit.
> Patch 2: Add support for VAR-DVK-OM44 which is just the STK with a LCD display.
> Patch 3: Nodes for WLAN/BT support.
> Patch 4: Add quirks so that WLAN can be used. Still waiting for proper DT bindings.
> 
> Since this patch set now uses the IOPAD macros a fix from Tony is need.
> See: https://patchwork.kernel.org/patch/4025421/

Just noted that the macro won't work while was about to
apply these, sorry. So we're back to either using the
existing OMAP4_WKUP_IOPAD or raw offset from the padconf
area unless you have some great macro ideas.
 
> Note that patch 1 relies upon a patch from Tomi Valkeinen add hpd-gpio (hotplug detect) to the "hdmi-connector".
> See: http://marc.info/?l=linux-omap&m=139771947508021&w=2
> 
> Patch 2 also relies upon a patch from Tomi that adds DT support to panel-dpi.
> See: http://marc.info/?l=devicetree&m=139030201815380&w=2

Maybe also leave out the DSS changes until Tomi has confirmed
those?

Regards,

Tony
