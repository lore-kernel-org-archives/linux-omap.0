From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: Add omap-twl4030 audio support
Date: Thu, 28 Nov 2013 19:04:11 +0200
Message-ID: <5297778B.7010305@bitmer.com>
References: <1385578008-6623-1-git-send-email-jarkko.nikula@bitmer.com> <20131127220258.GE26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48114 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab3K1REU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Nov 2013 12:04:20 -0500
In-Reply-To: <20131127220258.GE26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>

On 11/28/2013 12:02 AM, Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@bitmer.com> [131127 10:48]:
>> This adds typical McBSP2-TWL4030 audio description to the legacy
>> Beagle Board.
> 
> Nice to see that work almost out of the box :)
> 
> BTW, I just noticed that sound/soc/omap/Kconfig has depends on
> OMAP_MUX. The OMAP_MUX option will be dropped for mach-omap2
> for v3.14, so you may want to take a look at that too. If there
> really is a dependency, that should be handled using
> pinctrl-single for the .dts entries.
> 
There is actually dependency but only on N810 which needs to remux 4
pins from EAC to McBSP2. I'll try to keep my eye on it but don't let
that block your cleanup work.

-- 
Jarkko
