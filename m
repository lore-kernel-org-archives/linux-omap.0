From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 frame buffer problem
Date: Tue, 13 Oct 2009 15:59:51 +0300
Message-ID: <1255438791.27268.42.camel@tubuntu>
References: <4AD478CB.2040302@mlbassoc.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21588 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbZJMNBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 09:01:30 -0400
In-Reply-To: <4AD478CB.2040302@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

On Tue, 2009-10-13 at 14:55 +0200, ext Gary Thomas wrote:
> I have a new board that I'd like to run a frame buffer 800x600x24
> When I boot, I get this error:
>    omapfb: failed to allocate framebuffer
> 
> This board is derived from a board I'm already running DSS2 at
> 800x600x16 on.
> 
> What do I need to change to get this to work?

Most likely you need to allocate more VRAM with vram boot option, in
board file or kernel config option (CONFIG_OMAP2_VRAM_SIZE).

 Tomi


