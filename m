From: Felipe Balbi <balbi@ti.com>
Subject: Re: LCD on Zoom2 dev board with DSS
Date: Mon, 13 Sep 2010 15:52:12 +0300
Message-ID: <20100913125212.GA19061@legolas.emea.dhcp.ti.com>
References: <1284381807.1801.38.camel@A05BPC17>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34363 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534Ab0IMMwX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Sep 2010 08:52:23 -0400
Content-Disposition: inline
In-Reply-To: <1284381807.1801.38.camel@A05BPC17>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yanick Saugy <yanick.saugy@heig-vd.ch>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, Sep 13, 2010 at 07:43:27AM -0500, Yanick Saugy wrote:
>Finally I've enabled DSS and lcd NEC_NL8048HL11 in kernel config file.
>
>At this time the kernel boots well, and my LCD backlight turns on but I
>can't see TUX while booting, and I can't draw anything after logging

to see tux you need to enable CONFIG_LOGO_LINUX_CLUT224 at least. Then
you also might want to enable the framebuffer console, just to get some
output on the screen.

-- 
balbi
