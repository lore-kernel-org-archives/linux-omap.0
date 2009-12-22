From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/3] OMAP: DSS: Low power refresh rate support for dss
Date: Tue, 22 Dec 2009 13:13:46 +0200
Message-ID: <1261480426.2108.81.camel@tubuntu.research.nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60970 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbZLVLOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 06:14:37 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Y, Kishore" <kishore.y@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2009-12-22 at 10:37 +0100, ext Y, Kishore wrote:
> These patches add Low Power Refresh functionality for DSS.
> Short info on patches
> 
> DSS PM_WKEN to refill DMA
> 	- DMA request to refill the FIFO will wake up the CORE domain
> DSS2 LPR enable and disable function definition
> 	- LPR enable and disable functions implementing FIFO merge
> DSS2 sysfs enteries to export LPR enable to user
> 	- sysfs entries for above methods

I don't like this approach very much. Fifo merge should be automatic,
not user configurable. It should be integrated into the apply/cache
mechanism in manager.c.

I actually implemented fifo merge at some point during DSS2 development,
but I had to remove it when changing the driver/device model. I haven't
had time to implement it again, as it not very trivial. The old version
can be found in N900's kernel, and earlier snapshots of DSS2.

 Tomi


