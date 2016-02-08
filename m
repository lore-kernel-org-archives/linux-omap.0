From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/2] memory: omap-gpmc: Add support for AAD timings
Date: Mon, 8 Feb 2016 14:51:24 +0200
Message-ID: <56B88F4C.2040002@ti.com>
References: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
 <1451309961-7247-2-git-send-email-narmstrong@baylibre.com>
 <20160127185815.GW19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160127185815.GW19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 27/01/16 20:58, Tony Lindgren wrote:
> * Neil Armstrong <narmstrong@baylibre.com> [151228 05:39]:
>> In order to support extended timings parameters on hardware supporting the
>> "AAD" mode like the AM335x or DM816x, add these entries into the GPMC driver
>> if the hardware is capable.
>>
>> Tested on DM816x and AM335x.
> 
> Both look OK to me, assuming Roger will queue these:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Thanks. Queuing both for -next.

cheers,
-roger
