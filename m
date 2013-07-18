From: "Arend van Spriel" <arend@broadcom.com>
Subject: Re: Regression 3.11-rc1: omap4panda: no usb and consequently no
 ethernet
Date: Thu, 18 Jul 2013 12:18:09 +0200
Message-ID: <51E7C0E1.5090705@broadcom.com>
References: <51E7AA24.6080600@broadcom.com>
 <20130718085951.GT7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4637 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab3GRKSR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jul 2013 06:18:17 -0400
In-Reply-To: <20130718085951.GT7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>

On 07/18/2013 10:59 AM, Tony Lindgren wrote:
> * Arend van Spriel <arend@broadcom.com> [130718 01:47]:
>> So my first step was to follow the recipe given in that commit.
>> Beside that I noticed a thread about USB issue on LKML so I also
>> applied the following commit:
>>
>> commit 352f573e59050c7a604c35c58b4bbfc51edebbee
>> Author: Roger Quadros <rogerq@ti.com>
>> Date:   Tue Jun 18 19:04:47 2013 +0300
>>
>>      ARM: OMAP2+: Provide alias to USB PHY clock
>>
>> The attached kernel log seems to suggest that the device tree is
>> picked up by the kernel, but the USB does not seem very active. No
>> ethernet connectivity. This does seem a regression to me. Is there
>> some other patch that I need to get it going again?
>
> There are few .dts related patches missing for USB. Roger can
> point you to the current versions that Benoit should be queueing
> for the -rc series.

Hope Roger or Benoit will chime in.

> Then for the SDIO with device tree, take a look at the following
> patches:
>
> [PATCH 0/3] WLAN support for omap4 when booted with devicetree
> http://comments.gmane.org/gmane.linux.ports.arm.omap/97522#
>
> The wl12xx .dts changes for pandaboard are still missing too.
>
> Then I'll be updating these soonish:
> [PATCH 0/4] Updated omap_hsmmc SDIO and remuxing patches
>
> Those are needed for the SDIO interrupt, SDIO will work also
> without those.

Thanks for the pointers,

Arend


