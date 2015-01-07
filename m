From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am57xx-beagle-x15: Add dual ethernet
Date: Wed, 7 Jan 2015 15:43:18 -0800
Message-ID: <20150107234318.GH13010@atomide.com>
References: <5480CADE.5010200@ti.com>
 <1417726977-2496-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49169 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755803AbbAGXrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 18:47:04 -0500
Content-Disposition: inline
In-Reply-To: <1417726977-2496-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>

* Felipe Balbi <balbi@ti.com> [141204 13:05]:
> Add CPSW DT binding to beagle X15 DTS in order to
> get ethernet working with this board.
> 
> Note that we're also adding sleep state which will
> place all pins in mux mode 15 - which means "driver
> off" - thus conserving power.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	- removed duplicated SoB from myself
> 	- Fixed s/Slave 1/Slave2/ in one comment
> 	- slightly improved commit log
> 

Applying into omap-for-v3.20/dt thanks.

Tony
