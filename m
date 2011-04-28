From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 4/4] omap: musb: introduce default baord config
Date: Thu, 28 Apr 2011 12:36:14 -0400
Message-ID: <9D42099B-0C25-4407-88B2-2574E9233B2A@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il> <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il> <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru> <20110428141818.GE19709@n2100.arm.linux.org.uk> <9B236748-29D6-4129-AFCD-5D223CE18ECD@linuxhacker.ru> <20110428162820.GF19709@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:33545 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab1D1QgZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Apr 2011 12:36:25 -0400
In-Reply-To: <20110428162820.GF19709@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!
On Apr 28, 2011, at 12:28 PM, Russell King - ARM Linux wrote:
> mm, it looks to me like we're ending up with two layers on top of
> each other, both trying to provide some kind of generic board interface.
> 
> I think they should be squashed together.  And that:
> 
> static struct musb_hdrc_platform_data musb_plat = {
> #ifdef CONFIG_USB_MUSB_OTG
>        .mode           = MUSB_OTG,
> #elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>        .mode           = MUSB_HOST,
> #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>        .mode           = MUSB_PERIPHERAL,
> #endif
> 
> in usb-musb.c needs the same treatment as I mentioned in the previous
> message if it really is board specific.  If not, I see no reason why
> the above can't go into the musb driver itself.

In the end it's chip dependent. And the musb can work in all three modes.
Of course the board dictates if the power is supplied to the bus in host
mode and such, but even that could be worked around as nokia 9x0 saga for
USB host shows.
So to me it looks like something totally in realm of musb driver itself.
Nothing bad happens if you configure your MUSB as say OTG while in fact only
peripheral mode was implemented, it continues to work as it did.
Of course enabling HOST mode may not magically make things work, but
I suspect this could be addressed from Kconfig itself instead.

Now I totally expect musb maintainer to jump in and explain
how many misconceptions I have ;)

Bye,
    Oleg

