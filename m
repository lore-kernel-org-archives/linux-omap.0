From: Mikko Rapeli <mikko.rapeli@teleca.com>
Subject: Re: Beagleboard B6 woes
Date: Thu, 3 Sep 2009 13:17:40 +0300
Message-ID: <20090903101740.GH4927@fitfioullt278>
References: <20090831093810.GE4927@fitfioullt278> <4A9BF95A.8000404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx01.teleca.com ([212.181.118.58]:31586 "EHLO mx01.teleca.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbZICK0M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Sep 2009 06:26:12 -0400
Content-Disposition: inline
In-Reply-To: <4A9BF95A.8000404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 31, 2009 at 11:24:58AM -0500, Jon Hunter wrote:
> If UNWIND is breaking it, then the most likely cause is that you are  
> using an older toolchain, such as code-sourcery 2007q3. If you are using  
>  2007q3, upgrade to a 2008 or 2009 release. More details here:
>
> http://marc.info/?l=linux-omap&m=124175324604568&w=2

I'm using Maemo SDK so cs2007q3-glibc2.5-arm7 it is. I'll give newer tool
chains a try.

>> On the other hand, setting ARM_UNWIND to n which falls back to FRAME_POINTERs
>> work until 84e250ffa76dddc1bad84e04248a27f442c25986 "musb: proper 
>> hookup to transceiver drivers".
>
> You could trying enabling "CONFIG_TWL4030_USB" to see if this helps.

This is already set and doesn't help.

Well, at least v2.6.29-omap1 from linux-omap tree works on my Beagle.

Thanks.

-Mikko
