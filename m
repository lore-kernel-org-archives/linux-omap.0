From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 02/27] OMAPDSS: remove DT hacks for regulators
Date: Mon, 16 Dec 2013 10:42:48 -0800
Message-ID: <20131216184247.GB26293@atomide.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15443 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab3LPSm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 13:42:56 -0500
Content-Disposition: inline
In-Reply-To: <1387205794-32246-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
> For booting Panda and 4430SDP with DT, while DSS did not support DT, we
> had to had small hacks in the omapdss driver to get the regulators. With
> DT now supported in DSS, we can remove those hacks.

This too we should probably keep for a while and remove after we've
converted DSS over to DT?

Regards,

Tony
