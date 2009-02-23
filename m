From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and
 L-Z)
Date: Mon, 23 Feb 2009 19:20:42 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D4297760036DEC2F71@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
	 <1234850560.13109.9.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
	 <1235396273.12653.8.camel@eenurkka-desktop>	 <49A2D66F.9050809@gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>,<782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32439 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbZBWSWM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:22:12 -0500
In-Reply-To: <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: menon.nishanth@gmail.com
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org


> But my question is this: why are we trying to a different equation
> here compared to the equation in the TRM?

Don't just blindly trust the TRM, all that matters is the real signal
caught in the scope. That is what you want to verify.

- Eero
