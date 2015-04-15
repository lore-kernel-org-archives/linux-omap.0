From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v4 3/7] drm/tilcdc: Add support for external tda998x encoder
Date: Wed, 15 Apr 2015 18:04:16 +0300
Message-ID: <552E7DF0.9020105@ti.com>
References: <cover.1427877412.git.jsarha@ti.com> <e22d703d6ee5fe02e8c34b78a63f98a4b2ea1f22.1427877412.git.jsarha@ti.com> <20150401222030.GD4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41498 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755663AbbDOPEf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 11:04:35 -0400
In-Reply-To: <20150401222030.GD4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, tomi.valkeinen@ti.com, robdclark@gmail.com, moinejf@free.fr

On 04/02/15 01:20, Russell King - ARM Linux wrote:
> This is where the DRM model is weak - we don't really have a way to
> say "this is the set of CRTCs which/can/  be associated with this
> connector, can any of the CRTCs accept this mode?" and eliminate
> modes which fail that check.
>
> This problem seems to be one which recurrs, so I wonder if it's
> something which ought to be solved properly.
>
> It's made slightly more difficult because we don't really know which
> connectors could be associated with which CRTCs - that information is
> stored at the encoder level (with the encoders possible_crtcs), and
> I'm not sure we have a way for generic DRM code to know which encoders
> could be associated with which connectors.

I agree that this is not the most elegant solution to the problem, but 
it works with Beaglebone-Black - which is AFAIK the only piece of HW 
that uses tda998x with tilcdc.

I would like to get these patches merged and revisit the mode validation 
code once we have a better solution for it.

Best regards,
Jyri
