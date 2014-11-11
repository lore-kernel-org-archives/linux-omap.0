From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: sbc-t3x: add DVI display data
Date: Tue, 11 Nov 2014 06:49:12 -0800
Message-ID: <20141111144911.GK31454@atomide.com>
References: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
 <1414927198-7127-1-git-send-email-lifshitz@compulab.co.il>
 <54561E45.7000404@compulab.co.il>
 <20141110174845.GP31454@atomide.com>
 <5461FAEF.3010607@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23218 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbaKKOt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2014 09:49:58 -0500
Content-Disposition: inline
In-Reply-To: <5461FAEF.3010607@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [141111 04:04]:
> Hi Tony,
> 
> On 11/10/14 19:48, Tony Lindgren wrote:
> > * Igor Grinberg <grinberg@compulab.co.il> [141102 04:08]:
> >> On 11/02/14 13:19, Dmitry Lifshitz wrote:
> >>> Add DSS related pinmux and display data nodes required to support
> >>> DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.
> >>>
> >>> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> >>
> >> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> > 
> > Thanks applying into omap-for-v3.19/dt.
> > 
> > Are we now ready to drop the board-cm-*.c files?
> 
> Let's see, below is a list of things that are yet to be
> supported in DT boot:
> NAND, TV, LCD, Touchscreen, Audio (CM-T3x30), RTC (CM-T3517), CAN (CM-3517).

OK great, hopefully that's mostly just configuring the .dts
files.
 
> We're rc4 now, so hopefully, we will be able to get all this in for 3.19
> and then have the board files removed for 3.20.

Yes something like that sounds good to me. We should allow at
least one release for people to change over.

> This way we can have 3.19 with both ways supported and do last checks.
> 
> Are you ok with this?

Sure if you get the changes posted before -rc6, otherwise
it will be too late for v3.19.

Regards,

Tony
