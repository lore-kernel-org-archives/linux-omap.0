From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 5/5] ARM: dts: OMAP2+: Identify GPIO banks that are always
 powered
Date: Thu, 4 Apr 2013 16:01:17 -0500
Message-ID: <515DEA1D.9070001@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com> <1365106576-31816-6-git-send-email-jon-hunter@ti.com> <20130404203519.GR10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57161 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762307Ab3DDVB2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 17:01:28 -0400
In-Reply-To: <20130404203519.GR10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>


On 04/04/2013 03:35 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130404 13:21]:
>> Add the "ti,gpio-always-on" property to the appropriate GPIO banks to
>> indicate which banks are always powered and will never lose logic state.
> 
> This patch should be queued by Benoit as this will likely cause
> pointless merge conflicts with the other .dts files.

Yes agreed. I mentioned that in the cover-letter.

Cheers
Jon
