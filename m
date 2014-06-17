From: Iain Paton <ipaton0@gmail.com>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Tue, 17 Jun 2014 15:08:28 +0100
Message-ID: <53A04BDC.1060403@gmail.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:43608 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaFQOIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 10:08:48 -0400
In-Reply-To: <20140617090931.GB3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Kridner <jkridner@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, OMAP List <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 17/06/14 10:09, Russell King - ARM Linux wrote:

> Why should kernel developers go to the extent of adding support for DT
> modification at runtime when the platform you want this for doesn't even
> support hotplugging of these capes?

I'm not convinced you should, but Grant Likely seemed to be much more open 
to the idea with the latest attempt https://lkml.org/lkml/2014/5/29/586

> A good way that this could have been done is to put an I2C EEPROM on
> each cape, and have that store the DT fragment.  The boot loader could
> have then read that from each cape, and used that information to build
> up the final DT.  Why this hasn't been thought of, considering that the
> kernel has been moving towards DT for years, is quite unbelievable.

I believe that was Jasons original idea.

>From a users perspective, a fixed DT fragment in EEPROM quickly ends up 
being out of step with OS implementation and simply becomes another 
pain point that needs worked around.

Anyway, there already exist capes in large scale production that don't 
have the EEPROM. As well as ones that use the required I2C bus for other 
purposes, thereby blocking all other capes connected at the same time 
from using that mechanism even when they are capable of doing so.
Not forgetting the number of capes that have shipped already without the
DT fragment in their EEPROMS.

Too late to shut the barn door, question is where to go from here.

Consolidation the dt knowledge in one tree is a good idea, regardless of 
how it's eventually used.


