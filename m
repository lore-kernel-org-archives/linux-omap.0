From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] omap: header: remove unused data-type
Date: Thu, 10 Dec 2009 12:10:31 +0200
Message-ID: <20091210101031.GB14473@nokia.com>
References: <1260392121-16685-1-git-send-email-vikram.pandita@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63468 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbZLJKLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 05:11:12 -0500
Content-Disposition: inline
In-Reply-To: <1260392121-16685-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Vikram Pandita <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Dec 09, 2009 at 09:55:21PM +0100, ext Vikram Pandita wrote:
>Remove unused data type omap_gpio_switch_config
>
>Thereby also get rid of following sparse warnings:
>arch/arm/plat-omap/include/plat/board.h :121:20:
>	warning: dubious bitfield without explicit `signed' or `unsigned'
>arch/arm/plat-omap/include/plat/board.h :122:19:
>	warning: dubious bitfield without explicit `signed' or `unsigned'
>arch/arm/plat-omap/include/plat/board.h :123:24:
>	warning: dubious bitfield without explicit `signed' or `unsigned'
>
>Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi
