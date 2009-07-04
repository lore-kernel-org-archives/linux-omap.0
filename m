From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] [RFC] OMAP1: AMS_DELTA: add modem support
Date: Sat, 4 Jul 2009 12:03:33 +0200
Message-ID: <200907041203.35130.jkrzyszt@tis.icnet.pl>
References: <200907040206.42940.jkrzyszt@tis.icnet.pl> <20090704085721.GA29751@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36607 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315AbZGDKER (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 4 Jul 2009 06:04:17 -0400
In-Reply-To: <20090704085721.GA29751@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

Saturday 04 July 2009 10:57:21 Felipe Balbi wrote:
> you should avoid OMAP_GPIO_IRQ() and use gpio_to_irq(), but for that

Thanks, I'll change that and resubmit.

Janusz
