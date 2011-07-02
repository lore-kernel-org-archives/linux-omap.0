From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2 v4] OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
Date: Sat, 2 Jul 2011 10:37:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107021037040.8874@utopia.booyaka.com>
References: <1309603946-25395-1-git-send-email-govindraj.raja@ti.com> <1309603946-25395-3-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51986 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab1GBQhz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jul 2011 12:37:55 -0400
In-Reply-To: <1309603946-25395-3-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>

On Sat, 2 Jul 2011, Govindraj.R wrote:

> +int omap_hmwod_pad_get_wakeup_status(struct omap_hwmod *oh)
	    ^^^^^

should be "hwmod"


- Paul

