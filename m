From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: gpio/omap v2: map irq_enable/disable to mask/unmask.
Date: Thu, 11 Apr 2013 15:18:42 +0200
Message-ID: <20130411131842.GA9331@blumentopf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52993 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab3DKNSr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Apr 2013 09:18:47 -0400
Received: from mailout-de.gmx.net ([10.1.76.35]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Leg4G-1UvR8t32Ny-00qTsM for
 <linux-omap@vger.kernel.org>; Thu, 11 Apr 2013 15:18:45 +0200
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: jon-hunter@ti.com, khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org

Hi Santosh,

I submitted the following patch a while back.
https://patchwork.kernel.org/patch/1886421/

As already said, the patch is straight forward, but without it,
we probably will not see decent SDIO performance on am335x chips.

[why it is needed]

The omap_hsmmc module is suspended whenever it is idle, its
functional clock being turned off. In this mode it is not able to
forwared IRQs to the system. For that to happen, it needs to tell
the PRCM to restore it's fclk.

                   ------
                  | PRCM |
                   ------
                    | ^
               fclk | | swakeup
                    v |
                  -------               ------
      <-- IRQ -- | hsmmc | <-- CIRQ -- | card |
                  -------               ------

This is done through the swakeup line, which can be configured to
trigger for various events, among others; CIRQ. The problem is
that on the AM335x family the swakeup line is missing, it has not
been routed from the module to the PRCM.

[solution]
the simplest solution was to keep the fclk enabled all the
time. But that was not accepted, instead this was suggested

> > The alternative was to configure dat1 line as a GPIO, while
> > waiting for an IRQ. Then configuring it back as dat1 to serve
> > the SDIO card after it signalled an IRQ. Or when the host
> > wants to start a transfer.
>
> The way to implement this is set named states in the .dts file
> for the pins using pinctrl-single.c, then have the MMC driver
> request states "default" "active" and "idle" during the probe,
> then toggle between active and idle during the runtime.

Surprisingly the induced overhead is quite small, the performance
is similar to keeping the fclk enabled at all times. See here
for full thread:
http://www.spinics.net/lists/linux-omap/msg83363.html
https://patchwork.kernel.org/patch/1901471/  ... or just the patch

There are still open questions to gpio patch itself, see here
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg87217.html

So could we pls reopen that thread? It might be on the other side
of your mailbox

rgds,
Andi

