From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Thu, 24 Jan 2013 13:21:14 +0100
Message-ID: <5101273A.9090800@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60926 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902Ab3AXMV0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 07:21:26 -0500
In-Reply-To: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

+ Peter who did the original PWM

Hi Florian,

On 01/23/2013 06:56 PM, Florian Vaussard wrote:
> Hello Benoit,
> 
> This patchset adds some new DT supports to the Overo products.
> The first patch converts the PMIC LEDB output to use the pwm-leds,
> newly merged in your branch for_3.9/dts. The second patch
> adds the audio support.

Excellent, that looks very good to me, but I'd like to get the feedback
from Peter before merging it.

Thanks,
Benoit

