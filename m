From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 17/26] ARM: omap3-tobi.dts: add lcd (TEST)
Date: Fri, 06 Dec 2013 11:18:58 +0100
Message-ID: <52A1A492.8090205@epfl.ch>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-18-git-send-email-tomi.valkeinen@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:54505 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543Ab3LFKTD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Dec 2013 05:19:03 -0500
In-Reply-To: <1386160133-24026-18-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

Hello Tomi,

On 12/04/2013 01:28 PM, Tomi Valkeinen wrote:
> This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
> doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I used
> it as a test.
> 

Looking at the schematics, both seem pretty similar indeed. The main
difference seems to be the LCD on the palo43, and the HDMI on the Tobi
(TFP410, as in your patch 21).

I only have a Tobi on my desk, so this is the reason for not supporting
other boards... We could make a .dtsi with common stuff, then add the
LCD to the Palo43 and HDMI to the Tobi. I was going to add some more
support to these boards in the coming days, so I can add this too, at
least for testing purpose.

Cheers,

Florian
