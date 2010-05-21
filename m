From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: collaboration on hwmod conversions and runtime PM
Date: Fri, 21 May 2010 16:28:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA7EE5@dbde02.ent.ti.com>
References: <87mxvucekw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44320 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab0EUK6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 06:58:19 -0400
In-Reply-To: <87mxvucekw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, May 21, 2010 5:27 AM
> To: linux-omap@vger.kernel.org
> Subject: collaboration on hwmod conversions and runtime PM
> 
> Hello,
> 
> There has been quite a bit of activity on the hwmod front, but no
> common place to combine patches for testing.
> 
> To that end, I've update the pm-wip/hwmods branch in my tree to 
> the two fixes/cleanup series from Benoit (which will be merged
> via for 2.6.35):
> 
>   [PATCH 00/10] OMAP: HWMOD fixes and cleanup
>   [PATCH 0/5] OMAP4: PRCM: Spring cleanup
> 
> On top of this, there is the pm-wip/hwmods-omap4 branch which includes
> the OMAP4 series from Benoit
> 
>   [PATCH 0/6] OMAP: hwmod: Full data set for OMAP4430 ES1.0
> 
> so that conversions for OMAP4 can also be done and tested.  Note that
> I've reverted the two "temporary" patches in this series since they
> cause problems on OMAP3,

Hi Kevin,

These temp patches might not be needed anymore, even for omap4. The clockdomain
has cpu checks to take care of the dependency, and there is already a patch from
Santosh to keep the emif clocks always active.

If you pull these 2 patches, we don't need the hacks anymore and multi omap build
would work as well on these branches.
https://patchwork.kernel.org/patch/100932/
https://patchwork.kernel.org/patch/96048/

I was able to boot test on my 4430sdp with these 2 patches on pm-wip/hwmods-omap4
branch.

regards,
Rajendra

> 
> On top of this, there is the pm-wip/runtime branch which includes
> the base runtime PM implementation for OMAP.
> 
> On top of this there are work-in-progress branches for the conversions
> for UART (pm-wip/uart) and MMC (pm-wip/mmc)
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 