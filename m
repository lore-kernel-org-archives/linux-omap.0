From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Wed, 5 Jan 2011 22:03:49 +0000
Message-ID: <20110105220349.GA22857@n2100.arm.linux.org.uk>
References: <201005152214.53993.sshtylyov@ru.mvista.com> <4D21F3F2.6090302@mvista.com> <20110103163447.GB2911@n2100.arm.linux.org.uk> <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com> <4D220246.5020303@mvista.com> <19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com> <20110103204416.GA2240@legolas.emea.dhcp.ti.com> <4D231B5F.7030607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44294 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1AEWEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 17:04:11 -0500
Content-Disposition: inline
In-Reply-To: <4D231B5F.7030607@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 04, 2011 at 04:06:39PM +0300, Sergei Shtylyov wrote:
>    Putting MUSB DMA enignes into drivers/dma/ is the same as taking *any* 
> chip capable of bus-mastering DMA, "separating" its bus mastering related 
> code from its driver and putting this code into drivers/dma/. This 
> doesn't make sense, in my opinion. drivers/dma/ is for the dedicated DMA 
> controllers (which can *optionally* serve the slave devices).

Then why is it already separated into its own self-contained driver?

If it's because the DMA engine is used for different peripherals (possibly
re-used for different peripherals), then it does seem to make sense to
have it separated via some API.  And if possible that API might should
be something generic instead of specific.

Even more reason to do this is if the device being fed by the DMA has
been re-used with different DMA hardware (which I believe is the case
with MUSB.)  What if this different DMA hardware then gets re-used for
other devices?  Should they all implement the same custom API or try
for a generic API?
