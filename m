From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
Date: Wed, 2 Sep 2009 13:21:59 +0300
Message-ID: <20090902102159.GO24619@nokia.com>
References: <17586781.1251256830061.JavaMail.root@elwamui-hybrid.atl.sa.earthlink.net>
 <20090828181352.GN25828@atomide.com>
 <05DA4554-3E97-4545-B2FC-E458E3C0F078@mindspring.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44101 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZIBKXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Sep 2009 06:23:02 -0400
Content-Disposition: inline
In-Reply-To: <05DA4554-3E97-4545-B2FC-E458E3C0F078@mindspring.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Eric Witcher <ewitcher@mindspring.com>
Cc: Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sun, Aug 30, 2009 at 12:38:07AM +0200, ext Eric Witcher wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch fixes the .probe failure of twl4030_usb driver if
> it is compiled into kernel.
> 
> Since twl4030_usb USB transceiver .probe depends on
> twl4030-regulator, marking twl4030_usb_init as subsys_initcall_sync
> can make it called after twl4030-regulator initialization is finished,
> then twl4030_usb USB transceiver driver can be probed successfully.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Tested-by: Eric Witcher <ewitcher@mindspring.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

should go to Greg KH on linux-usb

-- 
balbi
