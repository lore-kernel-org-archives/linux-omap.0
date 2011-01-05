From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register
Date: Wed, 5 Jan 2011 08:56:43 +0200
Message-ID: <20110105065643.GE2458@legolas.emea.dhcp.ti.com>
References: <1294148397-26582-1-git-send-email-tom.leiming@gmail.com>
 <87ipy442i7.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48989 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab1AEG4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 01:56:48 -0500
Received: by eyf5 with SMTP id 5so6037854eyf.29
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 22:56:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87ipy442i7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tom.leiming@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Tue, Jan 04, 2011 at 04:29:04PM -0800, Kevin Hilman wrote:
> tom.leiming@gmail.com writes:
> 
> > From: Ming Lei <tom.leiming@gmail.com>
> >
> > Panda uses twl6030 otg phy instead of internal phy,

This is wrong, it uses both. TWL6030 handles VBUS and ID pin
and the internal PHY handles Data Lines. I know it's a bit
crazy but this kind of design is becoming more and more usual
on different boards.

What truly needs to happen is that we allow for multiple PHYs
to be added to otg_transceiver (BTW, that's a mis-naming as
transceiver aren't only for OTG use-cases).

Anyway, change this phrasing.

> > so removes usb_nop_xceiv_register to make musb working.
> >
> > Cc: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Considering you change the commit log above:

Reviewed-by: Felipe Balbi <balbi@ti.com>

This is ok, but can only go after 2.6.38 merge window. There are patches
to add support for internal PHY. Ideally we would actually register both
PHYs and it would work. They would have different capabilities, though.

-- 
balbi
