From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] OMAP: UART: Enable tx wakeup bit in wer
Date: Wed, 25 Jan 2012 12:14:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251209430.5324@utopia.booyaka.com>
References: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44356 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab2AYTOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 14:14:47 -0500
In-Reply-To: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>, linux-arm-kernel@vger.kernel.org

cc'ing linux-arm-kernel also

Hi

some comments

On Tue, 24 Jan 2012, Govindraj.R wrote:

> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> On omap3630 onwards uart wer reg has bit 7
> for tx wakeup enable.
> 
> Without this bit set some uart sluggishness might be seen
> while printing data on console, response is better when
> enabling this bit.
> Tested with Beagle XM (OMAP3630)
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> But on omap3430 the bit is not available.

Well that's good news that it exists on 36xx+ at least.
 
But please make a few changes.

This shouldn't set this bit on UARTs that don't support it.  It should 
only be set if a hwmod dev_attr flag was set to indicate the presence of 
this feature.  Using a flag is also important since it will allow us to 
disable the workaround that we'll need for earlier OMAPs.

Also, I assume that this does not fix the RX sluggishness due to the 
missing RX timeout wakeup?

Also, this assignment should be using symbolic macros rather than raw 
bits.


- Paul
