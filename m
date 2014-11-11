From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2] ARM: dts: sbc-t3x: add DVI display data
Date: Tue, 11 Nov 2014 14:02:55 +0200
Message-ID: <5461FAEF.3010607@compulab.co.il>
References: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il> <1414927198-7127-1-git-send-email-lifshitz@compulab.co.il> <54561E45.7000404@compulab.co.il> <20141110174845.GP31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:51532 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbaKKMDE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2014 07:03:04 -0500
In-Reply-To: <20141110174845.GP31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, =?ISO-8859-1?Q?Beno=EEt_?= =?ISO-8859-1?Q?Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 11/10/14 19:48, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [141102 04:08]:
>> On 11/02/14 13:19, Dmitry Lifshitz wrote:
>>> Add DSS related pinmux and display data nodes required to support
>>> DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.
>>>
>>> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
>>
>> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> Thanks applying into omap-for-v3.19/dt.
> 
> Are we now ready to drop the board-cm-*.c files?

Let's see, below is a list of things that are yet to be
supported in DT boot:
NAND, TV, LCD, Touchscreen, Audio (CM-T3x30), RTC (CM-T3517), CAN (CM-3517).

We're rc4 now, so hopefully, we will be able to get all this in for 3.19
and then have the board files removed for 3.20.
This way we can have 3.19 with both ways supported and do last checks.

Are you ok with this?

-- 
Regards,
Igor.
