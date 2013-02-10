From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 1/7] platform: add a device node
Date: Sun, 10 Feb 2013 09:37:08 +0000
Message-ID: <20130210093708.GL17852@n2100.arm.linux.org.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk> <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk> <20130210010246.GA1455@kroah.com> <5116FCA1.40703@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39605 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab3BJJhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 04:37:47 -0500
Content-Disposition: inline
In-Reply-To: <5116FCA1.40703@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

On Sun, Feb 10, 2013 at 02:49:21AM +0100, Javier Martinez Canillas wrote:
> I knew this would be controversial and that's why I didn't mean it to be a patch
> but a RFC :)
> 
> The problem basically is that you have to associate the platform device with its
> corresponding DT device node because it can be used in the driver probe function.

When DT is being used, doesn't DT create the platform devices for you,
with the device node already set correctly?

Manually creating platform devices and adding DT nodes to it sounds like
the wrong thing to be doing.
