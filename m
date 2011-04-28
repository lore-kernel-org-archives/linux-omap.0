From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] omap: musb: introduce default baord config
Date: Thu, 28 Apr 2011 17:28:20 +0100
Message-ID: <20110428162820.GF19709@n2100.arm.linux.org.uk>
References: <cover.1303682352.git.mike@compulab.co.il> <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il> <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru> <20110428141818.GE19709@n2100.arm.linux.org.uk> <9B236748-29D6-4129-AFCD-5D223CE18ECD@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58246 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760662Ab1D1Q2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 12:28:33 -0400
Content-Disposition: inline
In-Reply-To: <9B236748-29D6-4129-AFCD-5D223CE18ECD@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Apr 28, 2011 at 12:21:47PM -0400, Oleg Drokin wrote:
> Frankly, I am not even sure why the mode needs to be supplied by the board at all.
> The musb code already  has a very similar switch in musb_plat and so it totally looks like
> a duplicated specification of the same thing from the board file and from
> generic musb code where the original init value is then ignored.
> 
> I see that in .29 the board file did not need to specify usb mode and it was all decided
> in musb-specific code, and I have no idea why that was later changed to the way it is now.
> 
> Would it just be better if a patch removing mode field from struct omap_musb_board_data
> is adopted like this (warning - not a real patch)?

Hmm, it looks to me like we're ending up with two layers on top of
each other, both trying to provide some kind of generic board interface.

I think they should be squashed together.  And that:

static struct musb_hdrc_platform_data musb_plat = {
#ifdef CONFIG_USB_MUSB_OTG
        .mode           = MUSB_OTG,
#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
        .mode           = MUSB_HOST,
#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
        .mode           = MUSB_PERIPHERAL,
#endif

in usb-musb.c needs the same treatment as I mentioned in the previous
message if it really is board specific.  If not, I see no reason why
the above can't go into the musb driver itself.
