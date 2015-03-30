From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Mon, 30 Mar 2015 19:30:10 +0300
Message-ID: <55197A12.1050009@bitmer.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:54668 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbbC3QbC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 12:31:02 -0400
In-Reply-To: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>

On 03/01/2015 09:07 PM, Jarkko Nikula wrote:
> From: Pavel Machek <pavel@ucw.cz>
> 
> N900 audio recording needs that codec provides bias voltage for integrated
> digital microphone and headset microphone depending which one is used.
> Digital microphone uses 2 V bias and it comes from the codec A part. Codec
> B part drives the headset microphone bias and that is set to 2.5 V.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> [Jarkko: Headset mic bias changed to 2 (2.5 V) as it was before commit
> e2e8bfdf6157 ("ASoC: tlv320aic3x: Convert mic bias to a supply widget")]
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Ping?

-- 
Jarkko

