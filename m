From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: dts: sbc-t3x: add more features support
Date: Fri, 21 Nov 2014 16:16:00 -0800
Message-ID: <20141122001559.GJ7046@atomide.com>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
 <20141122000214.GH7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62285 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752356AbaKVAQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 19:16:13 -0500
Content-Disposition: inline
In-Reply-To: <20141122000214.GH7046@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [141121 16:04]:
> * Dmitry Lifshitz <lifshitz@compulab.co.il> [141118 01:15]:
> > Add support for more SBC-T3x single board computers features:
> > 
> > * CM-T3x CoM and SB-T35 baseboard EEPROMs
> > * TV out
> > * Touchscreen
> > * CM-T3x30 audio
> > * CM-T3x30 keypad
> 
> Applying all into omap-for-v3.19/dt-v2 thanks.

Had to remove pinctr reference for missing &i2c1_pins in
omap3-cm-t3x.dtsi for make dtbs to work. And had to drop
the audio and tv patches because missing reference to vdac.

Please update the missing patches against current
omap-for-v3.19/dt-v2 that I just pushed out.

Regards,

Tony
