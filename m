From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.11
Date: Thu, 20 Jun 2013 15:48:13 -0500
Message-ID: <51C36A8D.3040009@ti.com>
References: <51C23902.1080301@ti.com> <20130620064541.GE5523@atomide.com> <201306202148.41464.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36211 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965660Ab3FTUsm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jun 2013 16:48:42 -0400
In-Reply-To: <201306202148.41464.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>, Vaibhav Hiremath <hvaibhav@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Mohammed Afzal <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, Roger Quadros <rogerq@ti.com>

On 6/20/2013 2:48 PM, Arnd Bergmann wrote:
> On Thursday 20 June 2013, Tony Lindgren wrote:
>> * Benoit Cousson <b-cousson@ti.com> [130619 16:10]:
>>> Hi Tony,
>>>
>>> Please pull the following commits for OMAP Device Tree for v3.11.
>>>
>>> It does contains as well 2 clock data patches, I hope it will not generate any conflict with Paul's tree.
>>>
>>> Special thanks to Florian for his nice cleanup using the C preprocessor.
>>
>> It's best that Arnd and Olof take this pull request directly as we're
>> getting so close to the merge window. These patches should be pretty
>> much independent of the other branches I've sent, and are needed to
>> keep omap4 booting now that we've flipped the switch for omap4 to be
>> DT only.
>>
>
> Would someone provide a merge description for this? I just noticed
> that it's not a signed tag, and there are lots of patches in it,
> so I'd rather not have to come up with something myself.

What about "omap devicetree changes for v3.11 merge window"
----------------------------------------------------------------
Add mandatory DT support for missing IPs, like USB host,
bandgap, LED, NAND, LAN, CPSW, PWM for OMAP and AMXX devices.
Introduce new AM43x silicon.
----------------------------------------------------------------

Regards,
Benoit


	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

