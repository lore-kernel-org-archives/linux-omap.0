From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7x-evm: beagle-x14: Fix USB Peripheral
Date: Tue, 17 Mar 2015 11:02:57 -0700
Message-ID: <20150317180257.GH31346@atomide.com>
References: <1426585431-29914-1-git-send-email-rogerq@ti.com>
 <20150317145428.GA5001@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38144 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbbCQSHo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 14:07:44 -0400
Content-Disposition: inline
In-Reply-To: <20150317145428.GA5001@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, nm@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150317 07:55]:
> Hi,
> 
> On Tue, Mar 17, 2015 at 11:43:51AM +0200, Roger Quadros wrote:
> > Now that we have EXTCON_USB_GPIO queued for v4.1, revert
> > commit addfcde7c485 ("ARM: dts: dra7x-evm: beagle-x15: Fix USB Host")
> > 
> > On these EVMs, the USB cable state has to be determined via the
> > ID pin tied to a GPIO line. We use the gpio-usb-extcon driver
> > to read the ID pin and the extcon framework to forward
> > the USB cable state information to the USB driver so the
> > controller can be configured in the right mode (host/peripheral).
> > 
> > Gets USB peripheral mode to work on this EVM.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> on subject: x14 ? other than that
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v4.1/dt-v2 with the subject line fixed.

Tony
