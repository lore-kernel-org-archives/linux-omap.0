From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] can: c_can: use regmap_update_bits() to modify RAMINIT
 register
Date: Mon, 12 Jan 2015 14:37:21 +0200
Message-ID: <54B3C001.501@ti.com>
References: <1420641162-8634-1-git-send-email-rogerq@ti.com> <54AFDCB0.5060908@ti.com> <54B39A8E.4090006@ti.com> <54B39BAD.4070604@ti.com> <20150112120541.GD4160@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbbALMhi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2015 07:37:38 -0500
In-Reply-To: <20150112120541.GD4160@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mkl@pengutronix.de, linux-can@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de, linux-omap@vger.kernel.org

On 12/01/15 14:05, Mark Brown wrote:
> On Mon, Jan 12, 2015 at 12:02:21PM +0200, Roger Quadros wrote:
>> +Mark with correct id.
> 
> Please fix your mail client to word wrap within paragraphs, it amkes
> your mail more legible.

Fixed now. Thanks for pointing out.

> 
>>> The problem here is we can't use regmap_update_bits() because we need to write a 1 to the DONE bit to clear it and _regmap_update_bits() doesn't allow us to do that because of commit
>>> d91e8db2c3bb regmap: Suppress noop writes in regmap_update_bits()
>>>
>>> Is reverting it going to cause other issues? If yes then can we have a flag to specify forced update?
> 
> The usual thing to do here is an explicit write clearing the latch,
> either immediately after setting it or immediately before setting it.
> If the register is marked as volatile and the hardware doesn't read back
> the latched state that also does the trick.
> 

How does this work if driver has access to only 1 bit that can only be
written with 1 to clear a condition? Writing a 0 is no-op.
It can read back 0 or 1 depending on the condition.

I didn't understand the volatile trick :P.

cheers,
-roger

