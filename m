From: "Porter, Matt" <mporter@ti.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 18:24:48 +0000
Message-ID: <A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
 <20120321181259.GJ3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50959 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795Ab2CUSYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 14:24:54 -0400
In-Reply-To: <20120321181259.GJ3226@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <F28E7DE18430EF4B9198FC37F454E894@owa.mail.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Dill, Russ" <russ.dill@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<tony@atomide.com>" <tony@atomide.com>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>


On Mar 21, 2012, at 2:13 PM, Mark Brown wrote:

> On Wed, Mar 21, 2012 at 10:55:54AM -0700, Russ Dill wrote:
> 
>> unwieldy this would become if it were done for every device. Either the
>> functionality needs to be moved to Snowball board init code, or a generic
>> framework needs to be made for attaching regulators to arbitrary devices.
> 
> Hrm?  Adding regulator supply mappings anywhere other than the
> initialisation for a specific board would be extremely unusual and
> rather suspicious.

Just to be clear, here is the thread on the board-specific approach:
https://lkml.org/lkml/2012/2/8/415

-Matt
