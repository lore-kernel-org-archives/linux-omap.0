From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and
 L-Z)
Date: Tue, 24 Feb 2009 10:43:26 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760036DEC2F77@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
	 <1234850560.13109.9.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
	 <1235396273.12653.8.camel@eenurkka-desktop>	 <49A2D66F.9050809@gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>
 <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>,<49A3B92E.9030101@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46903 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbZBXJpZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 04:45:25 -0500
In-Reply-To: <49A3B92E.9030101@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: aaro.koskinen@nokia.com, menon.nishanth@gmail.com
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org


> The problem with Eero's patch is that it changes the internal clock
> (again thanks to that confusing table). You should be able to use same
> for all modes. Also note that the noise filter is one internel clock
> period. Currently the driver uses 19.2 MHz which exceeds the I2C spec
> max. So 24 MHz would be a safer choice.

Noise filter exceeding the I2C is "a bonus provided by the device".
Should not harm any. (what they say =)

- Eero
