From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and
 L-Z)
Date: Tue, 24 Feb 2009 18:53:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8547922@dbde02.ent.ti.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
	 <1234850560.13109.9.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
	 <1235396273.12653.8.camel@eenurkka-desktop>	 <49A2D66F.9050809@gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>
 <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
 <49A3B92E.9030101@nokia.com> <49A3DD52.4020303@gmail.com>
 <49A3EC59.4040803@nokia.com>
  <13B9B4C6EF24D648824FF11BE8967162037AF5D01A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49035 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbZBXNXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 08:23:41 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037AF5D01A@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Woodruff, Richard
> Sent: Tuesday, February 24, 2009 6:47 PM
> To: Aaro Koskinen; ext Nishanth Menon
> Cc: Nurkkala Eero.An (EXT-Offcode/Oulu); linux-omap@vger.kernel.org
> Subject: RE: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and L-Z)
> 
> 
> 
> BTW, I'll reemphasize the controller bugs I pointed out last week are real and did impact a couple
> different boards.  Adding those fixes made what once would trip up after a few million near-back-to-
> back read/writes work for with out error so far.
> 
> I've not spent enough time on low/high to know anything absolutely.  It does seem like a more board
> friendly way to go but may not be required.
> 

Unlike SDP, LDP was giving errors when i2c-1 bus was set to 2600 (like spurious and some times missing keypad interrupts and such). I tested the patch and with this patch all those issues does go away.

This patch is essential to make i2c-1 bus work at error-free at 2600.

ACKing the patch.

> Regards,
> Richard W.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

