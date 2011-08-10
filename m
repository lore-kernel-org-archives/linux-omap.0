From: David Brown <davidb@codeaurora.org>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 12:57:54 -0700
Message-ID: <20110810195753.GA29134@huya.qualcomm.com>
References: <4E4172A8.3030101@ti.com>
 <4E417BD5.8080409@freescale.com>
 <20110809205723.GE11568@ponder.secretlab.ca>
 <4E41A1B9.1060400@ti.com>
 <20110809211747.GJ11568@ponder.secretlab.ca>
 <4E41AA43.1000506@ti.com>
 <20110809214905.GK11568@ponder.secretlab.ca>
 <4E41AC5C.20301@ti.com>
 <20110810015214.GD23511@yookeroo.fritz.box>
 <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:16065 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab1HJT5z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 15:57:55 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6tr5OUxpiVah4s6rRG0cTOWsnohhEkZoSZgCj0xSZkmMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 10, 2011 at 01:22:16PM -0600, Grant Likely wrote:

> Please, stick with the established convention and explicitly order
> 'reg' and 'interrupts' properties.  If there is a specific use case
> where this doesn't work, then bring it up, but I haven't seen any yet.
>  The current users of _byname that I've looked seem to only use it for
> convenience, not because a register range may be optional.  ie. they
> all fail out if a reg resource isn't present.

The msm_serial driver uses the presence of one of it's _byname reg
regions to distinguish between two different types of the controller.
Fortunately, it is the last register range that has this.

It's probably best to make the DT code depend on compatible (or some
attribute) to determine if this functionality is available, or in this
case, even make it a separate memory region.  I'm not sure what the
cleanest way is to implement this, and still have the driver work with
non-DT systems.

Patches coming soon...

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
