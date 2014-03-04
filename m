From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for OMAP4 Gumstix
 DuoVero/Parlor
Date: Tue, 4 Mar 2014 10:17:31 -0800
Message-ID: <20140304181731.GD17470@atomide.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-2-git-send-email-florian.vaussard@epfl.ch>
 <5314549C.1030400@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12945 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070AbaCDSRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 13:17:44 -0500
Content-Disposition: inline
In-Reply-To: <5314549C.1030400@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ash Charles <ash@gumstix.com>

* Florian Vaussard <florian.vaussard@epfl.ch> [140303 02:12]:
> Hi Tony, Benoit,
> 
> On 02/24/2014 06:07 PM, Florian Vaussard wrote:
> > Gumstix DuoVero is an OMAP4430-based Computer On Module.
> > Parlor is one of the available expansion board.
> > 
> > Tested features:
> > - GPMC ethernet
> > - HSUSB2 and OTG
> > - Audio out
> > - WiFi and Bluetooth (w2cbw0015 SDIO module)
> > - LED and button
> > 
> 
> Can this patch go into 3.15? The other one (HDMI support) can wait for
> the DSS support to be merged, but I would like to give to this DTS a
> wider exposure to testing opportunities.

Thanks applying into omap-for-v3.15/dt.

Regards,

Tony
