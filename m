From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: (unknown)
Date: Fri, 10 Oct 2008 15:42:17 +0300
Message-ID: <20081010124217.GB7503@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35709 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbYJJMm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 08:42:26 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9ACg3H6003783
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 07:42:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Mathias Nyman <mathias.nyman@nokia.com>

tony@atomide.com
Bcc: 
Subject: Re: [PATCH 0/3] lp5521
Reply-To: felipe.balbi@nokia.com
In-Reply-To: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com>

On Mon, Oct 06, 2008 at 12:11:28PM +0300, Felipe Balbi wrote:
> A few cleanups and moving to drivers/leds. This driver
> is probably ok for making its way to mainline, by the morning
> I'll generate a patch against mainline and send to Richard
> (led maintainer) for integration.
> 
> *** Note: compile tested only due to the fact n810 doesn't boot.

News here ??

> 
> Felipe Balbi (3):
>   i2c: lp5521: remove dead code
>   i2c: lp5521: cosmetic fixes
>   lp5521: move to drivers/leds
> 
>  drivers/i2c/chips/Kconfig                          |    7 -
>  drivers/i2c/chips/Makefile                         |    1 -
>  drivers/leds/Kconfig                               |    7 +
>  drivers/leds/Makefile                              |    1 +
>  drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} |  181 ++++++++------------
>  5 files changed, 81 insertions(+), 116 deletions(-)
>  rename drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} (79%)

-- 
balbi
