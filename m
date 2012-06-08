From: Tero Kristo <t-kristo@ti.com>
Subject: Re: suspend broken on 3.5-rc1?
Date: Fri, 8 Jun 2012 16:05:32 +0300
Message-ID: <1339160732.2091.47.camel@sokoban>
References: <4FD1D570.1010508@ti.com> <20120608105611.GO12766@atomide.com>
	 <4FD1EF25.3060906@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2FHNFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 09:05:36 -0400
In-Reply-To: <4FD1EF25.3060906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, loml <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>

On Fri, 2012-06-08 at 17:55 +0530, Rajendra Nayak wrote:
> On Friday 08 June 2012 04:26 PM, Tony Lindgren wrote:
> > * Rajendra Nayak<rnayak@ti.com>  [120608 03:40]:
> >> Hi,
> >>
> >> I don;t seem to be able to get suspend to work on 3.5-rc1 on
> >> my 4430 panda. I am not sure if its UART wakeups that are
> >> an issue or suspend itself is broken.
> >> Is there anything more than setting
> >> '/sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup'
> >> to 'enabled' that I need to do to get UART to be wakeup capable?
> >>
> >> 3.4 major works just fine for me.
> >
> > Can you try with the fixes branch that Olof just merged?
> 
> I tried merging the fixes branch on 3.5-rc1 as well as latest
> mainline and both didn't work.
> 
> > If it's the UART wake-up events, there's a patch that should
> > help.
> >
> > Tony
> 

The patch referenced here helps:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69596.html

DSS crashes during wakeup from suspend.

-Tero


