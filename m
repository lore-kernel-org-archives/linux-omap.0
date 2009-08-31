From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: Beagleboard B6 woes
Date: Mon, 31 Aug 2009 11:24:58 -0500
Message-ID: <4A9BF95A.8000404@ti.com>
References: <20090831093810.GE4927@fitfioullt278>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49479 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbZHaQZl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Aug 2009 12:25:41 -0400
In-Reply-To: <20090831093810.GE4927@fitfioullt278>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@teleca.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Mikko Rapeli wrote:
> Hello,
> 
> I'd like to test out newer kernel on a Beagleboard B6 but latest
> trees from Linus, linux-omap and linux-omap/for-next seem to be failing at
> early boot [1] with omap3_beagle_defconfig.
> 
> Some bisecting shows that ARM_UNWIND broke something in the defconfig since
> kernels before adf8b37bafc1495393201a2ae4235846371870d0 "[ARM] 5386/2:
> unwind: Add Makefile and Kconfig entries for ARM stack unwinding" work.

If UNWIND is breaking it, then the most likely cause is that you are 
using an older toolchain, such as code-sourcery 2007q3. If you are using 
  2007q3, upgrade to a 2008 or 2009 release. More details here:

http://marc.info/?l=linux-omap&m=124175324604568&w=2

> On the other hand, setting ARM_UNWIND to n which falls back to FRAME_POINTERs
> work until 84e250ffa76dddc1bad84e04248a27f442c25986 "musb: proper hookup to 
> transceiver drivers".

You could trying enabling "CONFIG_TWL4030_USB" to see if this helps.

Jon

