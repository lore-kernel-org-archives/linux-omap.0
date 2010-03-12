From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/3] usb: Fix compile error for omaps for musb_hdrc
Date: Fri, 12 Mar 2010 10:30:12 +0200
Message-ID: <20100312083012.GZ20878@nokia.com>
References: <20100311180023.20537.27516.stgit@baageli.muru.com>
 <20100311180322.20537.3614.stgit@baageli.muru.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51292 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0CLIa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 03:30:58 -0500
Content-Disposition: inline
In-Reply-To: <20100311180322.20537.3614.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Thu, Mar 11, 2010 at 07:03:22PM +0100, ext Tony Lindgren wrote:
>CONFIG_ARCH_OMAP34XX is now CONFIG_ARCH_OMAP3.
>
>But since drivers/usb/musb/omap2430.c use CONFIG_PM for these
>registers and functions, do the same for the header.
>
>Otherwise we get the following for most omap3 defconfigs:
>
>drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'do'
>drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'while'
>drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'do'
>drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'while'
>
>Signed-off-by: Tony Lindgren <tony@atomide.com>

I sent a version for that yesterday. Sorry :-(

-- 
balbi
