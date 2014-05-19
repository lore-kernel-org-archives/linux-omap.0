From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Date: Mon, 19 May 2014 18:43:56 +0200
Message-ID: <4508837.NI0TQZBQLi@wuerfel>
References: <53730AFB.2090800@ti.com> <5379D35F.8040207@ti.com> <20140519155732.GA4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60485 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbaESQo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 12:44:26 -0400
In-Reply-To: <20140519155732.GA4849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Monday 19 May 2014 08:57:33 Tony Lindgren wrote:
> No need to load multiple drivers at this point. That's why I'm saying
> you can bail out on the undesired display controller probes using
> of_machine_is_compatible test. It's not that uncommon for drivers to do:
> 
> $ git grep of_machine_is_compatible drivers/ | wc -l
> 116

I think this is widely seen as bad style, and most of the examples are
testing for Power Mac specific workarounds for stuff that Apple didn't
put in DT elsewhere.

	Arnd
