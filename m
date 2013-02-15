From: Roger Quadros <rogerq@ti.com>
Subject: Re: OMAP EHCI having clock problems?
Date: Fri, 15 Feb 2013 09:54:19 +0200
Message-ID: <511DE9AB.5080403@ti.com>
References: <87halea4s3.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55125 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875Ab3BOHyW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 02:54:22 -0500
In-Reply-To: <87halea4s3.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Kevin,

On 02/15/2013 12:50 AM, Kevin Hilman wrote:
> Felipe, Roger,
> 
> Using Tony's current master branch, and enabling EHCI support, I see 
> the clock framework spitting loudly about the EHCI driver (full boot log
> below.)   The same thing happens on v3.8-rc7.
> 
> Any idea what's going on?  Am I missing a set of fixes that's already
> been posted?

Thanks for pointing out. This series should fix the issues
https://lkml.org/lkml/2013/1/23/155

They should be on their way to linux-next.

> 
> On a related note, is anyone planning to fix the runtime PM problems in
> this driver?  It's still disabled by default in omap2plus_defconfig
> because the driver keeps CORE from hitting retention, even when no
> devices are attached.

I would be working on it. It is all about getting the silicon erratas
worked around and making sure USB suspend/resume works.

cheers,
-roger
