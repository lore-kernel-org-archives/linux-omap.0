From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Mon, 30 Mar 2015 20:45:08 +0300
Message-ID: <55198BA4.5010207@bitmer.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com> <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:54672 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbbC3Rp4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 13:45:56 -0400
In-Reply-To: <20150330164237.GJ10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Pavel Machek <pavel@ucw.cz>

On 03/30/2015 07:42 PM, Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@bitmer.com> [150330 09:31]:
>> On 03/01/2015 09:07 PM, Jarkko Nikula wrote:
>>> From: Pavel Machek <pavel@ucw.cz>
>>>
>>> N900 audio recording needs that codec provides bias voltage for integrated
>>> digital microphone and headset microphone depending which one is used.
>>> Digital microphone uses 2 V bias and it comes from the codec A part. Codec
>>> B part drives the headset microphone bias and that is set to 2.5 V.
>>>
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>> [Jarkko: Headset mic bias changed to 2 (2.5 V) as it was before commit
>>> e2e8bfdf6157 ("ASoC: tlv320aic3x: Convert mic bias to a supply widget")]
>>> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
>>> ---
>>>  arch/arm/boot/dts/omap3-n900.dts | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>> Ping?
> 
> Oops sorry I have missed this one. This looks like a regression fix
> for the v4.0-rc series? Should it be cc stable v3.16+ or something?
> 
Well, there has been regression but finding exactly how far should the
fix go didn't look instantly straightforward due all DT, codec driver
mic bias etc changes and I ended up not cc'ing stable.

But well, I guess first kernel where this commit makes sense is 3.16+
due commit f7d0f2a08567 ("ARM: dts: omap3-n900: Add sound support").
Although it applies on top of commit 14e3e295b2b9 ("ARM: dts:
omap3-n900: Add TLV320AIC3X support") too (3.12+) but not before that.

-- 
Jarkko
