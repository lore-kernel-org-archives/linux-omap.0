From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v4 4/4] ARM: OMAP2+: Add pdata quirk for sys_clkout2
 for omap3 DBB056
Date: Wed, 05 Mar 2014 14:25:32 +0100
Message-ID: <1394025932.16566.44.camel@mars>
References: <1392387656-15186-1-git-send-email-chf.fritz@googlemail.com>
	 <1392387656-15186-5-git-send-email-chf.fritz@googlemail.com>
	 <20140228223741.GM13624@atomide.com>  <53172175.5060603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:47861 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbaCENZi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 08:25:38 -0500
In-Reply-To: <53172175.5060603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, 2014-03-05 at 15:07 +0200, Tero Kristo wrote:
> On 03/01/2014 12:37 AM, Tony Lindgren wrote:
> > * Christoph Fritz <chf.fritz@googlemail.com> [140214 06:24]:
> >> Full device tree support for clock control, especially to set frequencies,
> >> is not yet accomplished. Until then, configure the 24Mhz of sys_clkout2 to
> >> feed an USB-Hub here.
> >
> > Hmm would like to see Tero's comments on this, I wonder if we should
> > wait on this to avoid extra churn?
> 
> Well, the set I posted that adds default clock parenting / default rate 
> support to DT hasn't actually moved forward, so you might want to take 
> this in as is now if it should be rushed. The clk-enable part isn't done 
> currently by anything anyway. Just wondering though, should you create 
> some sort of driver for your usb-hub which would control these clocks?

The USB-Hub, a USB2512 is wired as non-configurable. Its pin
'XTAL1/CLKIN' can be connected to either a crystal or an external clock
input. To economise the crystal, the clock-out of the omap is wired
here.

So in my view, a driver is unnecessary.

 Thanks
  -- Christoph


