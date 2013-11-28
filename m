From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH] ARM: DTS: omap4-sdp: Add regulator for LCD backlight
 (pwm-backlight)
Date: Thu, 28 Nov 2013 15:39:17 +0530
Message-ID: <5297164D.9060400@ti.com>
References: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40539 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3K1KJp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Nov 2013 05:09:45 -0500
In-Reply-To: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tomi.valkeinen@ti.com

On Thursday 28 November 2013 02:58 PM, Peter Ujfalusi wrote:
> Since in DT booted kernel dummy regulators are no longer supported we need
> to provide valid phandle for the regulator needed by the backlight.
> On the board VBAT is used to power the LCD backlight(s).
>
> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> ---
> Hi,
>
> This patch is needed for 3.13 to get the LCD backlight to work again.
Is this usage of power supply a mandatory requirement?

There is a thread which discusses this issue[1]:
http://www.spinics.net/lists/arm-kernel/msg288215.html

According to the above, regulator framework have support in 3.13-rc1 to 
returns
a dummy  regulator if there is none specified in the dts data.
Thierry told that there seems to be a bug in regulator in handling these 
case.

Though, I also posted a patch on pwm a couple of days ago[2]
[2]: https://patchwork.kernel.org/patch/3246711/

I posted it without "power-supply" by testing it with the
solution proposed in [1].
If I dont use the solution[1], it fails for me also.

