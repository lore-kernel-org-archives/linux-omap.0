From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] OMAP: UART: Enable tx wakeup bit in wer
Date: Wed, 25 Jan 2012 12:18:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251217120.5324@utopia.booyaka.com>
References: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Partha Basak <p-basak2@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

cc'ing linux-arm-kernel also (correct address this time)

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
