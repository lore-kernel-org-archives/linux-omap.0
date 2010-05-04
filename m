From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/5(7)] input: serio: add support for Amstrad Delta
 serial keyboard port
Date: Tue, 4 May 2010 13:40:41 -0700
Message-ID: <20100504204041.GL29604@atomide.com>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl>
 <201004280310.52678.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50550 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760169Ab0EDUks (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 16:40:48 -0400
Content-Disposition: inline
In-Reply-To: <201004280310.52678.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100427 18:09]:
> The patch introduces a serio driver that supports a keyboard serial port found
> on the Amstrad Delta videophone board.
> 
> After initializing the hardware, the driver reads its input data from a buffer
> filled in by the board FIQ (Fast Interrupt Request) handler.
> 
> Standard AT keyboard driver (atkbd) will be used on top of the serio layer for 
> handling the E3 keyboard (called mailboard) connected to the port. Since the 
> device generated scancodes differ from what the atkbd expects, a custom key 
> code to scan code table must be loaded from userspace for the keyboard to be 
> useable.
> 
> Compiles and works on top of PATCH v4 3/5(7), "OMAP1: Amstrad Delta: use FIQ 
> for processing GPIO interrupts".

I'll add this series into omap for-next. Will also add Dmitry's ack
from the earlier series to this patch.

Regards,

Tony
