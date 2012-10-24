From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP: Move interrupt-parent to the root node
 to avoid duplication
Date: Wed, 24 Oct 2012 12:56:46 +0200
Message-ID: <5087C96E.7020906@ti.com>
References: <5087BCA6.1020602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51496 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933507Ab2JXK4y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 06:56:54 -0400
In-Reply-To: <5087BCA6.1020602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Guiriec, Sebastien" <s-guiriec@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 10/24/2012 12:02 PM, Benoit Cousson wrote:
> The interrupt-parent attribute does not have to be added in each
> node since the DT framework will check for the parent as well to get it.
> 
> Create an interrupt-parent for OMAP2, OMAP3, AM33xx and remove the
> attributes from every nodes that were using it.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Sebastien Guiriec <s-guiriec@ti.com>

Thanks Benoit, looks good from my side.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


