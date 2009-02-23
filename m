From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and L-Z)
Date: Mon, 23 Feb 2009 20:34:37 +0200
Message-ID: <782515bb0902231034w7cd51dd0s7a954abc965ca904@mail.gmail.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
	 <1235396273.12653.8.camel@eenurkka-desktop>
	 <49A2D66F.9050809@gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com>
	 <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F71@NOK-EUMSG-02.mgdnok.nokia.com>
	 <782515bb0902231025m2e0b6febj2929313db83167f3@mail.gmail.com>
	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F72@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:43930 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbZBWSel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:34:41 -0500
Received: by bwz5 with SMTP id 5so5054769bwz.13
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 10:34:37 -0800 (PST)
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760036DEC2F72@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-Eero.Nurkkala@nokia.com
Cc: r-woodruff2@ti.com, linux-omap@vger.kernel.org

On Mon, Feb 23, 2009 at 8:27 PM,  <ext-Eero.Nurkkala@nokia.com> wrote:
>
>
>> ;) Aye Aye.... I wonder if the equation you provided is based on
>> emperical measurement? if so would it vary based on electrical
>> characteristics of a platform? I mean beagleboard Vs Zoom Vs SDP
>> atleast have variances of i2c trace lengths and number of devices per
>> i2c bus.. wont the equation change based on board configuration?
>
> Nothing empirical. It's just for one board.
>
> They say it differs from board to board. I haven't had time to spend with different boards.
> They call it the "load on scl line", that makes the numbers different on other
> boards. (I'm not so sure about that, but agreed it may vary little)
>
So, it might be worth considering my following proposition?"
Now, from a s/w perspective, If we would like to have it so that we can
configure tHigh and tLow based on devices, electrical characteristics on
a bus, not just speed of the bus, the current implementation would
probably need to change(I think).
"
maybe take tHigh, tLow as a platform data input to the driver? that
could allow scaling for all boards I wonder?

Regards,
Nishanth Menon
